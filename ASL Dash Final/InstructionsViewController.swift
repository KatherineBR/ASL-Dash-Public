//
//  InstructionsViewController.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak var instructionsView: UIView! {
        didSet {
            instructionsView.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        instructionsView.translatesAutoresizingMaskIntoConstraints = false
        bodyText.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        instructionsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instructionsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        instructionsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        instructionsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        let margins = instructionsView.layoutMarginsGuide
        closeButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        titleText.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        titleText.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleText.heightAnchor.constraint(equalTo: instructionsView.heightAnchor, multiplier: 0.2).isActive = true
        bodyText.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        bodyText.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        bodyText.topAnchor.constraint(equalTo: titleText.bottomAnchor).isActive = true
        bodyText.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        let yellow = UIColor(red: 252.0/255.0, green: 244.0/255.0, blue: 124.0/255.0, alpha: 1.00)
        instructionsView.layer.borderColor = yellow.cgColor
        instructionsView.layer.borderWidth = 5
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

