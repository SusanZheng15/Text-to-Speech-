//
//  ViewController.swift
//  TextToSpeech
//
//  Created by Susan Zheng on 7/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var speechTextBar: UITextField!
    @IBOutlet weak var accentPickerView: UIPickerView!
    @IBOutlet weak var languageAccentLabel: UILabel!
    
    let speechSynthesizer = AVSpeechSynthesizer() //set the synthesizer
    var speechVoice : AVSpeechSynthesisVoice? //set the voice to nil if there is none or default
    
    var languageTitle : [String] = ["Arabic (Saudi Arabia)", "Chinese (China)", "Chinese (Hong Kong)", "Chinese (Taiwan)", "Czech (Czech Republic)", "Danish (Denmark)", "Dutch (Belgium)", "Dutch (Netherlands)", "English (Australia)", "English (Ireland)", "English (South Africa)", "English (United Kingdom)", "English (United States)", "Finnish (Finland)", "French (Canada)", "French (France)", "German (Germany)", "Greek (Greece)", "Hebrew (Israel)", "Hindi (India)", "Hungarian (Hungary)", "Indonesian (Indonesia)", "Italian (Italy)", "Japanese (Japan)", "Korean (South Korea)", "Norwegian (Norway)", "Polish (Poland)", "Portuguese (Brazil)", "Portuguese (Brazil)", "Romanian (Romania)", "Russian (Russia)", "Slovak (Slovakia)", "Spanish (Mexico)", "Spanish (Spain)", "Swedish (Sweden)", "Thai (Thailand)", "Turkish (Turkey)"]
    
    var languageAccentCode : [String] = ["ar-SA", "zh-CN", "zh-HK", "zh-TW", "cs-CZ", "da-DK", "nl-BE", "nl-NL", "en-AU", "en-IE", "en-ZA", "en-GB", "en-US", "fi-FI", "fr-CA", "fr-FR", "de-DE", "el-GR", "he-IL", "hi-IN", "hu-HU", "id-ID", "it-IT", "ja-JP", "ko-KR", "no-NO", "pl-PL", "pt-BR", "pt-PT", "ro-RO", "ru-RU", "sk-SK", "es-MX", "es-ES", "sv-SE", "th-TH", "tr-TR"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        accentPickerView.delegate = self
        accentPickerView.dataSource = self
        speechSynthesizer.delegate = self
        
        self.accentPickerView.backgroundColor = UIColor.black
        
    }
    
    
    @IBAction func speak(_ sender: AnyObject)
    {
        guard let unwrappedText = speechTextBar.text else {return}
        
        let speechUtterance = AVSpeechUtterance(string: unwrappedText)

        
        // set the voice
        speechUtterance.voice = self.speechVoice
        
        //rate is how fast the voice will go 0.0 - 1.0
        speechUtterance.rate = 0.5
        
        //pitchMultiplier: how high the voice will be 0.0 - 2.0
        speechUtterance.pitchMultiplier = 1.0
        
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
    
    
    
    //UIPickerview delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return languageTitle.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return languageTitle[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        languageAccentLabel.text = languageTitle[row]
        self.speechVoice = AVSpeechSynthesisVoice.init(language: languageAccentCode[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        let titleData = languageTitle[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }
    
    //response touch outside the keyboard
    func tap(_ gesture: UITapGestureRecognizer)
    {
        self.speechTextBar.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.speechTextBar.resignFirstResponder()
        return true
    }
    


}

