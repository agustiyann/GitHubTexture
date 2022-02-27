//
//  File.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import UIKit
import AsyncDisplayKit

class UserCellNode: ASCellNode {

    private let user: User

    private lazy var image: ASNetworkImageNode = {
        let image = ASNetworkImageNode()
        image.style.preferredSize = .init(width: 100, height: 100)
        image.onDidLoad {
            $0.layer.cornerRadius = 8
        }
        return image
    }()

    private let nameNode: ASTextNode2 = {
        let nameNode = ASTextNode2()
        nameNode.style.maxWidth = ASDimensionMake(100)
        return nameNode
    }()

    public init(user: User) {
        self.user = user
        let usernameAttr = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!]
        self.nameNode.attributedText = NSAttributedString(string: self.user.username, attributes: usernameAttr)
        self.nameNode.maximumNumberOfLines = 1
        self.nameNode.truncationMode = .byTruncatingTail
        super.init()
        self.image.url = URL(string: self.user.avatar)
        self.automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let name = ASInsetLayoutSpec(insets: .init(top: 5, left: 0, bottom: 5, right: 0), child: self.nameNode)
        let vStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [
                image,
                name
            ])
        return vStack
    }
}

