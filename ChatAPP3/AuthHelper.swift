//
//  AuthHelper.swift
//  ChatAPP3
//
//  Created by 井関竜太郎 on 2021/02/13.
//

import Foundation
import Firebase

class AuthHelper {
    func createAccount(email:String,password:String,result: @escaping(Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            AuthResult,error in
            if error == nil {
                result(true)
            }else {
                print("Error:\(error!)")
                result(false)
                
            }
        })
    }
    
    
    func login(email:String,password:String,result:@escaping(Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            authResult, error in
            if error == nil {
                result(true)
            } else {
                print("signin:\(error!)")
                result(false)
            }
        })
    }
    
    func uid() -> String {
        guard let user = Auth.auth().currentUser else { return "" }
        return user.uid
    }
    
    func signout(){
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
        }
    }
    
}
