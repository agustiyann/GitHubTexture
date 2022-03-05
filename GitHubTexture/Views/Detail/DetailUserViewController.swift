//
//  DetailUserViewController.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 05/03/22.
//

import AsyncDisplayKit

class DetailUserViewController: ASDKViewController<ASDisplayNode> {

    var username: String = ""

    // avatar image
    private let avatarImage: ASNetworkImageNode = {
        let avatarImage = ASNetworkImageNode()
        avatarImage.style.preferredSize = .init(width: 100, height: 100)
        avatarImage.onDidLoad {
            $0.layer.cornerRadius = 8
        }
        return avatarImage
    }()

    // name
    private let nameNode: ASTextNode2 = {
        let nameNode = ASTextNode2()
        return nameNode
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(username)
    }

}
