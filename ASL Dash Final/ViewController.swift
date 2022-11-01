//
//  ViewController.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleText: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet var instructionsButton: UIButton!
    @IBOutlet var infoButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        infoButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        infoButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.topAnchor.constraint(equalTo: margins.topAnchor, constant: view.frame.height/6).isActive = true
        titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidLoad()
    }
}

