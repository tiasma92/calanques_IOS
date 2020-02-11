//
//  ButtonRadius.swift
//  Les Calanques
//
//  Created by Mattias on 11/02/2020.
//  Copyright © 2020 Mattias. All rights reserved.
//

import UIKit

class ButtonRadius: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 10
    }
}
