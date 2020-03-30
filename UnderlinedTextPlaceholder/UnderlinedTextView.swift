//
//  UnderlinedTextView.swift
//  UnderlineText
//
//  Created by Антон Текутов on 14.02.2020.
//  Copyright © 2020 Антон Текутов. All rights reserved.
//

import UIKit

public class UnderlinedTextView: UnderlinedTextInputFrame {
    
    public var textView: PlaceholderTextView!
    
    override public var text: String? {
        get {
            textView.text
        }
        set {
            textView.text = newValue
            textFieldValueChanged()
        }
    }
    
    override func setupTextInput() {
        textView = PlaceholderTextView(hidingDelegate: self)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false

        addArrangedSubview(textView)
    }
}

// MARK: - UITextViewDelegate

extension UnderlinedTextView: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        textFieldValueChanged()
    }
}
