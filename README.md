# FormChangeable

![Language](https://img.shields.io/badge/language-Swift%202%2B-orange.svg)
[![Xcode](https://img.shields.io/badge/Xcode-7.0%2B-brightgreen.svg?style=flat)]()
[![iOS](https://img.shields.io/badge/iOS-8.0%2B-brightgreen.svg?style=flat)]()
[![Build Status](https://travis-ci.org/sgr-ksmt/FormChangeable.svg?branch=master)](https://travis-ci.org/sgr-ksmt/FormChangeable)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](https://img.shields.io/cocoapods/v/FormChangeable.svg?style=flat)](http://cocoapods.org/pods/FormChangeable)


Easy to move from UITextField/UITextView to next UITextField/UITextView written in Swift.

## Description

Some ViewController have four forms(text field or text view) like `nameTextField`, `emailTextField`, `passwordTextField` and `profileTextView`.  
When they enter their name in and press 'Next' on the keyboard, I want this to automatically move to the next Form.  
So, I will implement like below:  

```swift
class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var profileTextView: UITextView!

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == nameTextField {
            mailTextField.becomeFirstResponder()
        } else if textField == mailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            profileTextView.becomeFirstResponder()
        } else {
            return true
        }
        return false
    }
}
```

or,

```swift
class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    private var textfields = [UITextField]()

    override func viewDidLoad() {
        super.viewDidLoad()
        textfields += [nameTextField, mailTextField, passwordTextField]
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let tag = textField.tag
        let nextIndex = tag + 1
        if nextIndex < textfields.count {
            textfields[nextIndex].becomeFirstResponder()
            return false
        }
        return true
    }
}
```

<font size=4>***...It's not very good.***</font>

##### Problems

- Need to check forms. 😞
- Use tag...😞

They are bother!!!

## Solution

`FormChangeable` can resolve these problems.

### Feature

- Don't have to check form anymore.
- Don't use tag.
- No complex settings.
- Can move both `UITextFIeld` and `UITextView`
- Move to next/prev form if next/prev form exists.<br />
If next/prev form don't exists, only close keyboard in current form.

## Usage

- [1] setup next/prev form

```swift
import FormChangeable

class ViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var profileTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.nextForm = mailTextField
        mailTextField.nextForm = passwordTextField
        passwordTextField.nextForm = profileTextView
    }
}
```

or,

```swift
import FormChangeable

class ViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var profileTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let forms: [FormChangeable] = [nameTextField, mailTextField, passwordTextField, profileTextView]
        forms.registerNextForm()
    }
}
```

- [2] Implement `UITextFieldDelegate`'s *func textFieldShouldReturn(textField:)*
- [3] Implement `UITextViewDelegate`s *func textView(textView:, shouldChangeTextInRange:, replacementText:)*

```swift
class ViewController: UIViewController, UITextFieldDelegate {
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
```

## Requirements
- iOS 8.0+
- Xcode 7.0+(Swift 2+)

## Installation

### Carthage

- Add the following to your *Cartfile*:

```bash
github 'sgr-ksmt/FormChangeable' ~> 1.0
```

- Run `carthage update`
- Add the framework as described.
<br> Details: [Carthage Readme](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)


### CocoaPods

**FormChangeable** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FormChangeable', '~> 1.0'
```

and run `pod install`


## Communication
- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request.:muscle:

## License

**FormChangeable** is under MIT license. See the [LICENSE](LICENSE) file for more info.