//
//  Service.swift
//  TwitterAppSB
//
//  Created by KO on 17/09/2019.
//  Copyright © 2019 Ahmet Tuztașı. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class Service {
    
    var conDel: ConnectionDelegate?
    
    init(delegate: ConnectionDelegate) {
        self.conDel = delegate
    }
    
    func connectService(baseUrl: String, method: HTTPMethod, header: Dictionary<String, String>, body: Any?, paremeters: [String:Any]?) {
        
        request(baseUrl, method: method, parameters: paremeters, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            
            switch response.result {
            case .success( _): do {
                if(response.data == nil) {
                    Toast(text: "internete bağlı değilsiniz", delay: 0, duration: 4).show()
                } else {
                    self.conDel?.successConnection(response: response.data!)
                }
                }
                
            case .failure( _): do {
                do {
                    throw NSError(domain: "Sunucu Hatsaı", code: 1, userInfo: nil)
                } catch let error as NSError {
                    let tempError: String = String(describing: error)
                    self.conDel?.errorConnection(message: tempError)
                }
                
                }
            }
        }
    }
}

