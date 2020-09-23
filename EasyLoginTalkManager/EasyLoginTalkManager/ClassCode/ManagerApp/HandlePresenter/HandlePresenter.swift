//
//  HandlePresenter.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import Foundation
import UIKit

class HandlePresenter {
    
    private init() {}
    
    static func presenterLoginOtpVC(texPhone: String, currentViewController: UIViewController, animation: Bool) {
        let loginOtpViewModel = LoginOtpViewModel(textPhone: texPhone)
        
        let LoginOtpVC = LoginOtpViewController.makeLoginOtpViewController(loginOtpViewModel: loginOtpViewModel)
        
        currentViewController.navigationController?.pushViewController(LoginOtpVC, animated: animation)
    }
}
