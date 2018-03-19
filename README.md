# KPInputTextView

[![CI Status](http://img.shields.io/travis/francis830227/KPInputTextView.svg?style=flat)](https://travis-ci.org/francis830227/KPInputTextView)
[![Version](https://img.shields.io/cocoapods/v/KPInputTextView.svg?style=flat)](http://cocoapods.org/pods/KPInputTextView)
[![License](https://img.shields.io/cocoapods/l/KPInputTextView.svg?style=flat)](http://cocoapods.org/pods/KPInputTextView)
[![Platform](https://img.shields.io/cocoapods/p/KPInputTextView.svg?style=flat)](http://cocoapods.org/pods/KPInputTextView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![Alt Text](https://media.giphy.com/media/6s8KRahnnGVTFc6GbC/giphy.gif)

## Requirements
* iOS 9.0+

## Installation

KPInputTextView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KPInputTextView'
```

## How To Use
```
import KPInputTextView

Class YourViewController: UIViewController {

	let kpInputView = KPInputTextView()
	
	override var inputAccessoryView: UIView? {
		get {
			return kpInputView
		}
	}
	
	override var canBecomeFirstResponder: Bool {
		return true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		kpInputView.delegate = self
		
		// Adjust kpInputView's properties here.
		kpInputView.backgroundColor = .blue
		
	}

}

extension ViewController: KPInputDelegate {
	
	func didSend(_ text: String) {
		// Do something after clicked send button.

		
		// When clicked send button, clear text in inputTextView.
		kpInputView.clearTextField()
	}
}
```
## Supported Properties
Property  | Default
------------- | -------------
backgroundColor | UIColor.lightGray
textViewBackgroundColor  | UIColor.white
textViewCornerRadius  | 10
textViewBorderWidth  | 1
textViewBorderColor  | UIColor.black.cgColor
placeholderText  | "message..."
placeholderTextColor  | UIColor.lightGray
sendButtonTitle  | "Send"
sendButtonTitleColor  | UIColor.black
sendButtonBackgroundColor  | UIColor.red
sendButtonCornerRadius  | 7.5
sendButtonFont | UIFont.boldSystemFont(ofSize: 14)
maxLines | 6

Function | Description
------------- | -------------
clearTextField() | Clear text.


## Author

Francis Tseng

francis830227@gmail.com

[LinkedIn](linkedin.com/in/francis-tseng-82b345113)  

## License

KPInputTextView is available under the MIT license. See the LICENSE file for more info.