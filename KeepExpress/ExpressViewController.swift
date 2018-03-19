//
//  ExpressViewController.swift
//  KeepExpress
//
//  Created by jackrex on 27/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import SVProgressHUD
import CoreGraphics

class ExpressViewController: BaseViewController, QRCodeDataDelegate {

    var expressView: ExpressView!
    @IBOutlet weak var scanBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expressView = self.view as! ExpressView
        scanBtn.layer.cornerRadius = 4.0
        scanBtn.layer.borderColor = UIColor.white.cgColor;
        scanBtn.layer.borderWidth = 1;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("ExpressVC")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView("ExpressVC")
    }
    
    
   
    @IBAction func submitData(_ sender: Any) {
        let keepStaffName = expressView.expressNameTextField.text
        let keepStaffPhone = expressView.expressPhoneTextField.text
        let expressCode = expressView.expressCodeTextField.text

        if (keepStaffPhone?.characters.count)! <= 0 {
            SVProgressHUD.showError(withStatus: "员工手机号不能为空")
            return
        }
        
        let params = ["staffName": keepStaffName!, "staffPhone": keepStaffPhone!, "type": String(expressView.currentIndex), "expressCode": expressCode!]
        
        Alamofire.request(HttpApi.fullPath(path: "/save/express"), method: .post, parameters: params).responseString(completionHandler: { (response) in
            
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

    @IBAction func scanAction(_ sender: Any) {
        let scanVC: QRScannerViewController = self.storyboard!.instantiateViewController(withIdentifier: "QRScannerViewController") as! QRScannerViewController
        scanVC.delegate = self
        self.present(scanVC, animated: true) { 
            
        }
    }
    
    func qrData(data: String) {
        if data.characters.count > 0 {
            //TDO 获取网上数据
            expressView.expressCodeTextField.text = data
        }
    }
    
    
}
