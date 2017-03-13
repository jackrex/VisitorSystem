//
//  VistorView.swift
//  KeepExpress
//
//  Created by jackrex on 29/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class VisitorView: UIView, UITextFieldDelegate {

    @IBOutlet weak var keepStaffNameTextField: UITextField!
    
    @IBOutlet weak var keepVisitorPhoneTextField: UITextField!
    @IBOutlet weak var vistorNameTextField: UITextField!
    @IBOutlet weak var vistorFromTextField: UITextField!
    public var staffPhone: String = ""
    
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
            let requestUrl = "/employee/query"
            let params = ["name" : textField.text!]
            Alamofire.request(HttpApi.fullPath(path: requestUrl), method: .get, parameters: params).responseString(completionHandler: { (response) in
                if let employees = JSONDeserializer<Employee>.deserializeModelArrayFrom (json: response.result.value ) {
                    self.updateUI(employees as! Array<Employee>)
                }
            })
        
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
