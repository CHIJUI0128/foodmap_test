import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    override func isContentValid() -> Bool { return true }
    
    override func didSelectPost() {
        if let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem {
            for attachment in extensionItem.attachments ?? [] {
                if attachment.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
                    attachment.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil) { (data, error) in
                        if let url = data as? URL, let imageData = try? Data(contentsOf: url) {
                            let appGroupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.example.foodmapTest")!
                            let targetURL = appGroupURL.appendingPathComponent("SharedImage.jpg")
                            try? imageData.write(to: targetURL)
                        }
                        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                    }
                    return
                }
            }
        }
    }
    
    override func configurationItems() -> [Any]! {
        return []
    }
}
