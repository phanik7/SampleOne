//
//  HomeScreenModel.swift
//  Arox
//
//  Created by apple on 1/5/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
struct HomeScreenModel {
    let distance:Int
    let lastname:String
    let user_id:String
    let imageUrl:String
    let firstname:String
    let status:String
    init(distance:Int,lastName:String,userId:String,imageURl:String,firstName:String,status:String) {
        self.distance = distance
        self.user_id = userId
        self.lastname = lastName
        self.imageUrl = imageURl
        self.firstname = firstName
        self.status = status
    }
}
