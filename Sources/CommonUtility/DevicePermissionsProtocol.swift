


import Foundation
import UIKit
import AVFoundation
import Photos

protocol DevicePermissionsProtocol{
    func askForChangePermissions(_ title: String, message: String, _ cancelAction:@escaping ()->Void)
    func canAccessPhotoLibrary(for accessLevel: PHAccessLevel, isNotDetermined: Bool,  onFailure:(()->Void)?) async -> Bool
    func canAccessCamera(for mediaType: AVMediaType, isNotDetermined: Bool, onFailure: (()->Void)?)
}

extension DevicePermissionsProtocol{

    @MainActor
    func askForChangePermissions(_ title: String, message: String, _ cancelAction:@escaping ()->Void) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
            cancelAction()
        }))
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl) { (success) in
                    if AppEnvironment.isDebug{
                        print("Settings opened: \(success)")
                    }
                }
            }
        }))
        return alert
    }
    
    @available(iOS 13.0, *)
     func canAccessCamera(for mediaType: AVMediaType = .video, isNotDetermined: Bool = false, onFailure: (()->Void)? = nil) async -> Bool{ /* onFailure Clousure Maybe call on Background Thread*/
        let status = AVCaptureDevice.authorizationStatus(for:mediaType)
        switch status {
            case .authorized:
                return true
            case .denied, .restricted :
                onFailure?()
                return false
            case .notDetermined:
                if isNotDetermined{
                    onFailure?()
                    return false
                }else{
                    await AVCaptureDevice.requestAccess(for: mediaType)
                    return await canAccessCamera(for: mediaType, isNotDetermined: true, onFailure: onFailure)
                }
            default:
                return false
        }
    }
    
    @available(iOS 14.0, *)
    func canAccessPhotoLibrary(for accessLevel: PHAccessLevel = .readWrite, isNotDetermined: Bool = false,  onFailure:(()->Void)? = nil) async -> Bool{ /* onFailure Clousure Maybe call on Background Thread*/
        let status = PHPhotoLibrary.authorizationStatus(for: accessLevel)
        switch status {
            case .authorized:
                return true
            case .denied, .restricted :
                onFailure?()
                return false
            case .notDetermined:
                if isNotDetermined{
                    onFailure?()
                    return false
                }else{
                    await PHPhotoLibrary.requestAuthorization(for: accessLevel)
                    return await canAccessPhotoLibrary(for: accessLevel, isNotDetermined: true, onFailure: onFailure)
                }
            default:
                return false
        }
    }
}
