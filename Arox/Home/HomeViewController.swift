//
//  HomeViewController.swift
//  Arox
//
//  Created by apple on 12/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController:
UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var userDetailsArray = [HomeScreenModel]()
    @IBOutlet weak var homeCollectionViewOL: UICollectionView!
    
    var images:[UIImage] = [UIImage(named: "Unknown")!,UIImage(named: "Unknown")!,UIImage(named: "Unknown")!]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
            return userDetailsArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomecollectionViewCell
        if userDetailsArray[indexPath.row].status == "online"{
            cell.onlineStatusImg.image = UIImage(named: "Oval")
        }
        cell.collectionNameLbl.text = userDetailsArray[indexPath.row].firstname
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.homeCollectionViewOL.frame.size.width/3, height: self.homeCollectionViewOL.frame.size.height/5)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue(label: "q1", qos: .userInteractive).async {
            self.getUserApi()
        }
        ActivityInd.sharedActivity.startAnimating(view: self.view,color: .white)
    }

    //api call
    func getUserApi(){
        let userId = UserDefaults.standard.value(forKey: "user_id")
        let parameters:Parameters = ["user_id":userId]
        let url = Constants.getUsers
        
               
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:nil).responseJSON { (response) in
            switch response.result{
                  
            case .success:
                if let data = response.result.value as? AnyObject{
                    let status = data.value(forKey: "status") as! Int
                    let msg = data.value(forKey: "message") as! String
                    if status == 1{
                        let jsonData = data.value(forKey: "data") as! [[String:Any]]
                        for i in 0..<jsonData.count{                            self.userDetailsArray.append(HomeScreenModel(distance: jsonData[i]["distance"] as! Int, lastName:  jsonData[i]["lastname"] as! String, userId:  jsonData[i]["user_id"] as! String, imageURl:  jsonData[i]["image"] as! String, firstName:  jsonData[i]["firstname"] as! String, status:  jsonData[i]["status"] as! String))
                        }
                        DispatchQueue.main.async {
                            self.homeCollectionViewOL.reloadData()
                            ActivityInd.sharedActivity.stopAnimating()
                        }
                    }else{
                        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        alertController.addAction(okAction)
                        DispatchQueue.main.async {
                            self.homeCollectionViewOL.reloadData()
                            ActivityInd.sharedActivity.stopAnimating()
                        }
                        self.present(alertController, animated: true, completion: nil)

                    }
                    
                }
                
            case .failure(_):
                print(response.error)
            }
        }
        
    }

}


