//
//  ViewController.swift
//  EggTimer2
//
//  Created by Tarek Ahmed on 01/06/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    
    let eggTimes = ["Soft": 5, "Medium": 7,  "Hard": 9]
    
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var Done: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessButtonPressed(_ sender: UIButton) {
      
        
        timer.invalidate()
    
        let hardness = (sender.titleLabel!.text)
        
        totalTime = eggTimes[hardness!]!
        secondsPassed = 0 // Reset secondsPassed for the new timer
        progressBar.progress = 0.0 // Reset progress bar
        Done.text = hardness

        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
        
                    }
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            secondsPassed += 1
            
        }
        else{
            progressBar.progress = 1.0
            timer.invalidate()
            Done.text = "DONE!"
            playSound(soundName: "alarm_sound")
        }
        
        
    }
    func playSound(soundName: String) {
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Error: File not found")
            return
        }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    

}

