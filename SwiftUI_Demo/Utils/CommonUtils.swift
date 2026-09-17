//
//  CommonUtils.swift
//  COMPX576_DEMO
//
//  Created by 马腾 on 2023/8/6.
//

import Foundation
import CryptoKit
import UIKit


class CommonUtils:NSObject{
    
    class func getNowDate() -> String{
        //getCurrentDate
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let date = Date(timeIntervalSince1970: timeInterval)
        let dformatter = DateFormatter()
        dformatter.dateFormat = "dd/MM"
        return dformatter.string(from: date);
    }
    
    class func showAlert(title: String,
                         content: String,
                         array: Array<String>,
                         viewController: UIViewController,
                         handler:@escaping((String) -> Void)){

        let alertVC = UIAlertController(title: title, message: content, preferredStyle: .alert)

        if(array[0] == "YES"){
            let alertAction = UIAlertAction.init(title: "YES", style: .default) { UIAlertAction in
                handler(array[0])
            }
            alertVC.addAction(alertAction)
        }
        if(array[1] == "Cancel"){
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .destructive) { UIAlertAction in
                handler(array[1])
            }
            alertVC.addAction(cancelAction)
        }
        viewController.present(alertVC, animated: true)

    }
    
    //verify email
    class func validateEmail(email: String) -> Bool {
        if email.count == 0 {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    //verify phone
    class func isPhoneNumber(phoneNumber:String) -> Bool {
        if phoneNumber.count == 0 {
            return false
        }
        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneNumber) == true {
            return true
        }else
        {
            return false
        }
    }
    
    //Password regular 6-8 character combination of letters and numbers
    class func isPasswordRuler(password:String) -> Bool {
        let passwordRule = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,8}$"
        let regexPassword = NSPredicate(format: "SELF MATCHES %@",passwordRule)
        if regexPassword.evaluate(with: password) == true {
            return true
        }else
        {
            return false
        }
    }
    
    //encryption sha256
    @available(iOS 13.0, *)
    class func sha256Hash(for string: String) -> String {
        if let data = string.data(using: .utf8) {
            let hash = SHA256.hash(data: data)
            return hash.map { String(format: "%02hhx", $0) }.joined()
        }
        return ""
    }    

}



