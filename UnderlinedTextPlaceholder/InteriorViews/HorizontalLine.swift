//
//  HorizontalLine.swift
//  UnderlineText
//
//  Created by Антон Текутов on 14.02.2020.
//  Copyright © 2020 Антон Текутов. All rights reserved.
//

import UIKit

public class HorizontalLine: UIView {
    
    public var lineThickness: CGFloat {
        get {
            return lineHeightAnchor.constant
        }
        set {
            lineHeightAnchor.constant = newValue
        }
    }
    
    private var lineHeightAnchor: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        lineHeightAnchor = heightAnchor.constraint(equalToConstant: 1)
        lineHeightAnchor?.isActive = true
    }	
}
