//
//  UnderlinedTextinputFrame.swift
//  UnderlineText
//
//  Created by Антон Текутов on 20.02.2020.
//  Copyright © 2020 Антон Текутов. All rights reserved.
//

import UIKit

public class UnderlinedTextInputFrame: UIStackView {
    
    public let topInfoLabel = UILabel()
    public let line = HorizontalLine()
    public let errorLabel = UILabel()
    
    public var text: String?
    
    public var animationDuration: TimeInterval = 0.5
    public var startEditingAnimation: (() -> Void)!
    public var finishEditingAnimation: (() -> Void)!
    public var errorAnimation: (() -> Void)!
    public var errorHideAnimation: (() -> Void)!
    
    public var defaultBottomColor = UIColor.systemGray
    public var errorBottomColor = UIColor.red
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - public functions
    
    public func showError(_ errorText: String? = nil) {
        if errorText != nil {
            errorLabel.text = errorText 
        } 
        UIView.animate(withDuration: animationDuration, animations: {
            self.errorAnimation()
        })
    }
    
    public func hideError() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.errorHideAnimation()
        })
    }
    
    // MARK: - setup
        
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        startEditingAnimation = defaultStartEditingAnimation
        finishEditingAnimation = defaultFinishEditingAnimation
        errorAnimation = defaultErrorAnimation
        errorHideAnimation = defaultErrorHideAnimation
        
        setupTopInfoLabel()
        setupTextInput()
        setupLine()
        setuErrorLabel()
    }
    
    private func setupTopInfoLabel() {
        topInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        topInfoLabel.alpha = 0
        addArrangedSubview(topInfoLabel)
    }
    
    internal func setupTextInput() {
        
    }
    
    private func setupLine() {
        line.backgroundColor = defaultBottomColor
        line.lineThickness = 2
        addArrangedSubview(line)
    }
    
    private func setuErrorLabel() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.alpha = 0
        addArrangedSubview(errorLabel)
    }
    
    // MARK: - editing actions
    
    @objc internal func textFieldValueChanged() {
        UIView.animate(withDuration: animationDuration, animations: {
            if self.text?.isEmpty ?? true {
                self.finishEditingAnimation()
            } else {
                self.startEditingAnimation()
            }
        })
    }
    
    // MARK: - default animations
    
    private func defaultStartEditingAnimation() {
        topInfoLabel.alpha = 1
    }
    
    private func defaultFinishEditingAnimation() {
        topInfoLabel.alpha = 0
    }
    
    private func defaultErrorAnimation() {
        line.backgroundColor = errorBottomColor
        errorLabel.textColor = errorBottomColor
        errorLabel.alpha = 1
    }
    
    private func defaultErrorHideAnimation() {
        line.backgroundColor = defaultBottomColor
        errorLabel.alpha = 0
    }
}

