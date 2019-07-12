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
        
        reactiveView = ReactiveView(target: self,
                                    iconNames: ["like", "dislike", "funny", "interesting", "offensive"],
                                    orientation: .horizontal,
                                    iconSquareSize: 50)
        
//        reactiveView.delegate = self
    
        let selectors = [#selector(ViewController.likeSelected),
                         #selector(ViewController.dislikeSelected),
                         #selector(ViewController.madSelected)]
        
        reactiveView.addActions(self, selectors: selectors)
        reactiveView.present(event: .longPress)

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
    func madSelected() {
        print("mad")
    }
    
    func selectedIcon(_ index: Int) {
        print("Selected", index)

    }
}

