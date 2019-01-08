





import UIKit
import IQKeyboardManagerSwift
import Alamofire
import NVActivityIndicatorView
import FBSDKLoginKit
import FBSDKCoreKit

class loginViewController: UIViewController,UITextFieldDelegate,NVActivityIndicatorViewable {
    let parameters = ["fields": "email,picture.type(large),name,gender,age_range,cover,timezone,verified,updated_time,education,religion,friends"]
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    var firstName = String()
    var lastName = String()
     var id = String()
     var email = String()
     var phone = String()
     var imageUrl = String()
//OUTLETS
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    
// DEFAULTS METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        passwordTF.delegate = self
        fbLoginManager.loginBehavior = .web
        
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
           let url = Constants.login
                
            Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers:nil)
                
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        self.stopAnimating()
                        print(response)
                        let dict = (response.value) as AnyObject
                        let status = dict.value(forKey: "status") as! Int
                       let msg = dict.value(forKey: "message") as! String
                        
                     
                        
                        if status == 0{
                            self.alert(message: msg, title: "Alert")
                        }
                        else{
                            let user_id = dict["logged_id"] as? String
                            UserDefaults.standard.set(user_id, forKey: "user_id")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
                            vc.selectedIndex = 1
                                self.navigationController?.pushViewController(vc, animated: true)
                                            }
                        
                    case .failure(_): break
                        
                    }
            }
        }
        
        
    }
    
    
    
//BUTTONS
    
    @IBAction func signINFacebookBtnAction(_ sender: Any) {
        if FBSDKAccessToken.current() != nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
            vc.selectedIndex = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((FBSDKAccessToken.current()) != nil){
                            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                               
                                if (error == nil){
                                    let dict = result as! [String:Any]
                                    if let token = FBSDKAccessToken.current().tokenString {
                                        print("tocken: \(token)")
                                    }
                                    if let firstName = dict["first_name"] {
                                        print("first name: \(firstName)")
                                        self.firstName = firstName as! String
                                    }
                                    if let userlastname = dict["last_name"] {
                                        print("last name: \(userlastname)")
                                        self.lastName = userlastname as! String
                                    }
                                    if let id = dict["id"] {
                                        print("id: \(id)")
                                    }
                                    if let email = dict["email"]{
                                        print("email: \(email)")
                                        self.email = (email as! String)
                                    }
                                    if let imageURL = ((dict["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                                        print(imageURL)
                                        self.imageUrl = imageURL
                                    }
                                    let parameters:[String:Any] = ["first_name": self.firstName as! String, "last_name": self.lastName as! String, "email": self.email as! String,  "latitude":"30.7046","longitude":"76.7179","image": self.imageUrl]
                                // self.facebookSignUpApi(parameters: parameters)
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
                                    vc.selectedIndex = 1
                                    self.navigationController?.pushViewController(vc, animated: true)
                            }
                               
                            })
                        }
                    }
                }
            }
        }
        }
    }
    
    //facebook post api
    func facebookSignUpApi(parameters:Parameters){
        let url = Constants.signUpFB
        ActivityInd.sharedActivity.startAnimating(view: self.view, color: .purple)

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:nil).responseJSON { (response) in
            switch response.result{
                
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
                    let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
                    
                    // Create the actions
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbarVC") as! tabbarVC
                    vc.selectedIndex = 1
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(_):
                print(response.error)
            }
            ActivityInd.sharedActivity.stopAnimating()
            self.fbLoginManager.logOut()
        }

    }
    
    
    
    @IBAction func signInLinkdinBtnAction(_ sender: Any) {
        alert(message: "On Working", title: "Alert")
        
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        self.validation()
    }

    @IBAction func createAccountBtnAction(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "createAcountVC") as! createAcountVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func forgotPasswordBtnAction(_ sender: Any)
    {
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

