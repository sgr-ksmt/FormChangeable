//
//  ViewController.swift
//  Demo
//
//  Created by Suguru Kishimoto on 2016/02/20.
//
//

import UIKit
import FormChangeable

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet private weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet private weak var mailTextField: UITextField! {
        didSet {
            mailTextField.delegate = self
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    @IBOutlet private weak var profileTextView: UITextView! {
        didSet {
            profileTextView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        nameTextField.nextForm = mailTextField
//        mailTextField.nextForm = passwordTextField
//        passwordTextField.nextForm = profileTextView
        let forms: [FormChangeable] = [nameTextField, mailTextField, passwordTextField, profileTextView]
        forms.registerNextForm()
        forms.setNextReturnKeyType()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.changeToNextForm()
        return false
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.changeToNextForm()
            return false
        }
        return true
    }
    

}

