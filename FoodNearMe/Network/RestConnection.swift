//
//  RestConnection.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation
import Alamofire

protocol RestConnection {
    func get(url: String,
             parameters: [String: Any]?,
             success: @escaping (Any) -> Void,
             failure: @escaping (Error) -> Void)
}

class AlamofireRestConnection: RestConnection {

    func get(url: String, parameters: [String : Any]?, success: @escaping (Any) -> Void, failure: @escaping (Error) -> Void) {
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
