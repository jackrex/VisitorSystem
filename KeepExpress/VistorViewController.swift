//
//  VistorViewController.swift
//  KeepExpress
//
//  Created by jackrex on 29/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import HandyJSON

class VistorViewController: UIViewController {

    var vistorView: VisitorView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vistorView = self.view as! VisitorView!;
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("VistorVC")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView("VistorVC")
    }
    
    @IBAction func submitData(_ sender: Any) {
        let keepStaffName = vistorView.keepStaffNameTextField.text
        let keepVisitorPhone = vistorView.keepVisitorPhoneTextField.text
        let visitorName = vistorView.vistorNameTextField.text
        let vistorFrom = vistorView.vistorFromTextField.text
        
        if (keepStaffName?.characters.count)! <= 0 {
            SVProgressHUD.showError(withStatus: "员工姓名不能为空")
            return
        }
        
        if (visitorName?.characters.count)! <= 0 {
            SVProgressHUD.showError(withStatus: "访客姓名不能为空")
            return
        }
        
        print("log is" + keepStaffName! + keepVisitorPhone! + vistorFrom! + visitorName!)
        
        let params = ["staffName": keepStaffName!, "staffPhone":vistorView.staffPhone, "visitorPhone": keepVisitorPhone!, "from": vistorFrom!, "visitorName": visitorName!]
        
        Alamofire.request(HttpApi.fullPath(path: "/visitor"), method: .post, parameters: params).responseString(completionHandler: { (response) in
            
            if let obj = JSONDeserializer<Success>.deserializeFrom(json: response.result.value)
            {
                if obj.ok == true {
                    SVProgressHUD.showSuccess(withStatus: obj.msg)
                    self.dismiss(animated: true, completion: nil)
                }else {
                    SVProgressHUD.showError(withStatus: obj.msg)
                }
  
            }else {
                SVProgressHUD.showError(withStatus: "发送失败")
            }
            
        })
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    

}
