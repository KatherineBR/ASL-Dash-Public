//
//  StatsViewController.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var titleText: UITextView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var missedLabel: UILabel!
    @IBOutlet weak var missedImage: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    var wrong2 = (image: "", letter: Character("A"), level: 1)
    var score2 = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        scoreLabel.text = "Score: \(score2)"
        missedLabel.text = "You missed: \(wrong2.letter)"
        let img = UIImage(named: wrong2.image)
        missedImage.image = img
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        statsView.translatesAutoresizingMaskIntoConstraints = false
        missedImage.translatesAutoresizingMaskIntoConstraints = false
        //missedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        statsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        statsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        let statsHeight = statsView.frame.height - statsView.safeAreaInsets.top - statsView.safeAreaInsets.bottom
        let statsWidth = statsView.frame.width - statsView.safeAreaInsets.left - statsView.safeAreaInsets.right
        
        let margins = statsView.layoutMarginsGuide
        closeButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        titleText.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        titleText.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleText.heightAnchor.constraint(equalTo: statsView.heightAnchor, multiplier: 0.2).isActive = true

        if  statsHeight - 10 * img!.size.width/img!.size.height > statsWidth - missedLabel.frame.width {
            missedImage.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
            missedImage.rightAnchor.constraint(equalTo: missedLabel.trailingAnchor)
            .isActive = true
            missedImage.topAnchor.constraint(equalTo: titleText.bottomAnchor).isActive = true
        } else {
            missedImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10).isActive = true
            missedImage.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
            missedImage.topAnchor.constraint(equalTo: titleText.bottomAnchor).isActive = true
        }
    }
    
    override func viewDidLoad() {
        let yellow = UIColor(red: 252.0/255.0, green: 244.0/255.0, blue: 124.0/255.0, alpha: 1.00)
        statsView.layer.borderColor = yellow.cgColor
        statsView.layer.borderWidth = 5
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
