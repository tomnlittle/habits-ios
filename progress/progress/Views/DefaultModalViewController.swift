//
//  DefaultModelViewController.swift
//  progress
//
//  Created by Thomas Northall-Little on 2/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class DefaultModalViewController: UIViewController {
    
    // screen edge drag gesture
    var screenEdgeGesture: UIScreenEdgePanGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

         addGestures()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Gesture Back Control
    private func addGestures() {
        self.screenEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.dismissModal))
        self.screenEdgeGesture.edges = .left
        self.view.addGestureRecognizer(screenEdgeGesture)
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }

}
