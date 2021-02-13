//
//  ViewController.swift
//  ChatAPP3
//
//  Created by 井関竜太郎 on 2021/02/13.
//

import UIKit

class ViewController: UIViewController {

    var dataHelper = DatabaseHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let uid = AuthHelper().uid()
        if uid == "" {
            //なかったら
            performSegue(withIdentifier: "login", sender: nil)
        }else{
            //あったら
            print(uid)
            //チャットリストを表示する
        }
        
    }

    @IBAction func logOut(_ sender: Any) {
        AuthHelper().signout()
    }
    
}

