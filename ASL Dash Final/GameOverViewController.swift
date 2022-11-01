//
//  LostViewController.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import UIKit

class GameOverViewController: UIViewController {


    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var otherDetail: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playAgainL: UIButton!
    var won = false
    var score = 0
    var level = ""
    var wrong = (image: "", letter: Character("A"), level: 1)
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        playAgainL.translatesAutoresizingMaskIntoConstraints = false
        otherDetail.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.sizeToFit()
        playAgainL.sizeToFit()
        otherDetail.sizeToFit()
        
        playAgainL.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playAgainL.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height/4).isActive = true
        otherDetail.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        otherDetail.bottomAnchor.constraint(equalTo: playAgainL.bottomAnchor, constant: playAgainL.frame.height/2 + 20).isActive = true
        let margins = view.layoutMarginsGuide
        closeButton.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
    }
    
    override func viewDidLoad() {

        if won {
            titleLabel.text = "\(level) COMPLETE!"
            playAgainL.setTitle(" Back to Levels ", for: .normal)
            otherDetail.setTitle(" Main Menu ", for: .normal)
            closeButton.isHidden = true
        } else {
            titleLabel.text = "GAME OVER"
            playAgainL.setTitle(" Try Again ", for: .normal)
            otherDetail.setTitle(" How You Did ", for: .normal)
            closeButton.isHidden = false
        }

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func otherDetailClicked(_ sender: Any) {
        if won {
            performSegue(withIdentifier: "toMain", sender: self)
        } else {
            performSegue(withIdentifier: "toStats", sender: self)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "toStats" {
            let i = segue.destination as? StatsViewController
            i?.score2 = score
            i?.wrong2 = wrong
        }
    }

}
