//
//  ViewController.swift
//  MVPArchitecture
//
//  Created by Dhaval Trivedi on 31/10/19.
//  Copyright © 2019 Dhaval Trivedi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PresenterDelegate {

    //MARK: - IBOutlets
    
    @IBOutlet weak var btnDevide: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSubstract: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var txtAddVal1: UITextField!
    @IBOutlet weak var txtAddVal2: UITextField!
    @IBOutlet weak var txtSubstractVal1: UITextField!
    @IBOutlet weak var txtSubstractVal2: UITextField!
    @IBOutlet weak var txtMultiplyVal1: UITextField!
    @IBOutlet weak var txtMultiplyVal2: UITextField!
    @IBOutlet weak var txtDevideVal1: UITextField!
    @IBOutlet weak var txtDevideVal2: UITextField!
    @IBOutlet weak var lblAddValue: UILabel!
    @IBOutlet weak var lblSubstractValue: UILabel!
    @IBOutlet weak var lblMultiplyValue: UILabel!
    @IBOutlet weak var lblDevideValue: UILabel!
    
    //MARK: - Variables
    
    private var presenter = Presenter(service: Service())
    private var operation: String?
    
    //MARK: - ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set presenter delegate
        presenter.setDelegate(delegate: self)
    }
    
    //MARK: - Default UI Setup 
    
            /*UIChanges related code only. i.e. constraints, frames or coregraphics related code*/
    
    //MARK: - Button Actions

    @IBAction func btnAddClicked(_ sender: Any) {
        presenter.calculateValue(val1: txtAddVal1.text ?? "0", val2: txtAddVal2.text ?? "0", operation: Constants.Operations.add)
    }
    
    @IBAction func btnSubstractClicked(_ sender: Any) {
        presenter.calculateValue(val1: txtSubstractVal1.text ?? "0", val2: txtSubstractVal2.text ?? "0", operation: Constants.Operations.substract)
    }
    
    @IBAction func btnMultiplyClicked(_ sender: Any) {
        presenter.calculateValue(val1: txtMultiplyVal1.text ?? "0", val2: txtMultiplyVal2.text ?? "0", operation: Constants.Operations.multiply)
    }
    
    @IBAction func btnDevideClicked(_ sender: Any) {
        presenter.calculateValue(val1: txtDevideVal1.text ?? "0", val2: txtDevideVal2.text ?? "0", operation: Constants.Operations.devide)
    }
    
    //MARK: - PresenterDelegate methods
    
    func setOperation(op: String) {
        self.operation = op
    }
    
    func getAnswer(ans: String) {
        self.view.endEditing(true)
        guard let op = operation else {
            return
        }
        switch op {
        case Constants.Operations.add:
            lblAddValue.text = ans
            break
        case Constants.Operations.substract:
            lblSubstractValue.text = ans
            break
        case Constants.Operations.multiply:
            lblMultiplyValue.text = ans
            break
        case Constants.Operations.devide:
            lblDevideValue.text = ans
            break
        default:
            break
        }
    }
    
    func changeColor(backGroundColor: UIColor, ansLableColor: UIColor) {
        //If ans is odd the BG Color will be black, else white
        //For this logic is set in Service class
        self.view.backgroundColor = backGroundColor
    }
    
}


