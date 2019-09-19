//
//  UserEditViewController.swift
//  TwitterAppSB
//
//  Created by KO on 18/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController, UICollectionViewDelegateFlowLayout, ConnectionDelegate {
    
    func successConnection(response: Data) {
        print("okkey")
    }
    
    func errorConnection(message: String) {
        print("nooo")
    }
    
    
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
    
    
    var parameters = [String: Any]()
    
    @IBAction func saveBtn(_ sender: Any) {
        _firstName = firstName.text
        _lastName = lastName.text
        _userName = userName.text
        _age = Int(age.text!)
        
        parameters = ["firstName": _firstName!,
                      "lastName" : _lastName!,
                      "profile": "@" + _userName!,
                      "age": _age ]
        sendData()
        //butona bastıgında servise data yollayacak
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        print("userId: \(userId!)")
        service.connectService(baseUrl: "http://localhost:3000/users/\(userId!)", method: .patch, header: headers, body: nil, paremeters: parameters)
    }
    
}

