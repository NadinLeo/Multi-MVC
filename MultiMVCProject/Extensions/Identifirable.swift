//
//  Identifirable.swift
//  MultiMVCProject
//
//  Created by Nadzeya Leanovich on 9/15/19.
//  Copyright © 2019 Nadzeya Leanovich. All rights reserved.
//


import class UIKit.UIViewController

protocol Identifirable {
    static var identifier: String { get }
}


extension Identifirable where Self: UIViewController {
    static var identifier: String {
        get { return String(describing: self) }
    }
}
