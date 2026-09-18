//
//  HConfig.swift
//  Hikids_new
//
//  Created by 马腾 on 2024/7/28.
//

import Foundation
import SnapKit
import UIKit


func BWColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}

//新闻key
let APIKEY_Mediastack = "79ac869ea03fcf9b7dc9ed446db6ac8b"

//user key
let KEY_Token = "token"
let KEY_nickName = "nickName"
let KEY_Username = "username"
let KEY_Password = "password"
let KEY_Email = "email"
let KEY_Avatar = "avatar"
