//
//  UserEditViewController.swift
//  TwitterAppSB
//
//  Created by KO on 18/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController, UICollectionViewDelegateFlowLayout, ConnectionDelegate {
    
    var userId: Int?
    
    var _firstName: String?
    var _lastName: String?
    var _userName: String?
    var _age: Int?
    
    @IBOutlet weak var userEditView: UICollectionView!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    var userParameters = [String : Any]()
    var tweetParameters = [String : Any]()
    
    @IBAction func saveBtn(_ sender: Any) {
        _firstName = firstName.text
        _lastName = lastName.text
        _userName = userName.text
        _age = Int(age.text!)
        
        userParameters = ["firstName": "_firstName",
                      "lastName" : "_lastName",
                      "profile": "@" + "_userName",
                      "age": 5 ]
        
        tweetParameters = ["firstName": _firstName!,
                          "lastName" : _lastName!,
                          "profile": "@" + _userName!]
        
        sendData()
        //butona bastıgında servise data yollayacak
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //transition effect
        self.modalTransitionStyle = .crossDissolve
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBackUserVC" {
            let vc = segue.destination as! UserViewController
            vc.userId = self.userId
        }
    }
    func sendData() {
        let service = Service(delegate: self)
        let headers = ["Content-Type":"application/json"]
        
        service.connectService(baseUrl: "http://localhost:8081/updateuserintweets/\(userId!)/\(_firstName!)/\(_lastName!)", method: .get, header: headers, body: nil, paremeters: nil)
        
        service.connectService(baseUrl: "http://localhost:8081/updateuserinusers/\(userId!)/\(_firstName!)/\(_lastName!)/\(_userName!)/\(_age!)", method: .get, header: headers, body: nil, paremeters: nil)
        
    }
    
    func successConnection(response: Data) {
        Toast(text: "Bilgileriniz başarıyla güncellendi!", delay: 0, duration: 4).show()
    }
    
    func errorConnection(message: String) {
        Toast(text: "Bilgileriniz güncellenemedi!", delay: 0, duration: 4).show()
    }
    
    
}

