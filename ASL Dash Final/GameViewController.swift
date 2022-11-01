//
//  GameViewController.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameViewControllerDelegate, UITextInputTraits, UITextFieldDelegate {
    

    @IBOutlet weak var skip: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var skView: SKView!
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var pauseViewLabel: UILabel!

    
    var gameScene: GameScene!
    
    let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .medium, scale: .large)
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        textField.returnKeyType = UIReturnKeyType.go
        textField.delegate = self

        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        textField.isHidden = true
        let yellow = UIColor(red: 252.0/255.0, green: 244.0/255.0, blue: 124.0/255.0, alpha: 1.00)
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = yellow.cgColor
        textField.layer.borderWidth = 5
        pauseView.layer.borderColor = yellow.cgColor
        pauseView.layer.borderWidth = 5
        pauseView.layer.zPosition = 3
        pauseView.isHidden = true
        
        //initial setting of symbol
        if(gameScene.level <= 5){
            skip.setImage(UIImage(systemName: "forward.end.fill", withConfiguration: imageConfiguration), for: .normal)
        } else {
            skip.setImage(UIImage(systemName: "pause.circle", withConfiguration: imageConfiguration), for: .normal)
        }
        
        //game scene
        gameScene.gameViewControllerDelegate = self
        skView.presentScene(gameScene)
        self.view.sendSubviewToBack(skView)
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Pause"), object: nil, queue: nil, using: pauseGame)
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if gameScene.gaming {
            if string.isEmpty {
                return true
            } else if string.rangeOfCharacter(from: CharacterSet.letters) == nil || textField.hasText || string.count > 1 {
                return false
            }
            return true
        }
        return false //if in learn no text can be entered
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.hasText && self.skView.scene?.isPaused == false {
            textField.placeholder = ""
            let letterChoice = Character(textField.text!.first!.uppercased())
            if letterChoice == gameScene.gameManager.currSign.letter { //if checked and correct
                gameScene.jumpSprite() //jumps it
                textField.text = ""
                return true
            }
            segueGameOver()
            return true
        }
        return false
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        if (skip.currentImage == UIImage(systemName: "forward.end.fill", withConfiguration: imageConfiguration)){
            gameScene.startGameInScene()
        }
        //if at ready to pause circle, pause
        else if (skip.currentImage == UIImage(systemName: "pause.circle", withConfiguration: imageConfiguration)){
            pauseView.isHidden = false //show view
            //textField.isEnabled = false //disable text
            textField.resignFirstResponder()
            gameScene.isPaused = true //CHANGED
            gameScene.pauseNodes(bool: true) //pause nodes
            skip.setImage(UIImage(systemName: "play.circle", withConfiguration: imageConfiguration), for: .normal)
            print("pausing based on button")
        }
        //if at ready to play circle, play
        else {
            pauseView.isHidden = true
            gameScene.isPaused = false //CHANGED
            //textField.isEnabled = true
            textField.becomeFirstResponder()
            gameScene.pauseNodes(bool: false)
            skip.setImage(UIImage(systemName: "pause.circle", withConfiguration: imageConfiguration), for: .normal)
        }
    }
    
    func prepareForGame() {
        textField.isHidden = false
        textField.placeholder = "type the letter of the sign"
        skip.setImage(UIImage(systemName: "pause.circle", withConfiguration: imageConfiguration), for: .normal)
    }
    
    func pauseGame(_: Notification){
        gameScene.isPaused = true //CHANGED
        if gameScene.gaming {
            pauseView.isHidden = false
            //textField.isEnabled = false
            textField.resignFirstResponder()
            skip.setImage(UIImage(systemName: "play.circle", withConfiguration: imageConfiguration), for: .normal)
            gameScene.pauseNodes(bool: true)
        }
    }
    
    func segueGameOver () {
        self.performSegue(withIdentifier: "gameOver", sender: self)//to level complete
        self.skView.presentScene(nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOver" {
            let i = segue.destination as? GameOverViewController
            i?.score = gameScene.gameManager.score
            if gameScene.hasWon {
                i?.won = true
                i?.level = levelLets[gameScene.level - 1]
            } else {
                i?.wrong = gameScene.gameManager.currSign
            }
        }
    }
    
        
}
