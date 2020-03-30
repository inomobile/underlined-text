//
//  UnderlinedTextView.swift
//  UnderlineText
//
//  Created by Антон Текутов on 13.02.2020.
//  Copyright © 2020 Антон Текутов. All rights reserved.
//

import UIKit

public class UnderlinedTextField: UnderlinedTextInputFrame {
    
    public let textField = UITextField()
    
    override public var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
            textFieldValueChanged()
        }
    }

    override func setupTextInput() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)

        addArrangedSubview(textField)
    }
}
