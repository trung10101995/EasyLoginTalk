//
//  EasyLoginTalkManager.swift
//  EasyLoginTalkManager
//
//  Created by Nguyễn Trung on 9/22/20.
//  Copyright © 2020 Nguyễn Trung. All rights reserved.
//

import UIKit

public class EasyLoginTalkManager {
    
    public static let share = EasyLoginTalkManager()
    
    private init() {}
    
    weak var delegate: EasyLoginTalkManagerDelegate?
    
    public func login(key: String, currentViewController: UIViewController, animation: Bool) {
        if key != Constains.key {
            return
        }
        
        showLoginVc(currentViewController: currentViewController, animation: animation)
        return
    }
}

extension EasyLoginTalkManager {
    private func showLoginVc(currentViewController: UIViewController, animation: Bool) {
        let easyLoginViewModel = EasyLoginViewModel()
        
        let easyLoginViewController = EasyLoginViewController.makeEasyLoginViewController(easyLoginViewModel: easyLoginViewModel)
        
        let naviLoginViewController = UINavigationController.init(rootViewController: easyLoginViewController)
        naviLoginViewController.modalPresentationStyle = .fullScreen
        naviLoginViewController.setNavigationBarHidden(true, animated: false)
        currentViewController.present(naviLoginViewController, animated: animation, completion: nil)
    }
}

protocol EasyLoginTalkManagerDelegate: class {
    /// để data user vào đây
    func loginSuccess(data: String)
}
