//
//  ViewController.swift
//  Egg timer
//
//  Created by Andrey on 07.02.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    let eggTimes = ["Soft": 3, //3000
                    "Medium": 4, //4200
                    "Hard": 7] //7200
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = "Choose egg you like!"
      
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            titleLabel.text = "\(totalTime-secondsPassed) secodns"
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    

}

