//
//  TextFieldNode.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import UIKit
import AsyncDisplayKit

class TextFieldNode: ASDisplayNode {
    weak var delegate: UITextFieldDelegate?

    init(delegate: UITextFieldDelegate?) {
        self.delegate = delegate
        super.init()
        setViewBlock {
            UITextField()
        }

        style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 44)
    }

    var textField: UITextField {
        return view as! UITextField
    }

    override func didLoad() {
        super.didLoad()
        textField.delegate = delegate
        textField.placeholder = "Type username"
        textField.returnKeyType = .search
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .asciiCapable
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
    }
}
