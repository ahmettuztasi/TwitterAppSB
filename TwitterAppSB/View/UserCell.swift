//
//  UserCell.swift
//  TwitterAppSB
//
//  Created by KO on 17/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UICollectionViewCell {
    
    @IBAction func backBtn(_ sender: Any) {
    }
    @IBOutlet weak var bioTF: UITextView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
}
