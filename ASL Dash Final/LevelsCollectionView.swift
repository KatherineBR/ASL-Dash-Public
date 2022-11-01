//
//  LevelsCollectionView.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import UIKit

var levelNums = ["1", "2", "3", "4", "5", "6", "7", "8"]
var levelLets = ["A-E", "F-J", "K-O", "P-T", "U-Z", "A-O", "P-Z", "A-Z"]

class LevelsCollectionView: UIViewController {
    
    @IBOutlet weak var chooseLevelView: UIView! {
        didSet {
            chooseLevelView.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var levelTitle: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var levelsCollectionView: UICollectionView!
    var levelChosen = 0
    
    override func viewDidLoad () {
        self.levelsCollectionView.dataSource = self
        self.levelsCollectionView.delegate = self
        
        view.translatesAutoresizingMaskIntoConstraints = false
        chooseLevelView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        levelsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        chooseLevelView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        chooseLevelView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85).isActive = true
        chooseLevelView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chooseLevelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let margins = chooseLevelView.layoutMarginsGuide
        levelsCollectionView.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        levelsCollectionView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        levelsCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        levelsCollectionView.topAnchor.constraint(equalTo: levelTitle.bottomAnchor, constant: 20).isActive = true
        closeButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        let yellow = UIColor(red: 252.0/255.0, green: 244.0/255.0, blue: 124.0/255.0, alpha: 1.00)
        chooseLevelView.layer.borderColor = yellow.cgColor
        chooseLevelView.layer.borderWidth = 5
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "levelToGame" {
            let i = segue.destination as? GameViewController
            i?.gameScene = GameScene(level: levelChosen)
        }
    }
    
}

extension LevelsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levelNums.count
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! LevelsCollectionViewCell
        cell.setCenterImage(img: levelLets[indexPath.row], cellWidth: (collectionView.frame.width)/4 - 30, cellHeight: (collectionView.frame.height)/2 - 25)
        return cell
    }
}

extension LevelsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        levelChosen = indexPath.row + 1
        performSegue(withIdentifier: "levelToGame", sender: self)
    }
}

extension LevelsCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 90, height: 30)
        return CGSize(width: (collectionView.frame.width)/4 - 30, height: (collectionView.frame.height)/2 - 25)
        //30 bc 20 for insets and 10 for space between
        //25 bc 15 for insets and 10 for space between
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 10, bottom: 10, right: 10)
    }
}

