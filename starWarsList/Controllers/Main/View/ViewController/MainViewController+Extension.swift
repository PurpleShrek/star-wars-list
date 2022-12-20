//
//  MainViewController+Extension.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit

extension MainViewController {
    func textFieldPrferences() {
        hideKeyboardWhenTappedAround()
        contentView.textField?.delegate = self
    }
    
    func textFieldEvents() {
        let textFieldPublisher = contentView.textField?.textPublisher()
        
        textFieldPublisher?
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                print("UITextField.text changed to: \(value)")
                self?.viewModel.getSearchResult(value)
            })
            .store(in: &bindings)
    }
}

extension MainViewController: UIGestureRecognizerDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //hide keyboard tap return button (не забудь прокинуть делегат в cellForItemAt)
        view.endEditing(true)
        return false
    }
    
    func hideKeyboardWhenTappedAround() { //hide keyboard tap on screen (не забудь вызвать метод во ViewDidLoad или другом методе)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() { //hide keyboard tap on screen
        view.endEditing(true)
    }
}

