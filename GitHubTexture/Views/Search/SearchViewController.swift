//
//  SearchViewController.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import AsyncDisplayKit
import UIKit

class SearchViewController: ASDKViewController<ASDisplayNode> {

    override init() {
        super.init(node: ASDisplayNode())
        self.node.backgroundColor = .systemBackground
        title = "Search User"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
