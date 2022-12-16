//
//  MainViewController+Extension.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit

//MARK: - TextField Logic
extension MainViewController {
    func connectTextField() {
        contentView.textField.addTarget(self, action: #selector(textFieldDidBegin), for: .editingDidBegin)
    }
    
    @objc func textFieldDidBegin(sender: UITextField!) {
        print(sender.text)
    }
}

//MARK: - Keyboard Hide
extension MainViewController: UITextFieldDelegate {
    func textFieldsPreferences() {
        contentView.textField.delegate = self
//        hideKeyboardWhenTappedAround()
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //hide keyboard tap return button (не забудь прокинуть делегат в cellForItemAt)
        view.endEditing(true)
        return false
    }
    
//    func hideKeyboardWhenTappedAround() { //hide keyboard tap on screen (не забудь вызвать метод во ViewDidLoad или другом методе)
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tap.cancelsTouchesInView = true
//        view.addGestureRecognizer(tap)
//    }
    
    @objc func dismissKeyboard() { //hide keyboard tap on screen
        view.endEditing(true)
    }
}

