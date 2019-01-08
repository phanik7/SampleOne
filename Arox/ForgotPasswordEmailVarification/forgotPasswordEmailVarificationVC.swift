//
//  forgotPasswordEmailVarificationVC.swift
//  Arox
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import  Alamofire

class forgotPasswordEmailVarificationVC: UIViewController {
    
//forgotpasswordemailvarification outlets
    @IBOutlet weak var emailViewOL: UIView!
    @IBOutlet weak var enterEmailTF: UITextField!
    
//checkEmail Outlets
    @IBOutlet weak var checkEmailViewOL: UIView!
    
// verificationCode Outlets
    @IBOutlet weak var verificationCodeViewOL: UIView!
    @IBOutlet weak var verificationCodeTF: UITextField!
    
// createPassword Outlets
    @IBOutlet weak var createPasswordViewOL: UIView!
    @IBOutlet weak var createPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
// ResetPassword Outlets
    @IBOutlet weak var ResetPasswordViewOL: UIView!
    
//Defaults Methods
    override func viewDidLoad() {
        super.viewDidLoad()
     
     }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    
  
//email verified Actions
    @IBAction func emailNextBtnAction(_ sender: UIButton) {
      if enterEmailTF.text == ""{
            alert(message: "Please Enter Your Registered Email", title: "Arox")
        }
        let param = ["email":enterEmailTF.text! as AnyObject]
        let url = Constants.forgotPasswordCheckEmail

        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers:nil)

            .responseJSON { response in
                switch response.result {
                case .success:
                    print(response)
                    let dict = (response.value) as AnyObject
                    let status = dict.value(forKey: "status") as! Int
                    let msg = dict.value(forKey: "message") as! String
                    if status == 0{
                        self.alert(message: msg, title: "Arox")
                    }else{
                        self.emailViewOL.isHidden = true
                        self.verificationCodeViewOL.isHidden = true
                        self.checkEmailViewOL.isHidden = false
                        self.createPasswordViewOL.isHidden = true
                        self.ResetPasswordViewOL.isHidden = true
                    }
                case .failure(_): break

                }
        }
        
    }
    @IBAction func emailCancelBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//checkEmail Actions
    @IBAction func checkEmailNextBtnAction(_ sender: UIButton) {
        emailViewOL.isHidden = true
        verificationCodeViewOL.isHidden = false
        checkEmailViewOL.isHidden = true
        createPasswordViewOL.isHidden = true
        ResetPasswordViewOL.isHidden = true
    }
    @IBAction func checkEmailCancelBtnAction(_ sender: UIButton) {
       self.navigationController?.popViewController(animated: true)
    }
    
//verificationCode Actions
    @IBAction func verificationCodeNextBtnAction(_ sender: UIButton) {
        emailViewOL.isHidden = true
        verificationCodeViewOL.isHidden = true
        checkEmailViewOL.isHidden = true
        createPasswordViewOL.isHidden = false
        ResetPasswordViewOL.isHidden = true
    }
    @IBAction func verificationCodeCancelBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//createPassword Actions
    @IBAction func createPasswordSubmitBtnAction(_ sender: UIButton) {
        emailViewOL.isHidden = true
        verificationCodeViewOL.isHidden = true
        checkEmailViewOL.isHidden = true
        createPasswordViewOL.isHidden = true
        ResetPasswordViewOL.isHidden = false
    }
    
    @IBAction func createPasswordCancelBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//ResetPassword Actions
    @IBAction func ResetPasswordDoneBtnAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



