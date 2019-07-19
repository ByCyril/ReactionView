//
//  ReactiveAction.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/12/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ReactiveAction: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, handler: () -> Void) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
}
