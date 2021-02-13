//
//  LoginView.swift
//  ChatAPP3
//
//  Created by 井関竜太郎 on 2021/02/13.
//

import UIKit

class LoginView: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if AuthHelper().uid() != "" {
            dismiss(animated: false, completion: nil)
            
        }
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        
        AuthHelper().login(email: emailField.text!, password: passwordField.text!, result: {
            success in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("ログイン成功")
            }else{
                self.showError()
            }
        })
    }
    
    
    //アカウント作成画面
    func showError() {
        let dialog = UIAlertController(title: "エラー", message: "メールアドレスORパスワードが間違っています。", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(dialog, animated: true, completion: nil)
    }
    
    
}
