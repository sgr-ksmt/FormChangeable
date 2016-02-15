//
//  FormChangeable.swift
//  FormChangeable
//
//  Created by Suguru Kishimoto on 2016/02/14.
//
//

import Foundation
import UIKit

protocol FormChangeable {
    var form: UIResponder { get }
    var nextForm: FormChangeable? { get set }
    var previousForm: FormChangeable? { get set }
    func setReturnKeyType(keyType: UIReturnKeyType)
    var returnKeyType: UIReturnKeyType { get set }
}

extension FormChangeable {
    func changeToNextForm(){
        form.resignFirstResponder()
        nextForm?.form.becomeFirstResponder()
    }
    
    func changeToPreviousForm() {
        form.resignFirstResponder()
        previousForm?.form.becomeFirstResponder()
    }
    
}

func ==(lhs: FormChangeable, rhs: FormChangeable) -> Bool {
    return lhs.form == rhs.form
}


private var previousFormKey: UInt8 = 0
private var nextFormKey: UInt8 = 0

private func getStoredObject(object: AnyObject, _ key: UnsafePointer<Void>) -> FormChangeable? {
    return objc_getAssociatedObject(object, key) as? FormChangeable
}

private func setStoredObject(object: AnyObject, _ key: UnsafePointer<Void>, _ value: FormChangeable?) {
    objc_setAssociatedObject(object, key, value as? AnyObject, .OBJC_ASSOCIATION_ASSIGN)
}

extension FormChangeable where Self: UITextField {
    var form: UIResponder {
        return self as UIResponder
    }
    
    var nextForm: FormChangeable? {
        get {
            return getStoredObject(self, &nextFormKey)
        } set {
            setStoredObject(self, &nextFormKey, newValue)
        }
    }
    
    var previousForm: FormChangeable? {
        get {
            return getStoredObject(self, &previousFormKey)
        } set {
            setStoredObject(self, &previousFormKey, newValue)
        }
    }
    
    func setReturnKeyType(keyType: UIReturnKeyType) {
        returnKeyType = keyType
    }
}

extension FormChangeable where Self: UITextView {
    var form: UIResponder {
        return self as UIResponder
    }
    
    var nextForm: FormChangeable? {
        get {
            return getStoredObject(self, &nextFormKey)
        } set {
            setStoredObject(self, &nextFormKey, newValue)
        }
    }
    
    var previousForm: FormChangeable? {
        get {
            return getStoredObject(self, &previousFormKey)
        } set {
            setStoredObject(self, &previousFormKey, newValue)
        }
    }
    
    func setReturnKeyType(keyType: UIReturnKeyType) {
        returnKeyType = keyType
    }
}

extension UITextField: FormChangeable {}
extension UITextView: FormChangeable {}

extension CollectionType where Generator.Element == FormChangeable {
    func registerNextForm() {
        var pre: FormChangeable?
        forEach {
            print(pre)
            pre?.nextForm = $0
            pre = $0
            print(pre)
        }
    }
    
    func registerPreviousForm() {
        var pre: FormChangeable?
        reverse().forEach {
            pre?.previousForm = $0
            pre = $0
        }
    }
    
    func setNextReturnKeyType(lastKeyType: UIReturnKeyType = .Done) {
        forEach { $0.setReturnKeyType(.Next) }
        reverse().first?.setReturnKeyType(lastKeyType)
    }
}
