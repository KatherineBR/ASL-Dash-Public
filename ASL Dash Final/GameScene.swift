//
//  GameScene.swift
//  ASL Dash Final
//
//  Created by Katherine Byunn-Rieder.
//

import Foundation
import SpriteKit
import UIKit

//anchor point is bottom left

protocol GameViewControllerDelegate: AnyObject {
    func segueGameOver()
    func prepareForGame()
}

class GameScene: SKScene {

    var gameManager = Game()
    var myLabel = SKLabelNode(text:"")
    var scoreLevelLabel = SKLabelNode(text: "Score 0")
    
    var gaming = false
    var hasWon = false
    var level = 0
    let learnTime = 10
    
    var gameViewControllerDelegate: GameViewControllerDelegate?

    let sprite = SKSpriteNode(color: .systemBlue, size: CGSize(width: 20, height: 20))
    var signNode = SKSpriteNode() //hold curSign's
    let line = SKShapeNode()
    var learnInArrNum = 0
    
    convenience init?(level: Int) {
        self.init()
        self.level = level
    }
    
    override func didMove(to view: SKView) { //Use this method to implement behavior for your scene when it is about to be presented by a view. For example, you might use this method to create the scene’s contents.
        
        //view
        self.size = CGSize(width: view.frame.width, height: view.frame.height)
        backgroundColor = .systemBackground
        
        if level != 0{
            gameManager.setup(level: level)
            if level <= 5 {
                learn(view: view)
            } else {
                startGameInScene()
            }
        }
        
        //label placeholder
        myLabel.text = String("LEARN")
        myLabel.fontColor = .label
        myLabel.position = CGPoint(x: view.frame.midX - myLabel.frame.width/2, y: view.frame.midY + view.frame.height/4)
        self.addChild(myLabel)
       
        //sprite
        sprite.anchorPoint = CGPoint(x: 0, y: 0)
        sprite.position = CGPoint(x: (frame.width)/6, y: frame.midY)
        sprite.zPosition = 2
        self.addChild(sprite)
        
        //level
        let levelLabel = SKLabelNode(text: "Level \(level)")
        levelLabel.fontSize = 18
        levelLabel.fontColor = .label
        levelLabel.position = CGPoint(x: view.frame.minX, y: view.frame.height - levelLabel.frame.height - 10)
        self.addChild(levelLabel)
        
        //score
        scoreLevelLabel.text = "Score \(gameManager.score)"
        scoreLevelLabel.fontColor = .label
        scoreLevelLabel.fontSize = 18
        scoreLevelLabel.position = CGPoint(x:view.frame.minX, y: levelLabel.frame.minY - scoreLevelLabel.frame.height - 5)
        //view.frame.width - scoreLevelLabel.frame.width, y: view.frame.height - scoreLevelLabel.frame.height - 10)
        self.addChild(scoreLevelLabel)
        
        //base line
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0 - (frame.width)/2, y: frame.midY), CGPoint(x: frame.width, y: frame.midY)])
        line.path = path
        line.strokeColor = .label
        line.lineWidth = 1
        line.zPosition = -1 //draw in back
        self.addChild(line)
    }
    
    func learn(view: SKView) {
        sprite.isHidden = true
        scoreLevelLabel.isHidden = true
    }
    
    func startGameInScene(){
        gameViewControllerDelegate?.prepareForGame()
        line.removeAllChildren()
        gaming = true
        sprite.isHidden = false
        scoreLevelLabel.isHidden = false
        myLabel.isHidden = true
        addSign(signFileName: gameManager.currSign.image) //CHANGE
    }
    
    func pauseNodes(bool: Bool){
        if bool {
            if let action = signNode.action(forKey: "moving") {
                action.speed = 0
            }
            if let actionSprite = sprite.action(forKey: "jummping") {
                actionSprite.speed = 0
            }
            print("pausing nodes")
        } else {
            if let action = signNode.action(forKey: "moving") {
                action.speed = 1
            }
            if let actionSprite = sprite.action(forKey: "jummping") {
                actionSprite.speed = 1
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gaming {
            if (signNode.position.x) <= (sprite.position.x + sprite.frame.width/2) && (signNode.position.x) >= (sprite.position.x - sprite.frame.width/2) {
                if sprite.position.y >= frame.midY + 2*signNode.size.height/3 {
                    hasJumped()
                } else {
                    gameViewControllerDelegate?.segueGameOver()
                }
            }
            if signNode.position.x <= 0.0 {
                removeFromParent()
            }
        } else {
            if (frame.width - signNode.position.x) >= 2*signNode.size.width {
                showLearn()
            }
            if signNode.position.x <= 0.0 {
                removeFromParent()
                startGameInScene()
            }
            
        }
        super.update(currentTime)
    }
    
    func showLearn() {
        if learnInArrNum <= (gameManager.arrForLevel.count - 1) {
            addSign(signFileName: gameManager.arrForLevel[learnInArrNum].image)
            myLabel.text = "Learn \(gameManager.arrForLevel[learnInArrNum].letter)"
            learnInArrNum += 1
        }
    }
    
    func jumpSprite() {
        let actualDuration = 0.2
        let actionMove = SKAction.move(to: CGPoint(x: (frame.width)/6, y: frame.midY + signNode.size.height + 2), duration: TimeInterval(actualDuration)/2)
        let actionMoveDone = SKAction.move(to: CGPoint(x: (frame.width)/6, y: frame.midY), duration: TimeInterval(actualDuration))
        let actionWait = SKAction.wait(forDuration: 0.5)
        sprite.run(SKAction.sequence([actionMove, actionWait, actionMoveDone]), withKey: "jumping")
    }
    
    func hasJumped(){
        gameManager.score += 1
        gameManager.getNewSignIndex(arr: gameManager.arrForLevel) //changes currsign to a new one in level
        addSign(signFileName: gameManager.currSign.image)
        refreshLabels()
        if gameManager.score >= 15 {
            hasWon = true
            gameViewControllerDelegate?.segueGameOver()
            self.view?.presentScene(nil)
        }
    }
        
    func addSign(signFileName: String) {
        
        signNode = SKSpriteNode(imageNamed: signFileName)
        signNode.setScale(0.5)
      
      // Position the sign slightly off-screen along the right edge,
      // and along a random position along the Y axis as calculated above
        signNode.anchorPoint = CGPoint(x: 0, y: 0)
        signNode.position = CGPoint(x: frame.width, y: frame.midY)
      
      // Add the sign to the scene
        if gaming {
            addChild(signNode)
        } else {
            line.addChild(signNode)
        }
      
      // Determine speed
        var actualDuration = learnTime
        if gaming {
            actualDuration = 4 + Int((15.0-Double(gameManager.score))*0.3)
        }
      
      // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: -frame.width/2, y: frame.midY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        signNode.run(SKAction.sequence([actionMove, actionMoveDone]), withKey: "moving")
    }
    
    func refreshLabels() {
        scoreLevelLabel.text = "Score \(gameManager.score)"
    }
}
