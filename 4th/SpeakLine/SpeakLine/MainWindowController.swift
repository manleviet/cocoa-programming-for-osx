//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Lê Viết Mẫn on 8/10/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate
{
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    let speechSynth = NSSpeechSynthesizer()
    let voices = NSSpeechSynthesizer.availableVoices() as! [String]
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }
    
    let preferenceManager = PreferenceManager()
    
    func updateButtons () {
        stopButton.enabled = isStarted
        speakButton.enabled = !isStarted
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        speechSynth.delegate = self
        for voice in voices {
            println(voiceNameForIdentifier(voice)!)
        }
        let defaultVoice = preferenceManager.activeVoice!
        if let defaultRow = find(voices, defaultVoice) {
            let indices = NSIndexSet(index: defaultRow)
            tableView.selectRowIndexes(indices, byExtendingSelection: false)
            tableView.scrollRowToVisible(defaultRow)
        }
        textField.stringValue = preferenceManager.activeText!
    }
    
    // MARK - Action methods
    @IBAction func speakIt(sender: NSButton) {
        speak()
    }
    
    func speak() {
        let string = textField.stringValue
        if string.isEmpty {
            print("string form \(textField) is empty")
        } else {
            speechSynth.startSpeakingString(string)
            isStarted = true
        }
    }
    
    @IBAction func stopIt(sender: NSButton) {
        speechSynth.stopSpeaking()
    }
    
    // MARK - conform NSSpeechSynthesizerDelegate
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
    }
    
    func voiceNameForIdentifier(identifier: String) ->String? {
        if let attributes = NSSpeechSynthesizer.attributesForVoice(identifier) {
            return attributes[NSVoiceName] as? String
        } else {
            return nil
        }
    }
    
    // MARK - conform NSWindowDelegate
    func windowShouldClose(sender: AnyObject) -> Bool {
        return !isStarted
    }
    
    // MARK - conform NSTableViewDataSource
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let voice = voices[row]
        let voiceName = voiceNameForIdentifier(voice)
        return voiceName
    }
    
    // MARK - conform NSTableViewDelegate
    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = tableView.selectedRow
        if row == -1 {
            speechSynth.setVoice(nil)
            return
        }
        let voice = voices[row]
        speechSynth.setVoice(voice)
        preferenceManager.activeVoice = voice
        speak()
    }
    
    // MARK - NSTextFieldDelegate
    override func controlTextDidChange(obj: NSNotification) {
        preferenceManager.activeText = textField.stringValue
    }
}
