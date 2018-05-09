//
//  UIViewControllerFromNibExtension.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import UIKit

extension UIStoryboard {

    func createViewController<T: UIViewController>(withIdentifier id: String) -> T {
        return self.instantiateViewController(withIdentifier: id) as! T
    }
}
