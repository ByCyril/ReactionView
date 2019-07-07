//
//  ViewController.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReactionViewDelegate {

    private var reactionView: ReactionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        reactionView = ReactionView(iconNames: ["like", "dislike", "offensive"], orientation: .vertical, vc: self)
        reactionView.delegate = self
        
    }
    
    func selectedIcon(_ index: Int?) {
        if let index = index {
            print("Selected", index)
        }
    }
}

