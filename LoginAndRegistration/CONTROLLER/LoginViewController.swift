//
//  LoginViewController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var pswdTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func displayAlert(userMsg:String) {
        let alert = UIAlertController(title: "***", message: userMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func didClickLogin(_ sender: Any) {
        if emailTxtFld.text!.isEmpty || pswdTxtFld.text!.isEmpty {
            displayAlert(userMsg: "*All Fileds are Required")
        }
        else{
            if Validation.isEmailValid(email: emailTxtFld.text ?? "") && Validation.isPasswordValid(password: pswdTxtFld.text ?? ""){
                CoreDataHelper.checkForUser( email: emailTxtFld.text!, password: pswdTxtFld.text! )
                if let dashBoardVC = UIStoryboard(name: "DashBoard", bundle: nil).instantiateViewController(withIdentifier: "dashBoardVC") as? ContainerVC {
                    self.present(dashBoardVC, animated: true)}
                
                
            }else{
                displayAlert(userMsg: "Email or Password is Incorrect ")
            }
        }
    }
    @IBAction func didClickSignIn(_ sender: Any) {
        guard let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "registerVC") as? RegisterViewController else { return  }
        self.present(registerVC, animated: true)
    }
   
  
}
