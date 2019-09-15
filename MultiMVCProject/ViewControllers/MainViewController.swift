//
//  MainViewController.swift
//  MultiMVCProject
//
//  Created by Nadzeya Leanovich on 9/15/19.
//  Copyright © 2019 Nadzeya Leanovich. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction func showSnowman(_ sender: Any) {
        
        guard let snowmanVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SnowmanViewController.identifier) as? SnowmanViewController,
            let navigationController = self.navigationController else { return }
        
        navigationController.pushViewController(snowmanVC, animated: true)
    }
}
