//
//  Presenter.swift
//  MVPArchitecture
//
//  Created by Dhaval Trivedi on 31/10/19.
//  Copyright © 2019 Dhaval Trivedi. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterDelegate: NSObjectProtocol {
    func getAnswer(ans: String)
    func setOperation(op: String)
    func changeColor(backGroundColor: UIColor, ansLableColor: UIColor)
}

class Presenter {
    
    private var service = Service()
    weak private var delegate: PresenterDelegate?
    
    init(service: Service) {
        self.service = service
    }
    
    func setDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func calculateValue(val1: String, val2: String, operation: String) {
        self.service.calculate(val1: val1, val2: val2, operation: operation) { (result) in
            guard let r = result else {
                return
            }
            delegate?.setOperation(op: operation)
            delegate?.getAnswer(ans: r)
            let modelObj = self.service.getColorWithAns(answer: r)
            guard let bgColor = modelObj?.backGroundColor, let lblColor = modelObj?.ansLblColor else {
                return
            }
            delegate?.changeColor(backGroundColor: bgColor, ansLableColor: lblColor)
        }
    }
}
