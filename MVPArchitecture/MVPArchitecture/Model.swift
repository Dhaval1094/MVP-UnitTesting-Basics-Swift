//
//  Model.swift
//  MVPArchitecture
//
//  Created by Dhaval Trivedi on 31/10/19.
//  Copyright © 2019 Dhaval Trivedi. All rights reserved.
//

import UIKit

class Model {
    var backGroundColor: UIColor?
    var ansLblColor: UIColor?
    
    init(backGroundColor: UIColor, ansLabelColor: UIColor) {
        self.backGroundColor = backGroundColor
        self.ansLblColor = ansLabelColor
    }
}
