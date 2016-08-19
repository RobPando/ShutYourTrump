//
//  GameViewController.swift
//  Shut Your Trump
//
//  Created by Roberto Pando on 6/10/16.
//  Copyright (c) 2016 Aestheticruz. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import GameKit

var filePath = NSBundle.mainBundle().pathForResource("TrumpApp", ofType: "mp3")
var backingAudio = AVAudioPlayer()
let audioNSURL = NSURL(fileURLWithPath: filePath!)

class GameViewController: UIViewController, GKGameCenterControllerDelegate {
    
  
    
    func play() {
        do {
            backingAudio = try AVAudioPlayer(contentsOfURL: audioNSURL)
        } catch { return print("Cannot Find The Audio") }
        
        backingAudio.numberOfLoops = -1
        backingAudio.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        play()
    
        let scene = MainMenu(size: CGSize(width: 1536, height: 2048))
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            self.authPlayer()
        
        
    }
    
    func saveHighScore(score: Int) {
        if GKLocalPlayer.localPlayer().authenticated   {
            let scoreReporter = GKScore(leaderboardIdentifier: "ShutYourTrumpScore")
            scoreReporter.value = Int64(score)
            
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.reportScores(scoreArray, withCompletionHandler: nil)
        }
    }
    
    
    func authPlayer() {
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            if view != nil {
                self.presentViewController(view!, animated: true, completion: nil)
                
            }
            else {
                print(GKLocalPlayer.localPlayer().authenticated)
            }
        }
        
        
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
