//
//  FirstViewController.swift
//  TwitterAppSB
//
//  Created by KO on 17/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    @IBAction func backBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let tweetViewController = storyBoard.instantiateViewController(withIdentifier: "goToTweetVC") as! TweetViewController
        self.present(tweetViewController, animated:true, completion:nil)
    }
    @IBOutlet weak var tweetView: UICollectionView!
    
    // Using for user id didselectitem, sending UserViewController
    var userId: Int?
    
    // Tweet List
    var tweet : [Tweet]? {
        didSet {
            tweetView?.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    
    // Activity Indicator
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // Initilazation
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tweetView?.delegate = self
        tweetView?.dataSource = self
        
        activityIndicatorStarter()
        getTweets()
    }
    
    // Get all tweets in server
    func getTweets() {
        let service = Service(delegate: self)
        let headers = ["Content-Type":"application/json"]
        service.connectService(baseUrl: "http://localhost:3000/tweets", method: .get, header: headers, body: nil, paremeters: nil)
    }
    
    // Activity Indicator starter
    func activityIndicatorStarter() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // Get tweet's user image
    func getImage(url: URL?) -> UIImage {
        //profile image view
        let data = try? Data(contentsOf: url!)
        if(data == nil) {
            Toast(text: "Internete bağlı değilsiniz", delay: 0, duration: 2).show()
        } else {
            return UIImage(data: data!)!
        }
        return UIImage()
    }

    // Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! UserViewController
        vc.userId = self.userId
    }
}

extension TweetViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweet?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let tweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tweetCell", for: indexPath) as! TweetCell
        if(self.tweet != nil){
            
            tweetCell.tweetTF.text = self.tweet![indexPath.item].tweetText
            
            tweetCell.fullNameLbl.text = String(self.tweet![indexPath.item].firstName + " " + self.tweet![indexPath.item].lastName)
            tweetCell.userNameLbl.text = String(self.tweet![indexPath.item].profile)
            
            let url = URL(string: (tweet![indexPath.item].profileImgUrl))
            
            tweetCell.profileImg.image = getImage(url: url)
        }
        return tweetCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.userId = self.tweet![indexPath.item].userId
        self.performSegue(withIdentifier: "goToUserVC", sender: indexPath);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
}

// Service

extension TweetViewController: ConnectionDelegate {
    
    // Success Connection to server
    func successConnection(response: Data) {
        do {
            self.tweet = try JSONDecoder().decode([Tweet].self, from: response)
            DispatchQueue.main.async{
                self.tweetView?.reloadData()
            }
        } catch { print(error)}
    }
    
    // Failure Connection to server
    func errorConnection(message: String) {
        print("Response \(message)")
        Toast(text: message, delay: 0, duration: 3).show()
    }
}

