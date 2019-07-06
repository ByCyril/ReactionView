//
//  ReactionView.swift
//  FBEffect
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ReactionView: IconView {
    
    override init(iconNamesArray: [String], frame: CGRect) {
        super.init(iconNamesArray: iconNamesArray, frame: frame)
    }
    
    init(iconNamesArray: [String]) {
        let count = iconNamesArray.count
        let frame = CGRect(x: 0, y: 0, width: (50 * count) - 5, height: 50)
        super.init(iconNamesArray: iconNamesArray, frame: frame)
    }
    
    public func centerPosition(center: CGPoint) {
        self.center = center
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
