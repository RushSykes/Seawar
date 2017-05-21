//
//  GridButton.swift
//  SeaWar
//
//  Created by Rush Sykes on 24/04/2017.
//  Copyright © 2017 RS. All rights reserved.
//

import UIKit

class GridButton: UIView {
    
    // Record the coordinates of current grid
    var x: Int = 0;
    var y: Int = 0;
    
    weak var Delegate: GridButtonDelegete? = nil
    
    // Some status of current grid
    // Current status
    var buttonStatus: GridStatus = .isWater
    
    // If it has been visited
    var isVisited = false
    
    // Background color
    var bgColor: UIColor = Singleton.gameInstance.colorWater
    
    // Hint text on the button
    var text: String?
    
    init(frame: CGRect, delegate: GridButtonDelegete) {
        super.init(frame: frame)
        Delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Set the grid to touchable or not-touchable
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Delegate?.updateButton(row: x, col: y)
    }
    
    // Custom draw text function
    func drawText(text: String?) {
        
        // Got nothing to draw
        if text == nil {
            return
        }
        
        // Got something to draw
        else {
            let str: NSString = text! as NSString
            // Prepare attributes for the text that is to be drawn
            // Text color
            let fieldColor = UIColor.black
            
            // Text Font
            let fieldFont = UIFont(name: "Helvetica Neue", size: bounds.width / 2)
            
            // Text attributes
            let attributes: NSDictionary = [
                NSForegroundColorAttributeName: fieldColor,
                NSFontAttributeName: fieldFont!
            ]
            
            // Drawing
            str.draw(in: CGRect(x: bounds.width / 4, y: bounds.width / 4,
                                width: bounds.width, height: bounds.height),
                     withAttributes: attributes as? [String: AnyObject])
            
        }
    }
    
    // Custom draw UIButton function
    override func draw(_ rect: CGRect) {
        
        // Current Context
        let context = UIGraphicsGetCurrentContext()
        
        // Button coord (in pixel)
        let xPos = bounds.origin.x + 1
        let yPos = bounds.origin.y + 1
        
        // Button size
        let width = bounds.size.width - 2
        let height = bounds.size.width - 2
        
        // Button rect
        let button = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        // Add the button to the current context, and draw the text on it
        context!.addRect(button)
        context!.setFillColor(bgColor.cgColor)
        context!.fill(button)
        drawText(text: text)
    }
    
    // Update color and text (or status) of the current GridButton
    fileprivate func updateButtonState() {
        switch buttonStatus {
        case .isWater:
            bgColor = Singleton.gameInstance.colorWater
            text = nil
        case .isShip:
            bgColor = Singleton.gameInstance.colorShip
            text = nil
        case .isHit:
            bgColor = .red
            isUserInteractionEnabled = false
            isVisited = true
            text = "H"
        case .isMissed:
            bgColor = .white
            isUserInteractionEnabled = false
            isVisited = true
            text = "M"
        case .isSunk:
            bgColor = Singleton.gameInstance.colorSunk
            isUserInteractionEnabled = false
            text = "S"
        case .isSelected:
            bgColor = .orange
            text = "╳"
        }
    }
    
    // Yield current grid button status
    var buttonCurrentStatus: GridStatus {
        get{
            return buttonStatus
        }
        set {
            // If the grid has not been visited, we can set its status
            if !isVisited {
                buttonStatus = newValue
                updateButtonState()
                // Notify the system to redraw
                setNeedsDisplay()
            }
        }
    }
}
