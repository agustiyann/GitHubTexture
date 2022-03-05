//
//  ViewController+Ext.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import Foundation
import SafariServices

extension UIViewController {

    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        safariVC.modalPresentationStyle = .pageSheet
        self.navigationController?.present(safariVC, animated: true, completion: nil)
    }
}

