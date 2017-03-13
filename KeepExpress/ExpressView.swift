//
//  ExpressView.swift
//  KeepExpress
//
//  Created by jackrex on 29/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class ExpressView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var expressCollectionView: UICollectionView!
    @IBOutlet weak var expressCodeTextField: UITextField!
    @IBOutlet weak var expressNameTextField: UITextField!
    @IBOutlet weak var expressPhoneTextField: UITextField!
    
    let icons = ["ems", "jd", "sf", "sto", "yt", "yunda", "zto", "baishi"]
    public var currentIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expressCollectionView.delegate = self;
        expressCollectionView.dataSource = self;
        expressCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        expressCodeTextField.layer.borderColor = Utils.layerColor().cgColor
        expressNameTextField.layer.borderColor = Utils.layerColor().cgColor
        expressPhoneTextField.layer.borderColor = Utils.layerColor().cgColor
        
        expressNameTextField.delegate = self
        expressPhoneTextField.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 60) 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ExpressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpressCollectionViewCell", for: indexPath) as! ExpressCollectionViewCell
        if indexPath.row < 8 {
            cell.expressIcon.image = UIImage.init(named: icons[indexPath.row])
            cell.otherLabel.isHidden = true
            cell.expressIcon.isHidden = false
        }else {
            cell.expressIcon.isHidden = true
            cell.otherLabel.isHidden = false
        }
        
        if currentIndex == indexPath.row {
            cell.selectedImageView.image = UIImage.init(named: "selected")
        }else {
            cell.selectedImageView.image = UIImage.init(named: "unselected")
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        print("currentIndex" + String(currentIndex))
        collectionView.reloadData()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (textField.text?.characters.count)! <= 0 {
            return
        }
        
        if textField == expressNameTextField {
            let requestUrl = "/employee/query"
            let params = ["name" : textField.text!]
            Alamofire.request(HttpApi.fullPath(path: requestUrl), method: .get, parameters: params).responseString(completionHandler: { (response) in
                if let employees = JSONDeserializer<Employee>.deserializeModelArrayFrom (json: response.result.value ) {
                    self.updateUI(employees as! Array<Employee>)
                }
            })
            
        }else if textField == expressPhoneTextField {
            Alamofire.request(HttpApi.fullPath(path: "/employee/phone/" + textField.text!), method: .get).responseString(completionHandler: { (response) in
                if let employees = JSONDeserializer<Employee>.deserializeModelArrayFrom (json: response.result.value ) {
                    self.updateUI(employees as! Array<Employee>)
                }
                
            })
            
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func updateUI(_ employees: Array<Employee>) -> Void {
        if employees.count > 0 {
            let currentEmployee = employees[0]
            self.expressPhoneTextField.text = currentEmployee.phone
            self.expressNameTextField.text = currentEmployee.name
        }
        
    }

}
