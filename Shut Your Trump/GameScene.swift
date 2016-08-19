//
//  GameScene.swift
//  Shut Your Trump
//
//  Created by Roberto Pando on 6/10/16.
//  Copyright (c) 2016 Aestheticruz. All rights reserved.
//

import SpriteKit
import GameKit

//global gamescore variable
var gameScore = 0

class GameScene: SKScene {
    
    let tapedMouthSound = SKAction.playSoundFileNamed("mouthTaped.wav", waitForCompletion: false)
    
    
    // label for game score
    let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    
    let tapToStart = SKLabelNode(fontNamed: "The Bold Font")
    
    var levelNumber = 0
    
    var livesNumber = 1
    
    
    
    enum gameState {
        case preGame // before the game starts
        case inGame // while the game is being played
        case afterGame // after the game ends
    }
    
    var currentGameState = gameState.preGame
    
    
    //randomize x position of the spawning trumps
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min min: CGFloat, max: CGFloat) ->  CGFloat {
        return random() * (max - min) + min
    }
    // Start of the declaration of the game area
    let gameArea: CGRect
    
    override init(size: CGSize) {
        
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // End of the declaration of the game area
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        gameScore = 0
        let background = SKSpriteNode(imageNamed: "JustFlagBackground.png")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        // mics are on top of all z position
        let backgroundMic = SKSpriteNode(imageNamed: "Mic.png")
        backgroundMic.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.01)
        backgroundMic.zPosition = 3
        self.addChild(backgroundMic)
        
        
        //Label
        scoreLabel.text = "Quiet Trumps: 0"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        scoreLabel.position = CGPoint(x: self.size.width * 0.15, y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        let moveToScreen = SKAction.moveToY(self.size.height * 0.95, duration: 0.3)
        scoreLabel.runAction(moveToScreen)
        
     
        //Label
        tapToStart.text = "Tap To Start"
        tapToStart.fontSize = 100
        tapToStart.fontColor = SKColor.whiteColor()
        tapToStart.zPosition = 2
        tapToStart.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStart.alpha = 0
        
        
        self.addChild(tapToStart)
        let fadeInAction = SKAction.fadeInWithDuration(0.3)
        tapToStart.runAction(fadeInAction)
        
        
        
    }
    
    func startGame() {
        
        //When called the currentGameState will be changed to inGame.
        currentGameState = gameState.inGame
        
        let fadeOutAction = SKAction.fadeInWithDuration(0.5)
        let deleteAction = SKAction.removeFromParent()
        let startLevelAction = SKAction.runBlock(startNewLevel)
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction, startLevelAction])
        
        tapToStart.runAction(deleteSequence)
        
    }
    
    func loseALife(){
        livesNumber -= 1
        
        
        if livesNumber == 0 {
            runGameOver()
        }
        
    }
    func addScore(){
        gameScore += 1
        scoreLabel.text = "Quiet Trumps: \(gameScore)"
        
        // LEVELS as gamescore increases.
        if gameScore == 2 || gameScore == 5 || gameScore == 10 || gameScore == 20 || gameScore == 30 || gameScore == 70 || gameScore == 90 || gameScore == 120 || gameScore == 150 || gameScore == 300 || gameScore == 500 || gameScore == 1000 || gameScore == 2000 || gameScore == 3000 || gameScore == 5000 || gameScore == 10000 || gameScore == 15000 || gameScore == 30000 || gameScore == 50000 || gameScore == 100000 {
            startNewLevel()
        }
        
    }
    func runGameOver() {
        
        currentGameState = gameState.afterGame
        
        self.removeAllActions()
        
        self.enumerateChildNodesWithName("talkingTrump"){
            trump, stop in
            trump.removeAllActions()
        }
        
        let changeSceneAction = SKAction.runBlock(changeScene)
        let waitToChangeScene = SKAction.waitForDuration(1)
        let changeSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.runAction(changeSequence)
        
    }
    func changeScene() {
        
        let sceneToMove = GameOverScene(size: self.size)
        sceneToMove.scaleMode = self.scaleMode
        let mytransition = SKTransition.fadeWithDuration(0.5)
        self.view!.presentScene(sceneToMove, transition: mytransition)
        
    }
    
    func startNewLevel() {
        
        levelNumber += 1
        
        if self.actionForKey("spawningTrumps") != nil {
            self.removeActionForKey("spawningTrumps")
        }
        //waiting for spawning will decrease in time as the levels move on.
        var levelDuration = NSTimeInterval()
        switch levelNumber {
        case 1: levelDuration = 3
        case 2: levelDuration = 2
        case 3: levelDuration = 1.2
        case 4: levelDuration = 0.8
        case 5: levelDuration = 0.7
        case 6: levelDuration = 0.6
        case 7: levelDuration = 0.5
        case 8: levelDuration = 0.5
        case 9: levelDuration = 0.5
        case 10: levelDuration = 0.4
        case 11: levelDuration = 0.4
        case 12: levelDuration = 0.4
        case 13: levelDuration = 0.3
        case 14: levelDuration = 0.3
        case 14: levelDuration = 0.3
        case 15: levelDuration = 0.3
        case 16: levelDuration = 0.3
        case 17: levelDuration = 0.3
        case 18: levelDuration = 0.3
        case 19: levelDuration = 0.2
        case 20: levelDuration = 0.2
            
        default: levelDuration = 0.2
        }
        
        
        
        let spawn = SKAction.runBlock(spawnTrumps)
        let waitToSpawn = SKAction.waitForDuration(levelDuration)
        let spawnSequence = SKAction.sequence([spawn, waitToSpawn])
        let spawnForever = SKAction.repeatActionForever(spawnSequence)
        self.runAction(spawnForever, withKey: "spawningTrumps")
        
    }
    
    func spawnTrumps() {
        
        let trump = SKSpriteNode(imageNamed: "TrumpAppDrawing.png")
        
        //Name is given to identify the object for when it gets tapped and know the location.
        trump.name = "talkingTrump"
        
        
        //change the speed of the falling objects as the level changes.
        var levelSpeed = NSTimeInterval()
        switch levelNumber {
        case 1: levelSpeed = 20
        case 2: levelSpeed = 8
        case 3: levelSpeed = 7
        case 4: levelSpeed = 4
        case 5: levelSpeed = 3
        case 6: levelSpeed = 3
        case 7: levelSpeed = 2
        case 8: levelSpeed = 2
        case 9: levelSpeed = 2
        case 10: levelSpeed = 1.8
        case 11: levelSpeed = 1.7
        case 12: levelSpeed = 1.6
        case 13: levelSpeed = 1.5
        case 14: levelSpeed = 1.3
        case 14: levelSpeed = 1.2
        case 15: levelSpeed = 1.1
        case 16: levelSpeed = 1
        case 17: levelSpeed = 0.8
        case 18: levelSpeed = 0.8
        case 19: levelSpeed = 0.5
        case 20: levelSpeed = 0.5
            
        default: levelSpeed = 0.5
        }
        
        //Calling the random function for the X position within the gameArea that was established.
        let randomX = random(min: CGRectGetMinX(gameArea) + trump.size.width / 2 , max: CGRectGetMaxX(gameArea) - trump.size.width / 2)
        
        
        let startPoint = CGPoint(x: randomX, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomX, y: -self.size.height * 0.0001)
        
        
        
        trump.setScale(3)
        trump.position = startPoint
        trump.zPosition = 2
        
        //If trump reaches  the endPoint it will lose a life.
        let moveTrump = SKAction.moveTo(endPoint, duration: levelSpeed)
        let loseALifeAction = SKAction.runBlock(loseALife)
        let trumpLife = SKAction.sequence([moveTrump, loseALifeAction])
        
        
        if currentGameState == gameState.inGame {
            trump.runAction(trumpLife)
        }
        
        self.addChild(trump)
        
    }
    
    // Trump with the mouth taped
    func tapeMouth(spawnPosition: CGPoint){
        let tapedTrump = SKSpriteNode(imageNamed: "ShutYourTrump.png")
        tapedTrump.position = spawnPosition
        tapedTrump.setScale(3)
        tapedTrump.zPosition = 1
        self.addChild(tapedTrump)
        let fadeOut = SKAction.fadeOutWithDuration(0.8)
        let delete = SKAction.removeFromParent()
        let tapedMouthSequence = SKAction.sequence([tapedMouthSound, fadeOut, delete])
        tapedTrump.runAction(tapedMouthSequence)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            //tap anywhere and startGame is called.
            if currentGameState == gameState.preGame  {
                startGame()
            }
            else {
                if (touchedNode.name == "talkingTrump") {
                    // only shut trump up if the game is inGame
                    if currentGameState == gameState.inGame {
                        touchedNode.removeFromParent()
                        tapeMouth(touchedNode.position)
                        addScore()
                        
                    }
                }
            }
            
        }
    }

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
