//
//  FormChangeableTests.swift
//  FormChangeableTests
//
//  Created by Suguru Kishimoto on 2016/02/14.
//
//

import XCTest
@testable import FormChangeable

class MockTextFieldView: UITextField {
    deinit {
        print("deinit!!\(self)")
    }
}

class MockTextView: UITextView {
    deinit {
        print("deinit!!\(self)")
    }
}


class FormChangeableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRelations() {
        var f1 = MockTextFieldView()
        var f2 = MockTextView()
        f1.nextForm = f2
        f2.previousForm = f1
        XCTAssertNotNil(f1.nextForm)
        XCTAssertTrue(f1.nextForm! == f2)
        XCTAssertNil(f2.nextForm)
        XCTAssertNotNil(f2.previousForm)
        XCTAssertTrue(f2.previousForm! == f1)
        XCTAssertNil(f1.previousForm)
        f1.nextForm = nil
        XCTAssertNil(f1.nextForm)
        f2.previousForm = nil
        XCTAssertNil(f2.previousForm)
        
    }
    
    func testRelationsWithArray() {
        let forms: [FormChangeable] = [
            MockTextFieldView(),
            MockTextView(),
            MockTextFieldView(),
            MockTextView()
        ]
        forms.registerNextForm()
        forms.registerPreviousForm()
        forms.setNextReturnKeyType()
        forms.filter { !($0 == forms.last!) }.forEach {
            XCTAssertNotNil($0.nextForm)
            XCTAssertTrue($0.returnKeyType == .Next)
        }
        forms.filter { !($0 == forms.first!) }.forEach {
            XCTAssertNotNil($0.previousForm)
        }
        XCTAssertNil(forms.last!.nextForm)
        XCTAssertTrue(forms.last!.returnKeyType == .Done)
        XCTAssertNil(forms.first!.previousForm)
        
    }

    
}
