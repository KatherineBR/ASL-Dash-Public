//
//  CreditsViewController.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import UIKit

class CreditsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var creditsView: UIView! {
        didSet {
            creditsView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var devWebButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var closeButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        closeButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        creditsView.translatesAutoresizingMaskIntoConstraints = false
        privacyPolicyButton.translatesAutoresizingMaskIntoConstraints = false
        devWebButton.translatesAutoresizingMaskIntoConstraints = false
        bodyText.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        creditsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        creditsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        creditsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        creditsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        let margins = creditsView.layoutMarginsGuide
        closeButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        titleText.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        titleText.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        titleText.heightAnchor.constraint(equalTo: creditsView.heightAnchor, multiplier: 0.2).isActive = true
        
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        privacyPolicyButton.topAnchor.constraint(equalTo: titleText.bottomAnchor).isActive = true
        privacyPolicyButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        privacyPolicyButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

        devWebButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        devWebButton.topAnchor.constraint(equalTo: privacyPolicyButton.bottomAnchor).isActive = true
        devWebButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        devWebButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        bodyText.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        bodyText.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        bodyText.topAnchor.constraint(equalTo: devWebButton.bottomAnchor).isActive = true
        bodyText.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        let yellow = UIColor(red: 252.0/255.0, green: 244.0/255.0, blue: 124.0/255.0, alpha: 1.00)
        creditsView.layer.borderColor = yellow.cgColor
        creditsView.layer.borderWidth = 5
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ppClicked(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://sites.google.com/view/asldash/privacy-policy")! as URL, options: [:], completionHandler: nil)
    }
    @IBAction func devWebClicked(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://sites.google.com/view/asldash/home")! as URL, options: [:], completionHandler: nil)
    }
}
