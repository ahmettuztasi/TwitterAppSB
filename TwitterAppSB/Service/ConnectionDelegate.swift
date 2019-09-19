//
//  ConnectionDelegate.swift
//  TwitterAppSB
//
//  Created by KO on 17/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation

protocol ConnectionDelegate {
    func successConnection(response: Data)
    func errorConnection(message: String)
}
