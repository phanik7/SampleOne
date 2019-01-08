//
//  createAcountVC.swift
//  Arox
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import NVActivityIndicatorView
class createAcountVC: UIViewController,UITextFieldDelegate {
    var first_name = String()
    var last_name = String()
    var email = String()
    var phone = String()
    var password = String()
    var user_id = String()
    
//OUTLETS
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var enterFirstNameTF: UITextField!
    @IBOutlet weak var enterLastNameTF: UITextField!
    @IBOutlet weak var enterEmailTF: UITextField!
    @IBOutlet weak var enterPhoneNoTF: UITextField!
    @IBOutlet weak var enterPasswordTF: UITextField!
    
//DEFAULTS METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterPhoneNoTF.delegate = self
        enterPasswordTF.delegate = self
        enterLastNameTF.delegate = self
        enterEmailTF.delegate = self
        enterFirstNameTF.delegate = self
        
        enterFirstNameTF.text = first_name
        enterEmailTF.text = email
        enterPhoneNoTF.text = phone
        enterLastNameTF.text = last_name

        
    }

   
//Custom Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == enterPasswordTF
        {
            
        guard let text = enterPasswordTF.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 16
        }
        else if textField == enterPhoneNoTF
        {
            guard let text = enterPhoneNoTF.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 16
        }
       return true
    }
    
    
    func validation(){
        
        if enterFirstNameTF.text == ""
        {
            alert(message: "Enter firstname ", title: "Alert")
        }
        else if enterLastNameTF.text == ""{
            alert(message: "Enter Lastname", title: "Alert")
        }
        else if enterEmailTF.text == ""{
            alert(message: "Enter Email", title: "Alert")
        }
        else if !isValidEmail(email: enterEmailTF.text!){
            alert(message: "Enter valid Email", title: "Alert")
        }
        else if enterPhoneNoTF.text == ""{
            alert(message: "Enter Phone number", title: "Alert")
        }else if (enterPhoneNoTF.text?.count)! < 10{
            alert(message: "Enter Valid Number", title: "Alert")
        }
        else if enterPasswordTF.text == ""{
            alert(message: "Enter Password", title: "Alert")
        }
        else if (enterPasswordTF.text?.count)! < 6 {
            alert(message: "Password Should be More then 6 Digits", title: "Alert")
        }else{
            
            let param = [ "first_name": enterFirstNameTF.text! as AnyObject,"last_name": enterLastNameTF.text! as AnyObject,"email": enterEmailTF.text! as AnyObject,"phone": enterPhoneNoTF.text! as AnyObject,"password": enterPasswordTF.text! as AnyObject, "latitude":"30.7046","longitude":"76.7179"
                
                ] as [String : Any]
            print(param)
            
            let url = Constants.createAccount
            ActivityInd.sharedActivity.startAnimating(view: self.parentView, color: .purple)
            Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers:nil)
                
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        print(response)
                        let dict = (response.value) as AnyObject
                        let status = dict.value(forKey: "status") as! Int
                        let msg = dict.value(forKey: "message") as! String
                        let idDict = dict.value(forKey: "id") as? [String:Any] ?? [:]
                        let user_id = idDict["user_id"] as? String
                        UserDefaults.standard.set(user_id, forKey: "user_id")
                        if status == 0
                        {
                            //self.alert(message: msg, title: "Alert")
                            let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
                            
                            // Create the actions
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                 self.navigationController?.popToRootViewController(animated: true)
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else {
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "createAccount2ViewController") as! createAccount2ViewController
                                vc.userid = (user_id)!
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    case .failure(_): break
                        
                    }
            }
           ActivityInd.sharedActivity.stopAnimating()
        }
     
        
    }
   
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
 
    
    
// BUTTONS
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBTN(_ sender: UIButton) {
            self.validation()
        
}
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
