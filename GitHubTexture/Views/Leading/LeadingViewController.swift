//
//  ViewController.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 26/02/22.
//

import UIKit
import AsyncDisplayKit

class LeadingViewController: ASDKViewController<ASDisplayNode> {

    // Title text node
    private let titleNode: ASTextNode = {
        let titleNode = ASTextNode()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 40.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        titleNode.attributedText = NSAttributedString(string: "GitHub", attributes: multipleAttributes)
        titleNode.style.alignSelf = .center
        return titleNode
    }()

    // User text node
    private let userNode: ASTextNode = {
        let userNode = ASTextNode()
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 24.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]
        userNode.attributedText = NSAttributedString(string: "User", attributes: multipleAttributes)
        userNode.style.alignSelf = .center
        return userNode
    }()

    // Button node
    private let buttonNode: ASButtonNode = {
        let buttonNode = ASButtonNode()
        buttonNode.setTitle("SEARCH", with: nil, with: .white, for: .normal)
        buttonNode.backgroundColor = .systemGreen
        buttonNode.layer.cornerRadius = 8
        let width = UIScreen.main.bounds.width
        buttonNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 44)
        return buttonNode
    }()

    private var searchNode: TextFieldNode!
    private var username: String = ""

    override init() {
        super.init(node: ASDisplayNode())
        self.searchNode = TextFieldNode(delegate: self)
        self.searchNode.textField.textAlignment = .center
        self.buttonNode.addTarget(
            self,
            action: #selector(searchButtonPressed),
            forControlEvents: .touchUpInside)
        self.node.backgroundColor = .systemBackground
        self.node.automaticallyManagesSubnodes = true
        self.node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return .init() }

            let textStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 4,
                justifyContent: .center,
                alignItems: .center,
                children: [
                    self.titleNode,
                    self.userNode
                ])

            let tfStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 30,
                justifyContent: .center,
                alignItems: .center,
                children: [
                    textStack,
                    self.searchNode
                ])

            let allStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 90,
                justifyContent: .center,
                alignItems: .center,
                children: [
                    tfStack,
                    self.buttonNode
                ])

            return ASInsetLayoutSpec(
                insets: .init(top: .infinity, left: 30, bottom: .infinity, right: 30),
                child: allStack)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc private func searchButtonPressed() {
        if !self.username.isEmpty {
            let searchVC = SearchViewController()
            searchVC.username = self.username
            navigationController?.pushViewController(searchVC, animated: false)
        } else {
            showEmptyAlert()
        }
    }

}

// MARK: - Text field delegate

extension LeadingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let username = textField.text, !username.isEmpty {
            let searchVC = SearchViewController()
            searchVC.username = username
            navigationController?.pushViewController(searchVC, animated: false)
        } else {
            showEmptyAlert()
        }
        return true
    }

    func showEmptyAlert() {
        let alert = UIAlertController(
            title: "Empty Username",
            message: "Please enter a username. We need to know who to look for 👀.",
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let username = textField.text else { return }
        self.username = username
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string == " " {
            return false
        }
        return true
    }
}
