//
//  DetailUserViewController.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 05/03/22.
//

import AsyncDisplayKit
import UIKit

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
        let nameAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        nameNode.attributedText = NSAttributedString(string: "name", attributes: nameAttributes)
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
        return followersNode
    }()

    // followings count
    private let followingsCountNode: ASTextNode2 = {
        let followingsNode = ASTextNode2()
        return followingsNode
    }()

    // map location image
    private let locationImage: ASImageNode = {
        let locationImage = ASImageNode()
        locationImage.style.preferredSize = .init(width: 26, height: 26)
        locationImage.image = UIImage(systemName: "mappin.and.ellipse")
        locationImage.imageModificationBlock = ASImageNodeTintColorModificationBlock(.secondaryLabel)
        return locationImage
    }()

    // location text
    private let locationNode: ASTextNode2 = {
        let locationNode = ASTextNode2()
        return locationNode
    }()

    // location text
    private let bioTextNode = ASTextNode()

    // repo node
    private var repoNode: RepositoryNode

    // github since text
    private let gitHubSiceTextNode = ASTextNode()

    var viewModel = DetailUserViewModel(useCase: DetailUserUseCase())

    override init() {
        self.repoNode = RepositoryNode(repositories: 0, gist: 0, url: "")

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

            let locationStack = ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 8,
                justifyContent: .start,
                alignItems: .center,
                children: [self.locationImage, self.locationNode])

            let finalStackNode = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16,
                justifyContent: .start,
                alignItems: .start,
                children: [
                    userInfoStack,
                    locationStack,
                    self.bioTextNode,
                    self.repoNode,
                    self.gitHubSiceTextNode])

            let statusBarHeight = UIApplication.shared.connectedScenes
                    .filter {$0.activationState == .foregroundActive }
                    .map {$0 as? UIWindowScene }
                    .compactMap { $0 }
                    .first?.windows
                    .filter({ $0.isKeyWindow }).first?
                    .windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
            let topPadding = statusBarHeight + navBarHeight

            return ASInsetLayoutSpec(insets: .init(top: topPadding + 10, left: 20, bottom: 8, right: 20), child: finalStackNode)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = username
        bindViewModel()
        viewModel.didLoadUser(username: username)
    }

    private func bindViewModel() {
        viewModel.didReceiveDetail = { [weak self] in
            let detail = self?.viewModel.detail
            self?.setupUI(detail: detail)
        }

        viewModel.didReceiveError = { error in
            print(error)
        }
    }

    private func setupUI(detail: DetailUserModel?) {
        self.avatarImage.url = URL(string: detail?.avatarURL ?? "")

        let nameAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        self.nameNode.attributedText = NSAttributedString(string: detail?.name ?? "", attributes: nameAttributes)

        let followAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        self.followersCountNode.attributedText = NSAttributedString(string: "\(detail?.followers ?? 0)", attributes: followAttributes)
        self.followingsCountNode.attributedText = NSAttributedString(string: "\(detail?.following ?? 0)", attributes: followAttributes)

        let locationAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
        ]
        self.locationNode.attributedText = NSAttributedString(string: detail?.location ?? "", attributes: locationAttributes)

        let bioAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Italic", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
        ]
        self.bioTextNode.attributedText = NSAttributedString(string: detail?.bio ?? "", attributes: bioAttributes)

        self.repoNode = RepositoryNode(repositories: detail?.repositories ?? 0, gist: detail?.gists ?? 0, url: detail?.url ?? "")

        var date = detail?.created
        self.gitHubSiceTextNode.attributedText = .init(string: "GitHub since \(date?.dateFormater("MMM yyy") ?? "")", attributes: locationAttributes)
        self.gitHubSiceTextNode.style.alignSelf = .center
    }

}
