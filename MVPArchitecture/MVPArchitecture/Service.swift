//
//  Service.swift
//  MVPArchitecture
//
//  Created by Dhaval Trivedi on 31/10/19.
//  Copyright © 2019 Dhaval Trivedi. All rights reserved.
//

import Foundation
import UIKit

class Service {
    
    func calculate(val1: String, val2:String, operation: String, completion:((String?) -> Void)) {
        guard let v1 = Int(val1), let v2 = Int(val2) else {
            return
        }
        switch operation {
        case Constants.Operations.add:
            completion(String(v1 + v2))
            break
        case Constants.Operations.substract:
            completion(String(v1 - v2))
            break
        case Constants.Operations.multiply:
            completion(String(v1 * v2))
            break
        case Constants.Operations.devide:
            completion(String(v1 / v2))
            break
        default:
            break
        }
    }
    
    func getColorWithAns(answer: String) -> Model? {
        guard let ans = Int(answer) else {
            return nil
        }
        if ans % 2 == 0 {
            return Model(backGroundColor: UIColor.black, ansLabelColor: UIColor.white)
        } else {
            return Model(backGroundColor: UIColor.white, ansLabelColor: UIColor.black)
        }
    }

}
