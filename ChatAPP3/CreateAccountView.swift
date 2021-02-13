//
//  CreateAccountView.swift
//  ChatAPP3
//
//  Created by 井関竜太郎 on 2021/02/13.
//

import UIKit

class CreateAccountView: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //タップの動作を受け取る
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImage)))
        imageView.isUserInteractionEnabled = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
    @objc func onImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        //アカウント作成画面
        let name = nameTextField.text!
        if name.count < 3 || name.count > 10 {
            showError(message: "名前は3文字以上10文字以内で入力してください。")
        }else{
            AuthHelper().createAccount(email: emailTextField.text!, password: passwordTextField.text!, result: {
                success in
                if success {
                    DatabaseHelper().resisterInfo(name: self.nameTextField.text!, image: self.imageView.image!)
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.showError(message: "有効なメールアドレス、6文字以上のパスワードを入力してください。")
                }
            })
        }
    }
    
    //アカウント作成画面
    func showError(message:String) {
        let dialog = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(dialog, animated: true, completion: nil)
    }
    
    
}
