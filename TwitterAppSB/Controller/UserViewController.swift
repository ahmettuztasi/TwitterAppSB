//
//  SecondViewController.swift
//  TwitterAppSB
//
//  Created by KO on 17/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var userView: UICollectionView!
    
    // Actity Indicator
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // User model
    var user : User? {
        didSet {
            activityIndicator.stopAnimating()
        }
    }
    
    // if not exist userId, throws exception
    var userId: Int? {
        didSet {
            do{
                if (try checkUserId(id: userId)) {
                    getUserById(userId: userId!)
                }
            }
            catch Check.Id(let err) {
                Toast(text: err, delay: 0, duration: 1).show()
                let appearence = ToastView.appearance()
                appearence.backgroundColor = UIColor.blue
                appearence.textColor = UIColor.white
                appearence.font = UIFont.boldSystemFont(ofSize: 20)
                appearence.cornerRadius = 14
            } catch {
                
            }
        }
    }
    
    // Initilazation
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userView?.delegate = self
        userView?.dataSource = self
        
        // Activity Indicator
        activityIndicatorStarter()
        
        //transition effect
        self.modalTransitionStyle = .crossDissolve
    }
    
    // Get user by userId
    func getUserById(userId: Int) {
        let service = Service(delegate: self)
        let headers = ["Content-Type":"application/json"]
        service.connectService(baseUrl: "http://localhost:3000/users/\(userId)", method: .get, header: headers, body: nil, paremeters: nil)
    }
    
    // Check user by userId
    func checkUserId(id: Int?) throws -> Bool {
        if id == nil {
            throw Check.Id(errmsg: "User'a ait tweet bulunamadı")
        }
        return true
    }
    
    // Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // Activity Indicator
    func activityIndicatorStarter() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}

extension UserViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let userCell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! UserCell
        let fullName: String
        if user?.firstName != nil && user?.lastName != nil {
            fullName = "\(String(describing: user!.firstName)) \(String(describing: user!.lastName))"
            userCell.fullNameLbl.text = String(fullName)
        }
        if user?.age != nil{
            userCell.bioTF.text = "I am \(user!.age) years old"
        }
        if user?.profile != nil {
            userCell.userNameLbl.text = user?.profile
        }
        if user?.profileImgUrl != nil {
            let url = URL(string: (user?.profileImgUrl)!)
            let data = try? Data(contentsOf: url!)
            if(data == nil) {
                Toast(text: "Internete bağlı değilsiniz", delay: 0, duration: 3).show()
            } else {
                userCell.profileImg.image = UIImage(data: data!)
            }
            
        }
        return userCell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTweetVC" {
            
        } else if segue.identifier == "goToEditUser" {
            let vc = segue.destination as! UserEditViewController
            vc.userId = self.userId
        }
    }
}


// Service

extension UserViewController: ConnectionDelegate {
    // Success Connection to server
    func successConnection(response: Data) {
        do{
            let responseModel = try JSONDecoder().decode(User.self, from: response)
            self.user = responseModel
            DispatchQueue.main.async{
                self.userView?.reloadData()
            }
        } catch { print(error)}
    }
    
    // Failure Connection to server
    func errorConnection(message: String) {
        print("errorConnection: \(message)")
        Toast(text: message, delay: 0, duration: 3).show()
    }
}
