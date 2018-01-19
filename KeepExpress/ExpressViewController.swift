//
//  ExpressViewController.swift
//  KeepExpress
//
//  Created by jackrex on 27/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreGraphics
import Moya
import RxSwift
import RxCocoa

class ExpressViewController: BaseViewController, QRCodeDataDelegate {
    
    private let provider = RxMoyaProvider<HttpApi>()
    private let dispose = DisposeBag()
    
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
    
    
    func keyboardWillShow(userInfo: NSNotification) -> Void {
        let dict = userInfo.userInfo
        let rect = dict?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let ty = rect.origin.y - UIScreen.main.bounds.size.height
        let duration = dict?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform(translationX: 0, y: ty)
            
        }
        
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
        
        provider
            .request(.sendMessageWithParam(params))
            .mapModel(Success.self)
            .subscribe(onNext: {
                if $0.ok == true {
                    SVProgressHUD.showSuccess(withStatus: $0.msg)
                    self.dismiss(animated: true, completion: nil)
                }else {
                    SVProgressHUD.showError(withStatus: $0.msg)
                }
            }, onError:{ error in
                SVProgressHUD.showError(withStatus: "发送失败")
            })
            .addDisposableTo(dispose)
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
