//
//  PlaceholderTextView.swift
//  UnderlineText
//
//  Created by Антон Текутов on 20.02.2020.
//  Copyright © 2020 Антон Текутов. All rights reserved.
//

import UIKit

public class PlaceholderTextView: HiddenDelegateTextView {
    
    override public var text: String? {
        didSet {
            placeholderLabel.isHidden = !(text?.isEmpty ?? true)
        }
    }
    override public var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }
    override public var contentInset: UIEdgeInsets {
        didSet {
            updatePlaceholderConstraints()
        }
    }
    
    private let placeholderLabel = UILabel()
    private let placeholderInset: CGFloat = 6
    private var placeholderLeadingConstraint: NSLayoutConstraint!
    private var placeholderTrailingConstraint: NSLayoutConstraint!
    private var placeholderTopConstraint: NSLayoutConstraint!
    private var placeholderBottomConstraint: NSLayoutConstraint!
    
    public var placeholder: String? {
        get {
            placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
        }
    }
    
    // MARK: - Initialization
    
    override func setup() {
        delegate = self
        openDelegate = nil
        
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        font = placeholderLabel.font
        if #available(iOS 13.0, *) {
            placeholderLabel.textColor = UIColor.systemGray2
        } else {
            placeholderLabel.textColor = UIColor.systemGray
        }
        placeholderLabel.isHidden = !(text?.isEmpty ?? true)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        placeholderLeadingConstraint = placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: placeholderInset)
        placeholderTrailingConstraint = placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        placeholderTopConstraint = placeholderLabel.topAnchor.constraint(equalTo: topAnchor)
        placeholderBottomConstraint = placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeholderLeadingConstraint,
            placeholderTrailingConstraint,
            placeholderTopConstraint,
            placeholderBottomConstraint
        ])
    }
    
    private func updatePlaceholderConstraints() {
        placeholderLeadingConstraint.constant = contentInset.left + placeholderInset
        placeholderTrailingConstraint.constant = contentInset.right
        placeholderTopConstraint.constant = contentInset.top
        placeholderBottomConstraint.constant = contentInset.bottom
    }
}

// MARK: - UITextViewDelegate

extension PlaceholderTextView {
    
    override public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        hiddenDelegate?.textViewDidChange?(textView)
        openDelegate?.textViewDidChange?(textView)
    }
}

