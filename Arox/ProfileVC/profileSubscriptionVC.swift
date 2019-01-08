//
//  profileSubscriptionVC.swift
//  Arox
//
//  Created by apple on 12/19/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class profileSubscriptionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func profileSubsAccountBtnAction(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: profileVC.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }

    }
    
    @IBAction func profileSubsAboutBtnAction(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: profileAboutVC.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }

    }
    @IBAction func profileSubsInterestBtnAction(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: profileInterestVC.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }
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
