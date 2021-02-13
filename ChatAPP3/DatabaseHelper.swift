//
//  DatabaseHelper.swift
//  ChatAPP3
//
//  Created by 井関竜太郎 on 2021/02/13.
//

import Foundation
import Firebase
import FirebaseUI
import SDWebImage

class DatabaseHelper {
    
    let uid = AuthHelper().uid()
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    func getMyRoomList(result:@escaping([ChatRoom]) -> Void){
        var roomList:[ChatRoom] = []
        db.collection("room").whereField("user", arrayContains: uid).addSnapshotListener({
            (querySnapshot, error) in
            if error == nil {
                for doc in querySnapshot!.documents {
                    let data = doc.data()
                    guard let users = data["user"] as? [String] else { return }
                    if users.count != 2 { return }
                    var user = ""
                    if users[0] == self.uid {
                        user = users[1]
                    } else {
                        user = users[0]
                    }
                    roomList.append(ChatRoom(roomID:doc.documentID, userID: user))
                }
                result(roomList)
            }
        })
    }
    
    func getUserInfo(userID:String,result:@escaping(String) -> Void){
        db.collection("user").document(userID).getDocument(completion: {
            (querySnapshot, error) in
            if error == nil {
                let data = querySnapshot?.data()
                guard let name = data!["name"] as! String? else {
                    result("")
                    return
                }
                result(name)
            } else {
                result("")
            }
        })
    }
    
    func resisterInfo(name:String,image:UIImage) {
        db.collection("user").document(uid).setData(["name":name])
        let resized = image.resize(toWidth: 300)
        guard let imageData = resized!.jpegData(compressionQuality:1) else { return }
        
        ///確認ポイント！
        // storage.child("image/\(uid).jpeg").putData(imageData, metadata: nil)
        storage.child("image/\(uid).jpeg").putData(imageData)
    }
    
    func getImage(userID:String,imageView:UIImageView){
        let imageRef = storage.child("image/"+userID+".jpeg")
        imageView.sd_setImage(with: imageRef)
    }
    
    func getUserName(userID:String,result:@escaping(String) -> Void) {
        db.collection("user").document(userID).getDocument(completion: {
            (doc,error) in
            if error == nil {
                let data = doc?.data()
                guard let name = data!["name"] as! String? else { return }
                result(name)
            }
        })
    }
    
}





struct ChatRoom {
    let roomID:String
    let userID:String
}
