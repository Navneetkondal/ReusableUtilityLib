//
//  ScreenSecurityManager.swift
//  ReusableUtilityLib
//
//  Created by Navneet on 14/07/26.
//

import UIKit

@MainActor
public final class ScreenSecurityManager {
        
    public static let shared = ScreenSecurityManager()
    private init() {}
        
    private var observers: [NSObjectProtocol] = []
    private var recordingWindow: UIWindow?
    private var privacyWindow: UIWindow?
    
    public var onScreenshotTaken: (() -> Void)?
    
    public var isScreenBeingRecorded: Bool {
        UIScreen.main.isCaptured
    }
    
    public func startProtection(blurStyle: UIBlurEffect.Style = .systemUltraThinMaterialDark) {
        stopProtection()
        observeScreenshot()
        observeScreenRecording(blurStyle: blurStyle)
        observeAppLifecycle(blurStyle: blurStyle)
        
        if isScreenBeingRecorded {
            showRecordingOverlay(blurStyle: blurStyle)
        }
    }
    
    public func stopProtection() {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
        observers.removeAll()
        removeRecordingOverlay()
        removePrivacyOverlay()
    }
}

private extension ScreenSecurityManager {
    
    func observeScreenshot() {
        let observer = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification,
                                                              object: nil,
                                                              queue: nil) { [weak self] _ in
            MainActor.assumeIsolated {
                self?.onScreenshotTaken?()
            }
        }
        observers.append(observer)
    }
}

private extension ScreenSecurityManager {
    
    func observeScreenRecording(blurStyle: UIBlurEffect.Style) {
        let observer = NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification,
                                                              object: nil,
                                                              queue: nil) { [weak self] _ in
            MainActor.assumeIsolated {
                guard let self else { return }
                if self.isScreenBeingRecorded {
                    self.showRecordingOverlay(blurStyle: blurStyle)
                } else {
                    self.removeRecordingOverlay()
                }
            }
        }
        observers.append(observer)
    }
}

private extension ScreenSecurityManager {
    
    func observeAppLifecycle(blurStyle: UIBlurEffect.Style) {
        let backgroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification,
                                                                        object: nil,
                                                                        queue: nil) { [weak self] _ in
            MainActor.assumeIsolated {
                self?.showPrivacyOverlay(blurStyle: blurStyle)
            }
        }
        observers.append(backgroundObserver)
        
        let foregroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification,
                                                                        object: nil,
                                                                        queue: nil) { [weak self] _ in
            MainActor.assumeIsolated {
                self?.removePrivacyOverlay()
            }
        }
        observers.append(foregroundObserver)
    }
}

private extension ScreenSecurityManager {
    
    func activeScene() -> UIWindowScene? {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        return scenes.first { $0.activationState == .foregroundActive } ?? scenes.first { $0.activationState == .foregroundInactive }
    }
    
    func createOverlayWindow(blurStyle: UIBlurEffect.Style, message: String? = nil) -> UIWindow? {
        guard let scene = activeScene() else { return nil }
        
        let window = UIWindow(windowScene: scene)
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        
        let sceneBounds = scene.coordinateSpace.bounds
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        blurView.frame = sceneBounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.view.addSubview(blurView)
        
        if let message {
            let label = UILabel()
            label.text = message
            label.textColor = .white
            label.font = .systemFont(ofSize: 18, weight: .semibold)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            blurView.contentView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
                label.leadingAnchor.constraint(greaterThanOrEqualTo: blurView.contentView.leadingAnchor, constant: 24),
                label.trailingAnchor.constraint(lessThanOrEqualTo: blurView.contentView.trailingAnchor, constant: -24)
            ])
        }
        
        window.rootViewController = controller
        return window
    }
        
    func showRecordingOverlay(blurStyle: UIBlurEffect.Style) {
        guard recordingWindow == nil else { return }
        recordingWindow = createOverlayWindow(blurStyle: blurStyle, message: "🔒 Screen Recording Not Allowed")
        recordingWindow?.windowLevel = .statusBar + 1
        recordingWindow?.makeKeyAndVisible()
    }
    
    func removeRecordingOverlay() {
        recordingWindow?.resignKey()
        recordingWindow?.isHidden = true
        recordingWindow = nil
    }
    
    
    func showPrivacyOverlay(blurStyle: UIBlurEffect.Style) {
        guard privacyWindow == nil else { return }
        privacyWindow = createOverlayWindow(blurStyle: blurStyle)
        privacyWindow?.windowLevel = .statusBar + 1
        privacyWindow?.makeKeyAndVisible()
    }
    
    func removePrivacyOverlay() {
        privacyWindow?.resignKey()
        privacyWindow?.isHidden = true
        privacyWindow = nil
    }
}

