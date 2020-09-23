//
//  EasyLoginViewController.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import UIKit

public class EasyLoginViewController: CustomViewController {
    
    enum TypeButtonLogin {
        case enable
        case disable
        
        func getBackgourdColor() -> UIColor {
            switch self {
            case .enable:
                return UIColor.init(red: 31/255, green: 159/255, blue: 252/255, alpha: 1)
            case .disable:
                return UIColor.init(red: 212/255, green: 215/255, blue: 211/255, alpha: 1)
            }
        }
        
        func isEnable() -> Bool {
            switch self {
            case .enable:
                return true
            case .disable:
                return false
            }
        }
        
        static func getType(isPhone: Bool) -> TypeButtonLogin {
            return isPhone ? .enable : .disable
        }
    }
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var tfInputPhone: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblError: UILabel!
    /// cst
    @IBOutlet weak var constraintBtnLoginBot: NSLayoutConstraint!
    
    
    /// view model
    private var easyLoginViewModel: EasyLoginViewModel?
    
    static func makeEasyLoginViewController(easyLoginViewModel: EasyLoginViewModel) -> EasyLoginViewController {
        let vc = EasyLoginViewController.init(nibName: "EasyLoginViewController", bundle: Bundle(for: EasyLoginViewController.self))
        
        vc.easyLoginViewModel = easyLoginViewModel
        
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
        
        let logoImg = UIImage.init(named: "ic_logo", in: Bundle(for:  type(of: self)), compatibleWith: nil)
        imgLogo.image = logoImg
        
        let typeButtonLogin = TypeButtonLogin.disable
        btnLogin.isEnabled = typeButtonLogin.isEnable()
        btnLogin.backgroundColor = typeButtonLogin.getBackgourdColor()
        
        tfInputPhone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        
        tfInputPhone.becomeFirstResponder()
    }
    
    private func setupViewModel() {
        easyLoginViewModel?.checkIsPhoneDidChangeCallBack = { [weak self] isPhone in
            let typeButtonLogin = TypeButtonLogin.getType(isPhone: isPhone)
            self?.btnLogin.isEnabled = typeButtonLogin.isEnable()
            self?.btnLogin.backgroundColor = typeButtonLogin.getBackgourdColor()
        }
        
        easyLoginViewModel?.errorTextDidChaneCallBack = { [weak self] errorText in
            self?.lblError.text = errorText
        }
        
        easyLoginViewModel?.gotoOtpCallBack = { [weak self] textPhone in
            guard let strongSelf = self else {
                return
            }
            HandlePresenter.presenterLoginOtpVC(texPhone: textPhone, currentViewController: strongSelf, animation: true)
        }
    }
    
    private func loadData() {
        
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            constraintBtnLoginBot.constant = keyboardHeight + 15
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        easyLoginViewModel?.textFieldDidChange(textField)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        easyLoginViewModel?.callLogin()
    }
}
