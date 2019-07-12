//
//  TestingClass.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/11/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class TestingClass: UIView {
    
    @objc
    func likeSelected() {
        print("like")
    }
    
    @objc
    func dislikeSelected() {
        print("dislike")
    }
    
    @objc
    func madSelected() {
        print("mad")
    }
}
