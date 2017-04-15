//
//  ViewController.swift
//  TextToSpeech
//
//  Created by Susan Zheng on 7/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate
{
    let speechSynthesizer = AVSpeechSynthesizer() //set the synthesizer
    var speechVoice : AVSpeechSynthesisVoice? //set the voice to nil if there is none or default, idk
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        speechSynthesizer.delegate = self
        self.speechVoice = AVSpeechSynthesisVoice.init(language: "en-AU")
    }
    
  
    
    @IBAction func speak(_ sender: AnyObject)
    {
        let speechUtterance = AVSpeechUtterance(string: "Pokemon, gotta catch em all")

        
        // set the voice
        speechUtterance.voice = self.speechVoice
        
        //rate is how fast the voice will go 0.0 - 1.0
        speechUtterance.rate = 0.5
        
        //pitchMultiplier: how high the voice will be 0.0 - 2.0
        speechUtterance.pitchMultiplier = 2.0
        
        // Volume from 0.0 to 1.0 (default 1.0)
        speechUtterance.volume = 1.0
        
        //make it speak
        speechSynthesizer.speak(speechUtterance)
        
    }
    
    // Called before speaking an utterance
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance)
    {
        print("About to say '\(utterance.speechString)'");
    }
    
    
    // Called when the synthesizer is finished speaking the utterance
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance)
    {
        print("Finished saying '\(utterance.speechString)");
    }
    


}

