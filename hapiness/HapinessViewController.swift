//
//  ViewController.swift
//  hapiness
//
//  Created by iPicnic Digital on 12/5/15.
//  Copyright © 2015 Dyego Silva. All rights reserved.
//

import UIKit

class HapinessViewController: UIViewController, faceViewDataSource
{
    @IBOutlet weak var faceView: FaceView!
    {
        didSet { faceView.dataSource = self }
    }
    
    var hapiness: Int = 50 // 0 super sad, 100 super happy
    {
        didSet
        {
            hapiness = min(max(hapiness, 0), 100)
            title = "My hapiness level: \(hapiness)"
            updateUI()
        }
    }
    
    func updateUI()
    {
        faceView?.setNeedsDisplay()
    }
    
    func smilenessForFaceView(sender: FaceView) -> Double?
    {
        return Double(hapiness - 50)/50
    }
}

