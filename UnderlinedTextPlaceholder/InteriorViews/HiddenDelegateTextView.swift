//
//  HidingDelegateTextView.swift
//  UnderlineText
//
//  Created by Антон Текутов on 14.02.2020.
//  Copyright © 2020 Антон Текутов. All rights reserved.
//

import UIKit

public class HiddenDelegateTextView: UITextView {
    
    internal weak var openDelegate: UITextViewDelegate?
    internal weak var hiddenDelegate: UITextViewDelegate?
    
    override public var delegate: UITextViewDelegate? {
        didSet {
            if (self.delegate as? HiddenDelegateTextView) != self {
                openDelegate = self.delegate
                self.delegate = self
            }
        }
    }
    
    // MARK: - Initialization
    
    convenience init(hidingDelegate: UITextViewDelegate) {
        self.init(frame: CGRect.null, textContainer: nil)
        self.hiddenDelegate = hidingDelegate
        setup()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    internal func setup() {
        delegate = self
        openDelegate = nil
    }
}

// MARK: - Covering UITextViewDelegate methods

extension HiddenDelegateTextView: UITextViewDelegate {
        
    public func textViewDidBeginEditing(_ textView: UITextView) {
        hiddenDelegate?.textViewDidBeginEditing?(textView)
        openDelegate?.textViewDidBeginEditing?(textView)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        hiddenDelegate?.textViewDidEndEditing?(textView)
        openDelegate?.textViewDidEndEditing?(textView)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        hiddenDelegate?.textViewDidChange?(textView)
        openDelegate?.textViewDidChange?(textView)
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        hiddenDelegate?.textViewDidChangeSelection?(textView)
        openDelegate?.textViewDidChangeSelection?(textView)
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let defaultValue = true
        let hiddenDelegateValue = hiddenDelegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction)
        let openDelegateValue = openDelegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction)
        return openDelegateValue ?? hiddenDelegateValue ?? defaultValue
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let defaultValue = true
        let hiddenDelegateValue = hiddenDelegate?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction)
        let openDelegateValue = openDelegate?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction)
        return openDelegateValue ?? hiddenDelegateValue ?? defaultValue
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let defaultValue = true
        let hiddenDelegateValue = hiddenDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text)
        let openDelegateValue = openDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text)
        return openDelegateValue ?? hiddenDelegateValue ?? defaultValue
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let defaultValue = true
        let hiddenDelegateValue = hiddenDelegate?.textViewShouldEndEditing?(textView)
        let openDelegateValue = openDelegate?.textViewShouldEndEditing?(textView)
        return openDelegateValue ?? hiddenDelegateValue ?? defaultValue
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let defaultValue = true
        let hiddenDelegateValue = hiddenDelegate?.textViewShouldBeginEditing?(textView)
        let openDelegateValue = openDelegate?.textViewShouldBeginEditing?(textView)
        return openDelegateValue ?? hiddenDelegateValue ?? defaultValue
    }
}
