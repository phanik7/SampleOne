//
//  createAccount2ViewController.swift
//  Arox
//
//  Created by apple on 12/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire
class createAccount2ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var heightArray = ["4'0","4'1","4'2","4'3","4'4","4'5","4'6","4'7","4'8","4'9","4'10","4'11","5'0","5'1","5'2","5'3","5'4","5'5","5'6","5'7","5'8","5'9","5'10","5'11", "6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","6'10","6'11","7'0","7'1","7'2","7'3","7'4","7'5","7'6","7'7","7'8","7'9","7'10","7'11"]
   
    var myUIPicker : UIPickerView!
    var firstInteger = Int()
    //
    var userid = String()
//    var firstname = String()
//    var lastname = String()
//    var Email = String()
//    var phoneno = String()
//    var password = String()
    var str = String()
//
    var imagePicker = UIImagePickerController()
    
//
    var gender = String()
    let Age = String()
    let Height = String()
//OUTLET
    
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
   
    @IBOutlet weak var profileImageOL: UIImageView!
    @IBOutlet weak var maleBtnOL: UIButton!
    @IBOutlet weak var femaleBtnOL: UIButton!
   
    
    @IBOutlet weak var clickBtnOL: UIButton!
    
//DEFAULTS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        myUIPicker = UIPickerView()
        myUIPicker.delegate = self
        myUIPicker.dataSource = self
        heightTF.inputView = myUIPicker
        debugPrint(userid)
     imagePicker.delegate = self
        heightTF.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let radius = profileImageOL.frame.width/10.0
        profileImageOL.layer.cornerRadius = radius
       profileImageOL.layer.masksToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
       return heightArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return heightArray[row]
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        heightTF.text = heightArray[row]
        
    }
 //CUSTOM METHODS
    func validation(){
        let imageData = convertImageToBase64(image: profileImageOL.image!)
        if ageTF.text == ""
        {
            alert(message: "Enter Age ", title: "Alert")
        }
        else if heightTF.text == ""{
            alert(message: "Enter Height", title: "Alert")
        }else{
            let param: [String: AnyObject] = [ "id": userid as AnyObject,
                                               "age": ageTF.text! as AnyObject,"height": heightTF.text! as AnyObject,"gender": gender as AnyObject, "image": imageData as AnyObject]
            print(param)
                let url = Constants.createAccount2
            
                                Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers:nil)
        
                        .responseJSON { response in
                            switch response.result {
                            case .success:
                                print(response)
                                let dict = (response.value) as AnyObject
                                let status = dict.value(forKey: "status") as! Int
                                let msg = dict.value(forKey: "message") as! String
                                if status == 0{
                                    self.alert(message: msg, title: "Alert")
                                }
                                else{
                                    
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
                                  
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
        
                            case .failure(_): break
        
                            }
                    }
            ActivityInd.sharedActivity.stopAnimating()
                }

        
    }
    
    //image to base 64 conversion
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(image, 1)!
      //  let imageData = UIImagePNGRepresentation(image)!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
 
    
   @IBAction func changeImageBtnAction(_ sender: Any) {
   
    
    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
        self.openCamera()
    }))

    alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
        self.openGallary()
    }))

    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        alert.popoverPresentationController?.sourceView = sender as? UIView
        alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        alert.popoverPresentationController?.permittedArrowDirections = .up
    default:
        break
    }

    self.present(alert, animated: true, completion: nil)
    }

    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)




    }

   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
   
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImageOL.image = pickedImage

        }
        picker.dismiss(animated: true, completion: nil)
 }

    

 //
    @IBAction func femaleBtnAction(_ sender: Any) {
        gender = "Female"
        maleBtnOL.setBackgroundImage(#imageLiteral(resourceName: "unclick"), for: UIControlState.normal)
        femaleBtnOL.setBackgroundImage(#imageLiteral(resourceName: "click"), for: UIControlState.normal)
    }
    @IBAction func maleBtnAction(_ sender: Any) {
        gender = "Male"
       maleBtnOL.setBackgroundImage(#imageLiteral(resourceName: "click"), for: UIControlState.normal)
        femaleBtnOL.setBackgroundImage(#imageLiteral(resourceName: "unclick"), for: UIControlState.normal)
    }
    @IBAction func termsBTN(_ sender: UIButton) {
    }
    
    @IBAction func clickBTN(_ sender: UIButton) {
        if clickBtnOL.tag == 1{
            clickBtnOL.tag = 0
    clickBtnOL.setImage(UIImage(named: "tick-1"), for: UIControlState.normal)
    
        }
        else if clickBtnOL.tag == 0{
            clickBtnOL.tag = 1
 clickBtnOL.setImage(UIImage(named: "tick"), for: UIControlState.normal)
            
        }
            }
    
    @IBAction func signUpBTN(_ sender: UIButton) {
        self.validation()
    }
  
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
