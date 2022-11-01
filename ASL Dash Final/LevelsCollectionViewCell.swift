//
//  LevelsCollectionViewCell.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import UIKit

class LevelsCollectionViewCell: UICollectionViewCell {
    
    func setCenterImage(img: String, cellWidth: Double, cellHeight: Double) {
        let image = UIImage(named: img)
        let imgHeight = cellWidth*image!.size.height/image!.size.width
        let imageView = UIImageView(frame: CGRect(x: 0, y: cellHeight/2 - imgHeight/2, width: cellWidth, height: imgHeight)) // set as you want
        imageView.image = image
        imageView.layer.zPosition = 1
        self.addSubview(imageView)
    }
}
