//
//  EasyLoginViewModel.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import Foundation
import UIKit

class EasyLoginViewModel: CustomViewModel {
    
    enum TypeTfPhone {
        case error
        case normal
        
        func getTextFieldBackground() -> UIColor {
            switch self {
            case .error:
                return UIColor.init(hex: 0xFF4E3D)
            case .normal:
                return UIColor.init(hex: 0xF4F6FA)
            }
        }
    }
    
    override init() {
        
    }
    
    var checkIsPhoneDidChangeCallBack: ((_ isPhone: Bool) -> Void)?
    
    var errorTextDidChaneCallBack: ((_ errorText: String) -> Void)?
    
    var colorTfDidChangeCallBack: ((_ color: UIColor) -> Void)?
    
    var gotoOtpCallBack: ((_ textPhone: String) -> Void)?
    
    private var isPhone: Bool = false {
        didSet {
            checkIsPhoneDidChangeCallBack?(isPhone)
        }
    }
    
    private var textPhone: String = "" {
        didSet {
            checkValidatePhoneLocal()
        }
    }
    
    private var errorData: (errorText: String, typeTfPhone: TypeTfPhone) = (errorText: "", typeTfPhone : TypeTfPhone.normal) {
        didSet {
            errorTextDidChaneCallBack?(errorData.errorText)
            colorTfDidChangeCallBack?(errorData.typeTfPhone.getTextFieldBackground())
        }
    }
    
    // MARK: vadilate text field, phone local
    
    func textFieldDidChange(_ textField: UITextField) {
        textPhone = textField.text ?? ""
        errorData = (errorText: "", typeTfPhone: .normal)
    }
    
    private func checkValidatePhoneLocal() {
        let validatePhone = validatePhoneLocal(value: textPhone)
        
        if isPhone == validatePhone {
            return
        } else {
            isPhone = validatePhone
        }
    }
    
    private func validatePhoneLocal(value: String) -> Bool {
//        let PHONE_REGEX = "^(\\([0-9]{3}\\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result = phoneTest.evaluate(with: value)
//        return result
        return true
    }
    
    // MARK: validate, call api login phone
    
    func callLogin() {
        if !validatePhoneServer(value: textPhone) {
            errorData = (errorText: "Đây là số điện thoại không hợp lệ. Vui lòng nhập lại số điện thoại của bạn.", typeTfPhone: .error)
        } else {
            callApiSendLogin()
        }
    }
    
    private func validatePhoneServer(value: String) -> Bool {
        return true
    }
    
    private func callApiSendLogin()  {
        if textPhone != "0389423108" {
            errorData = (errorText: "Có lỗi login gì đó, nhập test 0389423108 sẽ cho vô :D", typeTfPhone: .error)
        } else {
            gotoOtpCallBack?(textPhone)
        }
    }
    
}
