//
//  CalculationTest.swift
//  MVPArchitectureTests
//
//  Created by Dhaval Trivedi on 11/2/19.
//  Copyright © 2019 Dhaval Trivedi. All rights reserved.
//

import XCTest
@testable import MVPArchitecture

/* Four things to be check here
    1 - The validation of text fields, if its not valid test will failed with error code and description
    2 - Even number test
    3 - Odd number test
    4 - Expectation test for closures callback
 
    NOTE:- It is obvious that if we will do calculation(=,-,* or /) of same two value, the answer will be even or odd. So, currently if we test the whole "CalculationTest" class the test will be passed or failed at test_evenNumber() and test_oddNumber() vice versa.
*/

class CalculationTest: XCTestCase {

    private var mockView: MockViewController!
    private var presenter: Presenter!
    private var service: Service!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.mockView = MockViewController()
        self.presenter = Presenter(service: Service())
        self.service = Service()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.presenter = nil
        self.mockView = nil
        self.service = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    //MARK: - Mock view controller
    
    class MockViewController {
      //  let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let textField1 = UITextField()
        let textField2 = UITextField()
        var testError: XCTestError?
        var testType: test_type?
        var operation = Constants.Operations.add
        
        func setupView() {
            //Also try by emptying the textfield value for validation error testing
            textField1.text = "176"
            textField2.text = "14"
        }
        
        func validation() -> (Bool, String) {
            guard let txt1 = textField1.text, txt1 != "" else {
                //XCTFail("Textfield value 1 can not be empty.")
                testError = XCTestError(_nsError: NSError(domain: Constants.validationAlert.val1_invalid, code: 100, userInfo: nil))
                return (false, "Textfield value 1 can not be empty.")
            }
            guard let txt2 = textField2.text, txt2 != "" else {
                //XCTFail("Textfield value 2 can not be empty.")
                testError = XCTestError(_nsError: NSError(domain: Constants.validationAlert.val2_invalid, code: 100, userInfo: nil))
                return (false, "Textfield value 2 can not be empty.")
            }
            return (true, "All valid.")
        }
        
        //So many things you can do here for making SUT(System under test) object
    }
}

//MARK: - Test Methods

extension CalculationTest {
    
    func test_evenNumber () {
        checkMockViewWithTestType(testType: .evenTest)
    }
    
    func test_oddNumber() {
        checkMockViewWithTestType(testType: .oddTest)
    }
    
    func checkMockViewWithTestType(testType: test_type) {
        mockView.setupView()
        mockView.testType = testType
        if !mockView.validation().0 {
            //Not valid
            if mockView.testError?.code.rawValue == 100  {
                XCTFail(mockView.testError?.localizedDescription ?? "")
            }
        }
        presenter.setDelegate(delegate: self)
        presenter.calculateValue(val1: mockView.textField1.text!, val2: mockView.textField1.text!, operation: mockView.operation)
    }
    
    enum test_type {
        case evenTest
        case oddTest
    }
    
    func test_validation() {
        mockView.setupView()
        if !mockView.validation().0 {
            //Not valid
            if mockView.testError?.code.rawValue == 100  {
                XCTFail(mockView.testError?.localizedDescription ?? "")
            }
        }
    }
    
    func test_fromService() {
        
        //The main advantage of MVP that we can do testing each unit of each single class directly, i.e. Service
        //Generally XCTestExpectation is used for i.e. API call test, time out with closures
        //In Service we used "closure" for calculation completion, so it is perfect to test with expectation
        
        let expectation = XCTestExpectation(description: "Test calcuation is successfully completed.")
        mockView.setupView()
        if !mockView.validation().0 {
            //Not valid
            if mockView.testError?.code.rawValue == 100  {
                XCTFail(mockView.testError?.localizedDescription ?? "")
            }
        }
        service.calculate(val1: mockView.textField1.text!, val2: mockView.textField2.text!, operation: Constants.Operations.add) { (result) in
            //If result will be nil the test will be fail, else expectation will be fulfill.
            XCTAssertNotNil(result)
            
            expectation.fulfill()
        }
        
        // Wait until the expectation is fulfilled, with a timeout
        // If Expectation is fullfilled before 2.0 secs already, the the control goes to the next step immediatly
        
        wait(for: [expectation], timeout: 2.0)
        
        //Then
        
        print("Test completed.")
        
    }
}

extension CalculationTest: PresenterDelegate {
    
    func getAnswer(ans: String) {
        //        guard let answer = Int(ans) else {
        //            XCTFail()
        //            return
        //        }
        XCTAssertNotNil(ans)
        if mockView.testType == .init(.evenTest) {
            //Test will pass if result is even from else fail
            XCTAssert(Int(ans)! % 2 == 0)
        } else {
            //Test will pass if number is odd else fail
            XCTAssert(Int(ans)! % 2 != 0)
        }
    }
    
    func setOperation(op: String) {
         XCTAssertEqual(op, mockView.operation)
    }
    
    func changeColor(backGroundColor: UIColor, ansLableColor: UIColor) {
        
    }
    
}
