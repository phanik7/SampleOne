//
//  ViewController.swift
//  Arox
//
//  Created by apple on 12/7/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import NVActivityIndicatorView

class ViewController: UIViewController,UITextFieldDelegate,NVActivityIndicatorViewable {
    let email = String()
    let password = String()
//OUTLETS
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
// DEFAULTS METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        passwordTF.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
//Custom Methods
    func validation(){
        if emailTF.text == ""{
            alert(message: "Enter the email", title: "Alert")
        }else if passwordTF.text == ""{
            alert(message: "Enter the Password", title: "Alert")
        }else{
            let param: [String: AnyObject] = [
                "email" : emailTF.text! as AnyObject,
                "password" : passwordTF.text! as AnyObject,
                
                ]
            print(param)
            let url = "https://www.dharmani.com/Arox/Login.php"
            
                 startAnimating()
            Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers:nil)
                
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        self.stopAnimating()
                        print(response)
                        let dict = (response.value) as AnyObject
                        let status = dict.value(forKey: "status") as! Int
                        if status == 0{
                            self.alert(message: "invelid credentials", title: "Alert")
                        }
                        else{
                            self.alert(message: "login successfully", title: "Alert")
                        }
//                                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "createAccount2ViewController") as! createAccount2ViewController
                        //                        self.navigationController?.pushViewController(vc, animated: true)
                        //                    }
                        
                    case .failure(_): break
                        
                    }
            }
        }
        
        
    }
    

        
//BUTTONS
    
    @IBAction func signInWithFbBTN(_ sender: UIButton) {
    }
    
    @IBAction func SignInWithLinkDnBtn(_ sender: UIButton) {
    }
    @IBAction func signInBTN(_ sender: UIButton) {
            self.validation()
        
        
        
    }
    @IBAction func createAccountBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "createAcountVC") as! createAcountVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func forgotPasswordBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "forgotPasswordEmailVarificationVC") as! forgotPasswordEmailVarificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    
    
}
extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

