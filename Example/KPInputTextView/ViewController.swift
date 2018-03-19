//
//  ViewController.swift
//  KPInputTextView
//
//  Created by francis830227 on 03/16/2018.
//  Copyright (c) 2018 francis830227. All rights reserved.
//

import UIKit
import KPInputTextView

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
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
        
        setupTableView()
        
        // Set delegate to this controller.
        kpInputView.delegate = self
        
        // KPInputView properties
        kpInputView.maxLines = 5
        kpInputView.placeholderText = "enter text..."
        kpInputView.backgroundColor = .darkGray
    }
    
    private func setupTableView() {
        
        let margins = view.layoutMarginsGuide
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        // Add this line to activate drag_down_to_dismiss_keyboard effect.
        tableView.keyboardDismissMode = .interactive
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "12345"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}

extension ViewController: KPInputDelegate {
    
    func didSend(_ text: String) {
        // Do something after recieve text.
        print(text)
        
        // When press Send button, clear text in inputTextView.
        kpInputView.clearTextField()
    }
    
}

