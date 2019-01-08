//
//  profileInterestVC.swift
//  Arox
//
//  Created by apple on 12/19/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class profileInterestVC: UIViewController {
     var toStr = ""
    var tostr2 = ""
 //outlets
    @IBOutlet weak var heightlblOL: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var womenMenchangeImgOLInterest: UIImageView!
    @IBOutlet weak var ageRangeSlider: RangeSeekSlider!
    @IBOutlet weak var heightRangeSlider: RangeSeekSlider!
    @IBOutlet weak var slimLblOL: UILabel!
    @IBOutlet weak var slimImgOL: UIImageView!
    @IBOutlet weak var athleticImgOL: UIImageView!
    @IBOutlet weak var athleticLblOL: UILabel!
    @IBOutlet weak var stockyLblOL: UILabel!
    @IBOutlet weak var averageLblOL: UILabel!
    @IBOutlet weak var averageImgOL: UIImageView!
    @IBOutlet weak var stockyImgOL: UIImageView!
   
    
 //default methods
    override func viewDidLoad() {
        super.viewDidLoad()
       ageRangeSlider.delegate = self
       heightRangeSlider.delegate = self
        // Do any additional setup after loading the view.
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if toStr == "subscriprion"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "profileSubscriptionVC") as! profileSubscriptionVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
        if tostr2 == "subscriprion"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "profileSubscriptionVC") as! profileSubscriptionVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
        toStr = ""
        tostr2 = ""
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//Buttons
    @IBAction func menInterestBtnAction(_ sender: Any) {

        let image = UIImage.init(named: "men")
                womenMenchangeImgOLInterest.image = image
    
        
    }
    @IBAction func womenInterestBtnAction(_ sender: Any) {
        let image = UIImage.init(named: "women")
        womenMenchangeImgOLInterest.image = image
        
    }
    
    @IBAction func slimBtnAction(_ sender: UIButton) {
        if sender.tag == 0
        {
            slimImgOL.image = UIImage(named: "Shapetick")
            slimLblOL.textColor = UIColor(red: 144/255.0, green: 29/255.0, blue: 114/255.0, alpha: 1)
            sender.tag = 1
        }else{
              slimImgOL.image = UIImage(named: "Box")
            slimLblOL.textColor = UIColor.darkGray
            sender.tag = 0
        }
    }
    @IBAction func athleticBtnAction(_ sender: UIButton) {
        if sender.tag == 0
        {
            athleticImgOL.image = UIImage(named: "Shapetick")
            athleticLblOL.textColor = UIColor(red: 144/255.0, green: 29/255.0, blue: 114/255.0, alpha: 1)
            sender.tag = 1
        }else{
            athleticImgOL.image = UIImage(named: "Box")
            athleticLblOL.textColor = UIColor.darkGray
            sender.tag = 0
        }
    }
    @IBAction func averageBtnAction(_ sender: UIButton) {
        if sender.tag == 0
        {
            averageImgOL.image = UIImage(named: "Shapetick")
            averageLblOL.textColor = UIColor(red: 144/255.0, green: 29/255.0, blue: 114/255.0, alpha: 1)
            sender.tag = 1
        }else{
            averageImgOL.image = UIImage(named: "Box")
            averageLblOL.textColor = UIColor.darkGray
            sender.tag = 0
        }
    }
    @IBAction func stockyBtnAction(_ sender: UIButton) {
        if sender.tag == 0
        {
            stockyImgOL.image = UIImage(named: "Shapetick")
            stockyLblOL.textColor = UIColor(red: 144/255.0, green: 29/255.0, blue: 114/255.0, alpha: 1)
            sender.tag = 1
        }else{
            stockyImgOL.image = UIImage(named: "Box")
            stockyLblOL.textColor = UIColor.darkGray
            sender.tag = 0
        }
    }
    
    @IBAction func profileInterstCancelBtnAction(_ sender: UIButton) {
    }
    @IBAction func profileInterestSaveBtnAction(_ sender: UIButton) {
    }
    @IBAction func profileInterestAccountBtnAction(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: profileVC.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }
    }
    @IBAction func profileInterestAboutBtnAction(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: profileAboutVC.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }
    }
    @IBAction func profileInterestsubscriptionBtnAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "profileSubscriptionVC") as! profileSubscriptionVC
        self.navigationController?.pushViewController(vc, animated: false)
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
extension profileInterestVC: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider == ageRangeSlider {
        print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        let minimumValue = String(format: "%0.f", minValue)
        let maximumValue = String(format: "%0.f", maxValue)
        minLabel.text = "\(minimumValue)-\(maximumValue)"
        }
        else{
            let minimumValue = String(format: "%0.f", minValue)
            let maximumValue = String(format: "%0.f", maxValue)
       heightlblOL.text = "\(minimumValue)-\(maximumValue)"
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}

