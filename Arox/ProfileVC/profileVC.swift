//
//  profileVC.swift
//  Arox
//
//  Created by apple on 12/17/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire


class profileVC: UIViewController {
    
var userid = String()
    
//OUTLETS
    @IBOutlet weak var enterFirstNameAccountVCTF: UITextField!
    
    @IBOutlet weak var enterLastNameAccountVCTF: UITextField!
    
    @IBOutlet weak var enterEmailAccountVCTF: UITextField!
    
    @IBOutlet weak var enterPhoneNoAccountVCTF: UITextField!
    
    @IBOutlet weak var enterAgeAccountVCTF: UITextField!
    
    @IBOutlet weak var enterHeightAccountVCTF: UITextField!
    
    @IBOutlet weak var legalViewAccountOL: UIView!
    @IBOutlet weak var stockyBtnOL: UIButton!
    @IBOutlet weak var slimBtnOL: UIButton!
    @IBOutlet weak var averageBtnOL: UIButton!
    @IBOutlet weak var athleticBtnOL: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

//DEFAULTS METHODS
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//BUTTON ACTIONS
    
 
    
    @IBAction func aboutAccountProfileBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profileAboutVC") as! profileAboutVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func interestAccountProfileBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profileAboutVC") as! profileAboutVC
        vc.toStr = "interest"
        self.navigationController?.pushViewController(vc, animated: false)

    }
    @IBAction func subscriptionAccountProfileBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profileAboutVC") as! profileAboutVC
        vc.toStr = "subscriprion"
        self.navigationController?.pushViewController(vc, animated: false)

    }
    @IBAction func stockyBtnAction(_ sender: UIButton) {
        if sender.tag == 0{
            stockyBtnOL.setImage(UIImage(named: "sl"), for: .normal)
            stockyBtnOL.tag = 1
        }else{
            stockyBtnOL.setImage(UIImage(named: "sto"), for: .normal)
            stockyBtnOL.tag = 0
        }
    }
    @IBAction func averageBtnAction(_ sender: UIButton) {
        if sender.tag == 0{
            averageBtnOL.setImage(UIImage(named: "aver"), for: .normal)
            averageBtnOL.tag = 1
        }else{
            averageBtnOL.setImage(UIImage(named: "average"), for: .normal)
            averageBtnOL.tag = 0
        }
    }
    @IBAction func athleticBtnAction(_ sender: UIButton) {
        if sender.tag == 0{
            athleticBtnOL.setImage(UIImage(named: "ath"), for: .normal)
            athleticBtnOL.tag = 1
        }else{
            athleticBtnOL.setImage(UIImage(named: "athle"), for: .normal)
            athleticBtnOL.tag = 0
        }
    }
    @IBAction func slimBtnAction(_ sender: UIButton) {
        if sender.tag == 0{
            slimBtnOL.setImage(UIImage(named: "slim"), for: .normal)
            slimBtnOL.tag = 1
        }else{
            slimBtnOL.setImage(UIImage(named: "slim1"), for: .normal)
            slimBtnOL.tag = 0
        }
    }
    @IBAction func legalsupportBtnAction(_ sender: Any) {
        legalViewAccountOL.isHidden = false
        
    }
    @IBAction func saveprofileAccountBtnAction(_ sender: Any) {
    }
    
    
    @IBAction func cancelprofileAccountBtnAction(_ sender: Any) {
    }
    
    @IBAction func LegalprofileDoneAccountBtnAction(_ sender: Any) {
        legalViewAccountOL.isHidden = true
    }
    @IBAction func profileLogOutBtnAction(_ sender: Any) {
            let alert = UIAlertController(title:"Arox" , message: "Are You Sure To Want Logout", preferredStyle: .alert) // 7
            let okAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
                
         
                UserDefaults.standard.set(nil, forKey: "user_id")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.logOutSuccess()

            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
            }

            alert.addAction(okAction)
             alert.addAction(cancelAction)
            self.present(alert, animated: true, completion:nil)

        }

    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


