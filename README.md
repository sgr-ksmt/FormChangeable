# FormChangeable

Easy to move from UITextField/UITextView to next UITextField/UITextView written in Swift.

## Description

Some ViewController have four forms(text field or text view) like `nameTextField`, `emailTextField`, `passwordTextField` and `profileTextView`.  
When they enter their name in and press 'Next' on the keyboard, I want this to automatically move to the next Form.  
So, I will implement like below:  

```swift
```

or,

```swift
```

...It's not very good.

- Need to check forms.
- Use tag

They are bother!!!

## solution

`FormChangeable` is resolved above problems.

- Don't have to check form anymore.
- Don't use tag.

## Usage