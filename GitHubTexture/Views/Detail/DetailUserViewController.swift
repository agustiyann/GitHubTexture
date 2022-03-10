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
        avatarImage.backgroundColor = .systemGreen
        return avatarImage
    }()

    // name
    private let nameNode: ASTextNode2 = {
        let nameNode = ASTextNode2()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        nameNode.attributedText = NSAttributedString(string: "User", attributes: multipleAttributes)
        return nameNode
    }()

    // followers
    private let followersNode: ASTextNode2 = {
        let followersNode = ASTextNode2()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        followersNode.attributedText = NSAttributedString(string: "Followers", attributes: multipleAttributes)
        return followersNode
    }()

    // followings
    private let followingsNode: ASTextNode2 = {
        let followingsNode = ASTextNode2()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        followingsNode.attributedText = NSAttributedString(string: "Followings", attributes: multipleAttributes)
        return followingsNode
    }()

    // followers count
    private let followersCountNode: ASTextNode2 = {
        let followersNode = ASTextNode2()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        followersNode.attributedText = NSAttributedString(string: "21", attributes: multipleAttributes)
        return followersNode
    }()

    // followings count
    private let followingsCountNode: ASTextNode2 = {
        let followingsNode = ASTextNode2()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        followingsNode.attributedText = NSAttributedString(string: "12", attributes: multipleAttributes)
        return followingsNode
    }()

    override init() {
        super.init(node: ASDisplayNode())
        self.node.backgroundColor = .systemBackground
        self.node.automaticallyManagesSubnodes = true
        self.node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return .init() }
            let followersStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 3,
                justifyContent: .center,
                alignItems: .center,
                children: [self.followersNode, self.followersCountNode])
            let followingsStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 3,
                justifyContent: .center,
                alignItems: .center,
                children: [self.followingsNode, self.followingsCountNode])
            let followStack = ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 30,
                justifyContent: .center,
                alignItems: .center,
                children: [followersStack, followingsStack])
            let nameStack = ASStackLayoutSpec(
                direction: .vertical, 
                spacing: 8,
                justifyContent: .center,
                alignItems: .center,
                children: [self.nameNode, followStack])
            let userInfoStack = ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 20,
                justifyContent: .start,
                alignItems: .start,
                children: [self.avatarImage, nameStack])
            let statusBarHeight = UIApplication.shared.connectedScenes
                    .filter {$0.activationState == .foregroundActive }
                    .map {$0 as? UIWindowScene }
                    .compactMap { $0 }
                    .first?.windows
                    .filter({ $0.isKeyWindow }).first?
                    .windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
            let topPadding = statusBarHeight + navBarHeight
            return ASInsetLayoutSpec(insets: .init(top: topPadding, left: 20, bottom: 8, right: 20), child: userInfoStack)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = username
    }
    
}
