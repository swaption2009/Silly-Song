//
//  ViewController.swift
//  Silly Song
//
//  Created by Ronny Hoesada on 12/6/15.
//  Copyright © 2015 Ronny. All rights reserved.
//

import UIKit

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func reset(sender: AnyObject) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    
    @IBAction func displayLyrics(sender: AnyObject) {
        let fullName = nameField.text?.lowercaseString
        
        if fullName == "" {
            return lyricsView.text = lyricsForName(bananaFanaTemplate, fullName: "NoName")
        } else {
            return lyricsView.text = lyricsForName(bananaFanaTemplate, fullName: fullName!)
        }
    }
    
}


let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joinWithSeparator("\n")


func shortNameFromName(fullName: String) -> String {
    let vowelSet = NSCharacterSet(charactersInString: "aeiou")
    
    if let firstVowelRange = fullName.rangeOfCharacterFromSet(vowelSet, options: .CaseInsensitiveSearch) {
        return fullName.substringFromIndex(firstVowelRange.startIndex)
    }
    
    return fullName
}


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(fullName)
    
    let lyrics = lyricsTemplate
        .stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
        .stringByReplacingOccurrencesOfString("<SHORT_NAME>", withString: shortName)
    
    return lyrics
}