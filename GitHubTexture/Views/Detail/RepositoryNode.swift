//
//  RepositoryNode.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 13/03/22.
//

import AsyncDisplayKit

final public class RepositoryNode: ASDisplayNode {

    private let repositories: Int
    private let gist: Int
    private let url: String

    private let repoTextNode: ASTextNode = {
        let repoTextNode = ASTextNode()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        repoTextNode.attributedText = NSAttributedString(string: "Public Repos", attributes: multipleAttributes)
        return repoTextNode
    }()

    private let gistTextNode: ASTextNode = {
        let gistTextNode = ASTextNode()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        gistTextNode.attributedText = NSAttributedString(string: "Public Gists", attributes: multipleAttributes)
        return gistTextNode
    }()

    private let repoCountTextNode = ASTextNode()
    private let gistsCountNode = ASTextNode()

    private let buttonNode: ASButtonNode = {
        let buttonNode = ASButtonNode()
        buttonNode.setTitle("Full GitHub Profile", with: nil, with: .white, for: .normal)
        buttonNode.backgroundColor = .systemGreen
        buttonNode.layer.cornerRadius = 8
        let width = UIScreen.main.bounds.width
        buttonNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 44)
        return buttonNode
    }()

    public init(repositories: Int, gist: Int, url: String) {
        self.repositories = repositories
        self.gist = gist
        self.url = url
        super.init()
        self.backgroundColor = .systemGray6
        self.automaticallyManagesSubnodes = true
        self.layer.cornerRadius = 10

        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        repoCountTextNode.attributedText = .init(string: "\(repositories)", attributes: multipleAttributes)
        gistsCountNode.attributedText = .init(string: "\(gist)", attributes: multipleAttributes)
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let repoStack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .center, alignItems: .center, children: [repoTextNode, repoCountTextNode])
        let gistStack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .center, alignItems: .center, children: [gistTextNode, gistsCountNode])
        let textCountStack = ASStackLayoutSpec(direction: .horizontal, spacing: 20, justifyContent: .center, alignItems: .center, children: [repoStack, gistStack])
        let finalStack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .center, alignItems: .center, children: [textCountStack, self.buttonNode])

        return ASInsetLayoutSpec(insets: .init(top: 16, left: 16, bottom: 16, right: 16), child: finalStack)
    }
}
