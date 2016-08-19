//
//  GameOverScene.swift
//  Shut Your Trump
//
//  Created by Roberto Pando on 6/10/16.
//  Copyright © 2016 Aestheticruz. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit


class GameOverScene: SKScene, GKGameCenterControllerDelegate {
    let restartLabel = SKLabelNode(fontNamed: "The Bold Font")
    let menuLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "AmericanBackground.png")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        let gameOverLabel = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLabel.text = "Game"
        gameOverLabel.fontSize = 200
        gameOverLabel.fontColor = SKColor.whiteColor()
        gameOverLabel.position = CGPoint(x: self.size.width*0.35, y: self.size.height*0.7)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let gameOverLabel1 = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLabel1.text = "Over"
        gameOverLabel1.fontSize = 200
        gameOverLabel1.fontColor = SKColor.redColor()
        gameOverLabel1.position = CGPoint(x: self.size.width*0.7, y: self.size.height*0.7)
        gameOverLabel1.zPosition = 1
        self.addChild(gameOverLabel1)
        
        let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        scoreLabel.text = "Quiet Trumps: \(gameScore)"
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.57)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        let defaults = NSUserDefaults()
        var highScoreNumber = defaults.integerForKey("highScoreSaved")
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            saveHighScore(highScoreNumber)

            defaults.setInteger(highScoreNumber, forKey: "highScoreSaved")
            
        }
        let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize = 100
        highScoreLabel.fontColor = SKColor.whiteColor()
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.50)
        self.addChild(highScoreLabel)
        
        restartLabel.text = "Play Again"
        restartLabel.fontSize = 80
        restartLabel.fontColor = SKColor.whiteColor()
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.3)
        self.addChild(restartLabel)
        
        menuLabel.text = "Menu"
        menuLabel.fontSize = 60
        menuLabel.fontColor = SKColor.whiteColor()
        menuLabel.zPosition = 1
        menuLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        self.addChild(menuLabel)
        
    }
    func saveHighScore(score: Int) {
        if GKLocalPlayer.localPlayer().authenticated   {
            let scoreReporter = GKScore(leaderboardIdentifier: "ShutYourTrumpScore")
            scoreReporter.value = Int64(score)
            
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.reportScores(scoreArray, withCompletionHandler: nil)
        }
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.locationInNode(self)
            if restartLabel.containsPoint(pointOfTouch) {
                
                let sceneToMove = GameScene(size: self.size)
                sceneToMove.scaleMode = self.scaleMode
                let myTransition = SKTransition.fadeWithDuration(0.5)
                self.view!.presentScene(sceneToMove, transition: myTransition)

            }
            if menuLabel.containsPoint(pointOfTouch) {
                let sceneToMenu = MainMenu(size: self.size)
                sceneToMenu.scaleMode = self.scaleMode
                let menuTransition = SKTransition.fadeWithDuration(0.5)
                self.view!.presentScene(sceneToMenu, transition: menuTransition)
                
            }
            
        }
    }
    
    
}