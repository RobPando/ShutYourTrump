//
//  MainMenu.swift
//  Shut Your Trump
//
//  Created by Roberto Pando on 6/10/16.
//  Copyright © 2016 Aestheticruz. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit
import AVFoundation


class MainMenu: SKScene, GKGameCenterControllerDelegate {
    
    let leaderBoardLabel = SKSpriteNode(imageNamed: "LeaderIcon.png")
    let soundLabel = SKLabelNode(fontNamed: "The Bold Font")
    let onLabel = SKLabelNode(fontNamed: "The Bold Font")
    let offLabel = SKLabelNode(fontNamed: "The Bold Font")



    
    override func didMoveToView(view: SKView) {
        

        let background = SKSpriteNode(imageNamed: "JustFlagBackground.png")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2 , y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        
        let commentName1 = SKLabelNode(fontNamed: "The Bold Font")
        commentName1.text = "We all want"
        commentName1.fontSize = 70
        commentName1.fontColor = SKColor.whiteColor()
        commentName1.position = CGPoint(x: self.size.width * 0.52, y: self.size.height * 0.73)
        commentName1.zPosition = 1
        self.addChild(commentName1)
        
        let commentName2 = SKLabelNode(fontNamed: "The Bold Font")
        commentName2.text = "to do it."
        commentName2.fontSize = 70
        commentName2.fontColor = SKColor.whiteColor()
        commentName2.position = CGPoint(x: self.size.width * 0.52, y: self.size.height * 0.70)
        commentName2.zPosition = 1
        self.addChild(commentName2)
        
        let gameName = SKLabelNode(fontNamed: "The Bold Font")
        gameName.text = "Shut Your"
        gameName.fontSize = 200
        gameName.fontColor = SKColor.whiteColor()
        gameName.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.58)
        gameName.zPosition = 2
        self.addChild(gameName)
        
        let gameNameOutline = SKLabelNode(fontNamed: "The Bold Font")
        gameNameOutline.text = "Shut Your"
        gameNameOutline.fontSize = 202
        gameNameOutline.fontColor = SKColor.blackColor()
        gameNameOutline.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.573)
        gameNameOutline.zPosition = 1
        self.addChild(gameNameOutline)
        
        let gameName1 = SKLabelNode(fontNamed: "The Bold Font")
        gameName1.text = "Trump"
        gameName1.fontSize = 200
        gameName1.fontColor = SKColor.whiteColor()
        gameName1.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.50)
        gameName1.zPosition = 2
        self.addChild(gameName1)
        
        let gameName1Outline = SKLabelNode(fontNamed: "The Bold Font")
        gameName1Outline.text = "Trump"
        gameName1Outline.fontSize = 200
        gameName1Outline.fontColor = SKColor.blackColor()
        gameName1Outline.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.493)
        gameName1Outline.zPosition = 1
        self.addChild(gameName1Outline)
        
        let startGame = SKLabelNode(fontNamed: "The Bold Font")
        startGame.text = "Start Game"
        startGame.fontSize = 150
        startGame.fontColor = SKColor.whiteColor()
        startGame.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.3)
        startGame.zPosition = 1
        startGame.name = "StartButton"
        self.addChild(startGame)
        
        soundLabel.text = "Music:"
        soundLabel.fontSize = 70
        soundLabel.fontColor = SKColor.whiteColor() 
        soundLabel.position = CGPoint(x: self.size.width * 0.6, y: self.size.height * 0.12)
        soundLabel.name = "SoundButton"
        soundLabel.zPosition = 2
        self.addChild(soundLabel)
        
        onLabel.text = "on"
        onLabel.fontSize = 60
        if backingAudio.playing {
        onLabel.fontColor = SKColor.redColor()
        } else {
            onLabel.fontColor = SKColor.whiteColor()
        }
        onLabel.position = CGPoint(x: self.size.width * 0.71, y: self.size.height * 0.12)
        onLabel.zPosition = 1
        self.addChild(onLabel)
        
        offLabel.text = "off"
        offLabel.fontSize = 60
        if backingAudio.playing {
        offLabel.fontColor = SKColor.whiteColor()
        } else {
            offLabel.fontColor = SKColor.redColor()
        }
        offLabel.position = CGPoint(x: self.size.width * 0.77, y: self.size.height * 0.12)
        offLabel.zPosition = 1
        self.addChild(offLabel)
        
        
        leaderBoardLabel.name = "LeaderBoard"
        leaderBoardLabel.setScale(1)
        leaderBoardLabel.zPosition = 1
        leaderBoardLabel.position = CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.15)
        self.addChild(leaderBoardLabel)
        
        
    }
    
    func showLeaderBoard() {
        
        let viewController = self.view!.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        
        gcvc.gameCenterDelegate = self
        
        viewController?.presentViewController(gcvc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func stop() {
        backingAudio.stop()
    
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.locationInNode(self)
            let nodeITapped = nodeAtPoint(pointOfTouch)
            
            if nodeITapped.name == "StartButton" {
                
                let sceneToMove = GameScene(size: self.size)
                sceneToMove.scaleMode = self.scaleMode
                let myTransition = SKTransition.fadeWithDuration(0.5)
                self.view!.presentScene(sceneToMove, transition: myTransition)
                
            }
            if nodeITapped.name == "LeaderBoard"{
                
                self.showLeaderBoard()  
                
            }
            if nodeITapped.name == "SoundButton"{
                
                if onLabel.fontColor == SKColor.redColor() {
                    onLabel.fontColor = SKColor.whiteColor()
                    offLabel.fontColor = SKColor.redColor()
                    stop()
                    
        
                } else {
                    onLabel.fontColor = SKColor.redColor()
                    offLabel.fontColor = SKColor.whiteColor()
                    GameViewController().play()
                }
                
            }
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
}