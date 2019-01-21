//
//  UITimeCollectionView.swift
//  progress
//
//  Created by Thomas Northall-Little on 13/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UITimeCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBInspectable var numRows: Int = 2
    
    private let times = ["6am", "7am", "8am", "9am", "5pm", "6pm", "7pm", "8pm"]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.delegate = self
        self.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collection view item selected")
    }
    
    // Sets the Number of overall sections in the view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Sets the Number of Cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return times.count
    }
    
    // Control cells being added to the board
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath)
 
        let button: UIRoundedButton = UIRoundedButton()
        
        button.frame = cell.frame
        button.center = CGPoint(x: cell.frame.width / 2.0, y: cell.frame.height / 2.0)
        button.setTitle(self.times[indexPath.item], for: .normal)
        button.addTarget(self, action: #selector(UITimeCollectionView.cellTouched(button:)), for: .touchUpInside)
        cell.addSubview(button)
        
        return cell
    }
    
    // Adjust cell size -> Tries to ensure that the View is always fully populated
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellHeight: CGFloat = self.frame.height / CGFloat(self.numRows) - 5
        let cellWidth: CGFloat = (self.frame.width * CGFloat(self.numRows)) / CGFloat(self.times.count)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    @objc func cellTouched(button: UIRoundedButton) {
        
    }
}
