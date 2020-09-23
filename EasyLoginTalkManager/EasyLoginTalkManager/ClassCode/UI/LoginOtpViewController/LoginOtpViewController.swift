//
//  LoginOtpViewController.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import UIKit
import PinCodeTextField

public class LoginOtpViewController: CustomViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnBtnResend: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblQuestionOtp: UILabel!
    @IBOutlet weak var pinCode: PinCodeTextField!
    
    /// view model
    
    private var loginOtpViewModel: LoginOtpViewModel?
    
    static func makeLoginOtpViewController(loginOtpViewModel: LoginOtpViewModel) -> LoginOtpViewController {
        let vc = LoginOtpViewController.init(nibName: "LoginOtpViewController", bundle: Bundle(for: LoginOtpViewController.self))
        
        vc.loginOtpViewModel = loginOtpViewModel
        
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUi()
        setupViewModel()
        loadData()
    }
    
    private func setupUi() {
        let imgBack = UIImage.init(named: "ic_back", in: Bundle(for:  type(of: self)), compatibleWith: nil)
        btnBack.setImage(imgBack, for: .normal)
        
        self.lblTitle.attributedText = loginOtpViewModel?.titleAttrString
        
        pinCode.delegate = self
        pinCode.keyboardType = .numberPad
        pinCode.becomeFirstResponder()
    }
    
    private func setupViewModel() {
        loginOtpViewModel?.styleBtnResendDidChangeCallBack = { [weak self] styleBtnResend in
            UIView.performWithoutAnimation {
                self?.btnBtnResend.setTitle(styleBtnResend.title, for: .normal)
                self?.btnBtnResend.isEnabled = styleBtnResend.isEnable
                self?.btnBtnResend.layoutIfNeeded()
            }
            
        }
        
        
        loginOtpViewModel?.isHideLblQuestionDidChangeCallBack = { [weak self] isHidden in
            self?.lblQuestionOtp.isHidden = isHidden
        }
        
        loginOtpViewModel?.errorTextDidChaneCallBack = { [weak self] errorText in
            self?.lblError.text = errorText
        }
        
    }
    
    private func loadData() {
        loginOtpViewModel?.startTimer()
    }
    
    @IBAction func didTapResendOtp(_ sender: Any) {
        loginOtpViewModel?.resendOtp()
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension LoginOtpViewController: PinCodeTextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: PinCodeTextField) {
        loginOtpViewModel?.callLogin()
    }
    
    public func textFieldDidBeginEditing(_ textField: PinCodeTextField) {
        loginOtpViewModel?.didChangePinCode()
    }
}
