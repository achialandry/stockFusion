//
//  MaterialDesignForStyling.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-26.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import Material

struct ButtonLayouts {
    struct Raised {
        static let width: CGFloat = 150
        static let height: CGFloat = 44
        static let offsetY: CGFloat = -75
    }
    
    func prepareRaisedButtons() {
        let button = RaisedButton(title: "Graph History", titleColor: .white)
        button.pulseColor = .white
        button.backgroundColor = Color.blue.base
        
    }
}


