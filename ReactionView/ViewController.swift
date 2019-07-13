//
//  ViewController.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReactiveViewDelegate {

    private var reactiveView: ReactiveView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

//        Step 1) Instantiate
        reactiveView = ReactiveView(target: self,
                                    iconNames: ["like", "dislike", "offensive"],
                                    orientation: .vertical)
        
//        Step 2) Optional - Prepare the delegate
        reactiveView.delegate = self
    
//        Step 3) Pass an array of actions
        let selectors = [#selector(ViewController.likeSelected),
                         #selector(ViewController.dislikeSelected),
                         #selector(ViewController.offensiveSelected)]
        
        reactiveView.addActions(self, selectors: selectors)
        
//        Step 4) Specify the presentation style
        reactiveView.presentOn(with: .longPress)

    }
    
    @objc
    func likeSelected() {
        print("like")
    }
    
    @objc
    func dislikeSelected() {
        print("dislike")
    }
    
    @objc
    func offensiveSelected() {
        print("offensive")
    }
    
    func selectedIcon(_ index: Int) {
        print("Selected", index)

    }
}

