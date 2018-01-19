//
//  ExpressView.swift
//  KeepExpress
//
//  Created by jackrex on 29/12/2016.
//  Copyright © 2016 jackrex. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class ExpressView: UIView, UITextFieldDelegate {
    
    private let provider = RxMoyaProvider<HttpApi>()
    private let dispose = DisposeBag()
    
    @IBOutlet weak var expressCollectionView: UICollectionView!
    @IBOutlet weak var expressCodeTextField: UITextField!
    @IBOutlet weak var expressNameTextField: UITextField!
    @IBOutlet weak var expressPhoneTextField: UITextField!
    
    fileprivate let icons = ["ems", "jd", "sf", "sto", "yt", "yunda", "zto", "baishi"]
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (textField.text?.characters.count)! <= 0 {
            return
        }
        var api:HttpApi?
        if textField == expressNameTextField {
            api = .getEmployeeWithName(textField.text!)
        }else if textField == expressPhoneTextField {
            api = .getEmployeeWithPhone(textField.text!)
        }
        guard let currentApi = api else {
            return
        }
        provider
            .request(currentApi)
            .mapArray(Employee.self)
            .subscribe(onNext: {
                self.updateUI($0)
            },onError:{
                print($0)
            })
            .addDisposableTo(dispose)
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

extension ExpressView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        print("currentIndex" + String(currentIndex))
        collectionView.reloadData()
    }
}

extension ExpressView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
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
    
}

extension ExpressView : UICollectionViewDelegateFlowLayout {
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
}


