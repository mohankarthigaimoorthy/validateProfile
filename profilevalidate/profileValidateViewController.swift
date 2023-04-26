//
//  profileValidateViewController.swift
//  profilevalidate
//
//  Created by Mohan K on 19/12/22.
//

import UIKit
import DTTextField

class profileValidateViewController: UITableViewController {

    @IBOutlet weak var FirstnameTxtField: DTTextField!
    @IBOutlet weak var LastnameTxtField: DTTextField!
    @IBOutlet weak var eMailTxtField: DTTextField!
    @IBOutlet weak var passWordTxtField: DTTextField!
    @IBOutlet weak var confirmPasswordTxtField: DTTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let firstNameMessage = NSLocalizedString("First name is required.", comment: "")
    let lastNameMessage = NSLocalizedString("Last name is required.", comment: "")
    let emailMessage = NSLocalizedString("Email is required.", comment: "")
    let passWordMessage = NSLocalizedString("Password  is required.", comment: "")
    let confirmPasswordMessage = NSLocalizedString("Confirm Password is required.", comment: "")
    let mismatcPasswordMessage = NSLocalizedString("Password and Confirm password are not matching .", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func onBtnsubmitClicked(_ sender: Any) {
        guard validateData() else { return }
        
        let alert = UIAlertController(title: "Congratulations", message: "Your registration is successful!!!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (cancel) in
                    DispatchQueue.main.async { self.clearForm() }
                }))
                
                present(alert, animated: true, completion: nil)
    }
    
    func clearForm() {
        self.FirstnameTxtField.text = ""
        self.LastnameTxtField.text = ""
        self.eMailTxtField.text = ""
        self.passWordTxtField.text = ""
        self.confirmPasswordTxtField.text = ""
    }
}

extension UITableViewController{
    
    @objc func keyboardWillShow(notification:Notification){
        guard ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil else {return}
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight.height, right: 0)
    }
    
    @objc func keyboardWillHide(notification:Notification){
//        tableView.contentInset = .zero
    }
    
    func validateData() -> Bool {
        guard !FirstnameTxtField.text!.isEmptyStr else {
            FirstnameTxtField.showError(message: firstNameMessage)
            return false
        }
        
        guard !LastnameTxtField.text!.isEmptyStr else {
            LastnameTxtField.showError(message: lastNameMessage)
            return false
        }
        
        guard !eMailTxtField.text!.isEmptyStr else {
            eMailTxtField.showError(message: emailMessage)
            return false
        }
        
        guard !passWordTxtField.text!.isEmptyStr else {
            passWordTxtField.showError(message: passWordMessage)
            return false
        }
        
        guard !confirmPasswordTxtField.text!.isEmptyStr else {
            confirmPasswordTxtField.showError(message: confirmPasswordMessage)
            return false
        }
        
        guard passWordTxtField.text == confirmPasswordTxtField.text else {
            confirmPasswordTxtField.showError(message: mismatcPasswordMessage)
            return false
        }
        return true
    }
}
