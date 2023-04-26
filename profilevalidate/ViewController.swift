//
//  ViewController.swift
//  profilevalidate
//
//  Created by Mohan K on 17/12/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var eTF: UITextField!
    
    @IBOutlet weak var eEr: UILabel!
    
    @IBOutlet weak var pTF: UITextField!
    
    @IBOutlet weak var pwER: UILabel!
    
    @IBOutlet weak var pnTF: UITextField!
    
    @IBOutlet weak var pnEr: UILabel!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetForm()
        submitBtn.layer.cornerRadius = 8
        
        eTF.delegate = self
        pTF.delegate = self
        pnTF.delegate = self
        
        
        let center:NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }

    
    @objc func keyboardDidShow(notification: Notification)
    {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardsize = (info[UIResponder.keyboardFrameEndUserInfoKey] as!
                            NSValue).cgRectValue
        let keyboardY = self.view.frame.height - keyboardsize.height
                    let editingTextFieldY = activeTextField.convert(activeTextField.bounds, to:self.view).minY
            if self.view.frame.minY>=0
            {
                if editingTextFieldY>keyboardY-20
                {
                    UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                        self.view.frame = CGRect(x: 0, y: self.view
                            .frame.origin.y-(editingTextFieldY-(keyboardY-50)), width: self.view.bounds.width, height: self.view.bounds.height)
                    }, completion: nil)
                }
            }
        }
    
    
    @objc func keyboardHidden(notification: Notification)
    
    {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    func resetForm(){
        submitBtn.isEnabled = false
        
        eEr.isHidden = false
        pwER.isHidden = false
        pnEr.isHidden = false
        
    }
    @IBAction func pCh(_ sender: Any) {
    }
    
    
    @IBAction func pwCh(_ sender: Any) {
    }
    
    
    
    @IBAction func pnCh(_ sender: Any) {
    }
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
}

extension ViewController:UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField:UITextField){
        switch textField{
        case self.eTF:
            self.pTF.becomeFirstResponder()
        case self.pTF:
            self.pnTF.becomeFirstResponder()
        default:
            self.pnTF.resignFirstResponder()
        }
    }
}
