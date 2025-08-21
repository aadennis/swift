#!/usr/bin/env swift
// as this is a standalone and not a package, execute with:
// swiftc poemDisplay.swift -o poemDisplay.exe
// .\poemDisplay.exe

import UIKit
import PlaygroundSupport

class PoemViewController: UIViewController {
    let lines = [
        "A whisper rides the morning breeze,",
        "Through hedgerows stitched with dew and light,",
        "The sea, half-dreaming, folds and frees",
        "Its silver thoughts in quiet flight.",
        "A crow debates the churchyard spire,",
        "While nettles guard the garden gate,",
        "And somewhere deep in Exmouth’s mire,",
        "The day begins to contemplate."
    ]
    
    let label = UILabel()
    var currentLine = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 48, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.frame = view.bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(label)
        
        showNextLine()
    }

    func showNextLine() {
        guard currentLine < lines.count else { return }
        label.text = lines[currentLine]
        currentLine += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.label.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showNextLine()
            }
        }
    }
}

PlaygroundPage.current.liveView = PoemViewController()