//
//  profileAboutVC.swift
//  Arox
//
//  Created by apple on 12/19/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class profileAboutVC: UIViewController {
    var toStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if toStr == "interest" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "profileInterestVC") as! profileInterestVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
        else if toStr == "subscriprion"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "profileInterestVC") as! profileInterestVC
            vc.toStr = "subscriprion"
            self.navigationController?.pushViewController(vc, animated: false)
        }
        toStr = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func accountAboutVCBtnAction(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: profileVC.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
    }
    }
   
    @IBAction func interestAboutVCBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profileInterestVC") as! profileInterestVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func subcripAboutVcBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profileInterestVC") as! profileInterestVC
        vc.tostr2 = "subscriprion"
        self.navigationController?.pushViewController(vc, animated: false)

    }
    @IBAction func saveAboutVcBtnAction(_ sender: Any) {
    }
    @IBAction func cancelAboutVcBtnAction(_ sender: Any) {
    }
    @IBAction func jobDisplayBtnAction(_ sender: Any) {
    }
    @IBAction func hobbiesDisplayBtnAction(_ sender: Any) {
    }
    @IBAction func interestsDisplayBtnAction(_ sender: Any) {
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
}
