import Foundation
import UIKit

public struct ExampleTelegramPickerLocalizer: TelegramPickerResourceProvider {
    
    public func localized(buttonType: LocalizableButtonType) -> String {
        switch buttonType {
        case .photoOrVideo: return "Photo or Video"
        case .file: return "File"
        case .location: return "Location"
        case .contact: return "Contact"
        case .photos(count: let count): return "Send \(count) \(count == 1 ? "Photo" : "Photos")"
        case .videos(count: let count): return "Send \(count) \(count == 1 ? "Video" : "Videos")"
        case .medias(count: let count): return "Send \(count) \(count == 1 ? "Media" : "Medias")"
        case .sendDocumentAsFile: return "Document"
        case .sendPhotoAsFile(count: let count): return "Send as \(count == 1 ? "File" : "Files")"
        case .addContact: return "Add Contact"
        }
    }
    
    public func localizedAlert(failure: Failure) -> UIAlertController? {
        switch failure {
        case .noAccessToCamera: return noCameraAccessAlert()
        case .noAccessToPhoto: return noPhotosAccessAlert()
        case .error(let error): return failureAlert(error)
        }
    }
    
    private func noCameraAccessAlert() -> UIAlertController {
        /// User has denied the current app to access the camera.
        let productName = Bundle.main.dlgpicker_appName
        let alert = UIAlertController(title: "Permission denied", message: "\(productName) does not have access to camera. Please, allow the application to access to camera.", preferredStyle: .alert)
        alert.addAction(title: "Settings", style: .destructive) { action in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }
        alert.addAction(title: "OK", style: .cancel)
        return alert
    }
    
    private func noPhotosAccessAlert() -> UIAlertController {
        /// User has denied the current app to access the contacts.
        let productName = Bundle.main.dlgpicker_appName
        let alert = UIAlertController(title: "Permission denied", message: "\(productName) does not have access to contacts. Please, allow the application to access to your photo library.", preferredStyle: .alert)
        alert.addAction(title: "Settings", style: .destructive) { action in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }
        alert.addAction(title: "OK", style: .cancel)
        return alert
    }
    
    private func failureAlert(_ error: Error) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(title: "OK")
        return alert
    }
    
    public func resourceProviderForLocationPicker() -> LocationPickerViewControllerResourceProvider? {
        return nil
    }
    
}
