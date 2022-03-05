//
//  SearchResultViewController.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 05/03/22.
//

import AsyncDisplayKit

class SearchResultViewController: ASDKViewController<ASDisplayNode> {

    override init() {
        super.init(node: ASDisplayNode())
        self.node.backgroundColor = .systemGreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
