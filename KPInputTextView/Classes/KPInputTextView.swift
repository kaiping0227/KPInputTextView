//
//  KPInputTextView.swift
//  KPInputTextView
//
//  Created by Kai-Ping Tseng on 2018/3/16.
//  Copyright © 2018年 Kai-Ping Tseng. All rights reserved.
//

import UIKit

public protocol KPInputDelegate: class {
    func didSend(_ text: String)
}

public class KPInputTextView: UIView {
    fileprivate let inputTextView = UITextView()
    fileprivate let sendButton = UIButton(type: .system)
    
    // TextView Settings
    open var textViewBackgroundColor = UIColor.white
    open var textViewCornerRadius: CGFloat = 10
    open var textViewBorderWidth: CGFloat = 1
    open var textViewBorderColor = UIColor.black.cgColor
    
    // Placeholder Settings
    open var placeholderText = "message..."
    open var placeholderTextColor = UIColor.lightGray
    
    // SendButton Settings
    open var sendButtonTitle = "Send"
    open var sendButtonTitleColor = UIColor.black
    open var sendButtonBackgroundColor = UIColor.red
    open var sendButtonCornerRadius: CGFloat = 7.5
    open var sendButtonFont = UIFont.boldSystemFont(ofSize: 14)
    
    open var maxLines = 6
    
    var numberOfLines = 0
    let placeholderLabel = UILabel()
    
    weak open var delegate: KPInputDelegate?
    
    override public var intrinsicContentSize: CGSize {
        let textSize = self.inputTextView.sizeThatFits(CGSize(width: self.inputTextView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        return CGSize(width: self.bounds.width, height: textSize.height)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        autoresizingMask = .flexibleHeight
        
        setupInputTextView()
        setupPlaceholderText()
        setupSendButton()
        
        inputTextView.delegate = self
        
        addSubview(inputTextView)
        addSubview(placeholderLabel)
        addSubview(sendButton)
        
        let margins = self.layoutMarginsGuide
        
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        // InputTextView layout
        inputTextView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        inputTextView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
        inputTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10).isActive = true
        if #available(iOS 11.0, *) {
            inputTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            inputTextView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 10).isActive = true
        }
        
        // PlaceholderLabel layout
        placeholderLabel.leftAnchor.constraint(equalTo: inputTextView.leftAnchor, constant: 8).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: inputTextView.topAnchor, constant: 0).isActive = true
        placeholderLabel.rightAnchor.constraint(equalTo: inputTextView.rightAnchor, constant: 0).isActive = true
        placeholderLabel.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 0).isActive = true
        
        // SendButton layout
        sendButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sendButton.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0).isActive = true
        if #available(iOS 11.0, *) {
            sendButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            sendButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10).isActive = true
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupPlaceholderText() {
        placeholderLabel.text = placeholderText
        placeholderLabel.textColor = placeholderTextColor
    }
    
    fileprivate func setupInputTextView() {
        inputTextView.backgroundColor = textViewBackgroundColor
        inputTextView.layer.cornerRadius = textViewCornerRadius
        inputTextView.layer.borderWidth = textViewBorderWidth
        inputTextView.layer.borderColor = textViewBorderColor
        inputTextView.isScrollEnabled = false
        inputTextView.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    fileprivate func setupSendButton() {
        sendButton.setTitle(sendButtonTitle, for: .normal)
        sendButton.setTitleColor(sendButtonTitleColor, for: .normal)
        sendButton.backgroundColor = sendButtonBackgroundColor
        sendButton.layer.cornerRadius = sendButtonCornerRadius
        sendButton.addTarget(self, action: #selector(sendText), for: .touchUpInside)
        sendButton.titleLabel?.font = sendButtonFont
    }
    
    @objc fileprivate func sendText() {
        guard let text = inputTextView.text, !text.isEmpty else { return }
        delegate?.didSend(text)
    }
    
    public func clearTextField() {
        inputTextView.text = nil
        placeholderLabel.isHidden = false
        
        invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }

}

extension KPInputTextView: UITextViewDelegate {
    
    func sizeOfString (string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).size
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        var textWidth = UIEdgeInsetsInsetRect(textView.frame, textView.textContainerInset).width
        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding
        guard let font = textView.font else { return false }
        let boundingRect = sizeOfString(string: newText, constrainedToWidth: Double(textWidth), font: font)
        numberOfLines = Int(boundingRect.height / font.lineHeight)
        return numberOfLines <= maxLines
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
}
