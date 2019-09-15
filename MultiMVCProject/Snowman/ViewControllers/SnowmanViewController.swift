//
//  SnowmanViewController.swift
//  MultiMVCProject
//
//  Created by Nadzeya Leanovich on 9/15/19.
//  Copyright © 2019 Nadzeya Leanovich. All rights reserved.
//

import UIKit

class SnowmanViewController: UIViewController, Identifirable {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var snowman: Snowman! { didSet {addGestures()}}
    
    
    private func addGestures() {
        let sel = #selector(Snowman.adjustScale(handleGestureRecognizer:))
        
        let pinch = UIPinchGestureRecognizer(target: snowman,
                                             action: sel)
        
        snowman.addGestureRecognizer(pinch)
        
        let tap = UITapGestureRecognizer(target: snowman, action: #selector(Snowman.changeMood(handleTapRecognizer:)))
        
        snowman.addGestureRecognizer(tap)
        
        let longTap = UILongPressGestureRecognizer(target: snowman, action: #selector(Snowman.closeEyes(handleTapRecognizer:)))
        
        snowman.addGestureRecognizer(longTap)
    }
}
