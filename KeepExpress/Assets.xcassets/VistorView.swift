//
//  VistorView.swift
//  KeepExpress
//
//  Created by jackrex on 29/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class VisitorView: UIView, UITextFieldDelegate {

    @IBOutlet weak var keepStaffNameTextField: UITextField!
    
    @IBOutlet weak var keepVisitorPhoneTextField: UITextField!
    @IBOutlet weak var vistorNameTextField: UITextField!
    @IBOutlet weak var vistorFromTextField: UITextField!
    public var staffPhone: String = ""
    
    private let provider = RxMoyaProvider<HttpApi>()
    private let dispose = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        keepStaffNameTextField.layer.borderColor = Utils.layerColor().cgColor
        keepVisitorPhoneTextField.layer.borderColor = Utils.layerColor().cgColor
        vistorNameTextField.layer.borderColor = Utils.layerColor().cgColor
        vistorFromTextField.layer.borderColor = Utils.layerColor().cgColor
        
        keepVisitorPhoneTextField.delegate = self;
        keepStaffNameTextField.delegate = self;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (textField.text?.characters.count)! <= 0 {
            return
        }
        
        if textField == keepStaffNameTextField {
            provider
                .request(.getEmployeeWithName(textField.text!))
                .mapArray(Employee.self)
                .subscribe(onNext: {
                    self.updateUI($0)
                })
                .addDisposableTo(dispose)
        }
    }

    func updateUI(_ employees: Array<Employee>) -> Void {
        if employees.count > 0 {
            let currentEmployee = employees[0]
            self.keepStaffNameTextField.text = currentEmployee.name
            self.staffPhone = currentEmployee.phone!
            
        }

    }
}
