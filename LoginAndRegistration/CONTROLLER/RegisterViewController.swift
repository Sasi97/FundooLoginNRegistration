//
//  RegisterViewController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit



class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var pswdTxtFld: UITextField!
    @IBOutlet weak var conPswdTxtFld: UITextField!
    @IBAction func didClickRegister(_ sender: Any) {
        
        if nameTxtFld.text!.isEmpty || emailTxtFld.text!.isEmpty || pswdTxtFld.text!.isEmpty || conPswdTxtFld.text!.isEmpty{
            displayAlert(userMsg: "*All Fields are Required")
        }
        else{
            if !Validation.isEmailValid(email: emailTxtFld.text!){
                displayAlert(userMsg: "Enter Valid Email")
                
            }else if !Validation.isPasswordValid(password : pswdTxtFld.text!){
                displayAlert(userMsg: "Enter Valid PassWord")
            }
            else if pswdTxtFld.text != conPswdTxtFld.text{
                displayAlert(userMsg: "PassWord Doesn't matches")
            }else if  CoreDataHelper.checkForUser(email: emailTxtFld.text!, password: pswdTxtFld.text!){
                
                print("UserExists go to login page")
                navigate()
                
            }
            else{
                CoreDataHelper.getDataFromFields(name: nameTxtFld.text!, email: emailTxtFld.text!, password: pswdTxtFld.text!)
                navigate()
            }
        }
    }
    func navigate()  {
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController else { return  }
        self.present(loginVC, animated: true)
    }
    func displayAlert(userMsg:String){
        let alert = UIAlertController(title: "***", message: userMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
