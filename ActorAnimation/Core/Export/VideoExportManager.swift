import Foundation
import Combine
import UIKit
import ReplayKit
import SwiftUI

enum RecordingState: Equatable {
    case idle
    case recording
    case processing
    case completed
    case failed(String)
}

@MainActor
final class VideoExportManager: NSObject, ObservableObject {
    @Published var state: RecordingState = .idle

    var isRecording: Bool {
        if case .recording = state { return true }
        return false
    }

    var isProcessing: Bool {
        if case .processing = state { return true }
        return false
    }

    var errorMessage: String? {
        if case .failed(let msg) = state { return msg }
        return nil
    }

    private var processingTimeout: Task<Void, Never>?

    func startRecording() {
        #if targetEnvironment(simulator)
        state = .failed("Video recording is not supported on the iOS Simulator. Please run on a physical device to test this feature.")
        return
        #else
        guard RPScreenRecorder.shared().isAvailable else {
            state = .failed("Screen recording is not available on this device.")
            return
        }

        state = .processing
        RPScreenRecorder.shared().isMicrophoneEnabled = false
        RPScreenRecorder.shared().startRecording { [weak self] error in
            Task { @MainActor in
                if let error {
                    self?.state = .failed(error.localizedDescription)
                } else {
                    self?.state = .recording
                }
            }
        }
        #endif
    }

    func stopRecording() {
        guard case .recording = state else { return }
        state = .processing
        startProcessingTimeout()

        #if !targetEnvironment(simulator)
        RPScreenRecorder.shared().stopRecording { [weak self] previewVC, error in
            Task { @MainActor in
                guard let self else { return }
                self.cancelProcessingTimeout()
                if let error {
                    self.state = .failed(error.localizedDescription)
                    return
                }
                if let previewVC {
                    self.presentPreview(previewVC)
                } else {
                    self.state = .failed("Recording produced no video. Try recording for a longer duration.")
                }
            }
        }
        #endif
    }

    func cancelRecording() {
        guard case .recording = state else { return }
        cancelProcessingTimeout()
        #if !targetEnvironment(simulator)
        RPScreenRecorder.shared().stopRecording { [weak self] _, _ in
            Task { @MainActor in
                self?.state = .idle
            }
        }
        #else
        state = .idle
        #endif
    }

    private func startProcessingTimeout() {
        cancelProcessingTimeout()
        processingTimeout = Task { @MainActor in
            try? await Task.sleep(nanoseconds: 15_000_000_000)
            if case .processing = self.state {
                self.state = .failed("Recording timed out. Please try again.")
            }
        }
    }

    private func cancelProcessingTimeout() {
        processingTimeout?.cancel()
        processingTimeout = nil
    }

    private func presentPreview(_ previewVC: RPPreviewViewController) {
        guard let topVC = Self.topMostViewController() else {
            state = .failed("Unable to present video preview.")
            return
        }

        previewVC.previewControllerDelegate = self
        previewVC.modalPresentationStyle = .fullScreen
        topVC.present(previewVC, animated: true)
    }

    private static func topMostViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let window = scene.windows.first(where: { $0.isKeyWindow }) ?? scene.windows.first,
              let root = window.rootViewController else { return nil }

        var top = root
        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }

    func reset() {
        cancelProcessingTimeout()
        state = .idle
    }
}

extension VideoExportManager: RPPreviewViewControllerDelegate {
    nonisolated func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        Task { @MainActor in
            previewController.dismiss(animated: true)
            state = .completed
        }
    }

    nonisolated func previewController(_ previewController: RPPreviewViewController, didFinishSavingActivity activityTypes: Set<UIActivity.ActivityType>?, error: Error?) {
        Task { @MainActor in
            if let error {
                state = .failed(error.localizedDescription)
            } else {
                state = .completed
            }
            previewController.dismiss(animated: true)
        }
    }
}
