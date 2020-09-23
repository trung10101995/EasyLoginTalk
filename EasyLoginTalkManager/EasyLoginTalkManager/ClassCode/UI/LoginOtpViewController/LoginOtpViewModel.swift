//
//  LoginOtpViewModel.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import Foundation
import UIKit

class LoginOtpViewModel: CustomViewModel {
    
     init(textPhone: String) {
        self.textPhone = textPhone
    }
    
    deinit {
        timer?.invalidate()
    }
    
    var errorTextDidChaneCallBack: ((_ errorText: String) -> Void)?
    
    var isHideLblQuestionDidChangeCallBack: ((_ isHidden: Bool) -> Void)?
    
    var styleBtnResendDidChangeCallBack: ((_ styleBtnResend: (title: String, isEnable: Bool)) -> Void)?
    
    var titleAttrString: NSMutableAttributedString {
        
        let title = "Nhập mã OTP được gửi về\nSố điện thoại \(textPhone)"
        let phone = "\(textPhone)"
        
        let range = (title as NSString).range(of: phone)
        
        let attributedString = NSMutableAttributedString(string:title)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue , range: range)
        
        return attributedString
    }
    
    private var errorData: (errorText: String, isHiddenQuestion: Bool) = (errorText: "", isHiddenQuestion : false) {
        didSet {
            errorTextDidChaneCallBack?(errorData.errorText)
            isHideLblQuestionDidChangeCallBack?(errorData.isHiddenQuestion)
        }
    }
    
    private var styleBtnResend:(title: String, isEnable: Bool) = ("", false){
        didSet {
            styleBtnResendDidChangeCallBack?(styleBtnResend)
        }
    }
    private var textPhone: String = ""
    
    private var timer: Timer?
    private var time = 30 {
        didSet {
            if time == 0 {
                self.styleBtnResend = (title: "Gửi lại mã OTP", isEnable: true)
                return
            }
            
            if time < 10 {
                self.styleBtnResend = (title: "Gửi lại sau 00:0\(time)", isEnable: false)
                return
            }
            
            self.styleBtnResend = (title: "Gửi lại sau 00:\(time)", isEnable: false)
        }
    }
    
    func startTimer(time: Int = 30) {
        timer?.invalidate()
        self.time = time
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if time == 0 {
            timer?.invalidate()
            return
        }
        
        time -= 1
    }
    
    func resendOtp() {
        startTimer()
        callApiOTP()
    }
    
    func callLogin() {
        callApiOTP()
    }
    
    func didChangePinCode() {
        errorData = (errorText: "", isHiddenQuestion: false)
    }
    
    private func callApiOTP()  {
        errorData = (errorText: "Cậu chưa ghép api", isHiddenQuestion: true)
    }
    
    private func callApiResendOTP()  {
        errorData = (errorText: "Cậu chưa ghép api", isHiddenQuestion: true)
    }
}
