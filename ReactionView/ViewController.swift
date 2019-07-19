//
//  ViewController.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReactiveViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let reactiveView = ReactiveView2(frame: CGRect(x: 100, y: 150, width: 150, height: 50))
        reactiveView.addAction(title: nil, image: UIImage(named: "like")!) {
            print("like")
        }
        
        reactiveView.addAction(title: nil, image: UIImage(named: "dislike")!) {
            print("dislike")
        }
        
        reactiveView.addAction(title: nil, image: UIImage(named: "offensive")!) {
            reactiveView.removeFromSuperview()
            print("offensive")
        }
        
        view.addSubview(reactiveView)
    }

}

