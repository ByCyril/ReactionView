//
//  ViewController.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var reactionView: ReactionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        reactionView = ReactionView(iconNames: ["like", "dislike", "funny", "interesting", "offensive"], orientation: .horizontal, vc: self)
        reactionView.backgroundColor = .black
        
    }
    
    
    
    
}

