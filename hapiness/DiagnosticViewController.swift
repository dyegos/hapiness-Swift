//
//  DiagnosticViewController.swift
//  hapiness
//
//  Created by iPicnic Digital on 12/5/15.
//  Copyright © 2015 Dyego Silva. All rights reserved.
//

import UIKit

class DiagnosticViewController: HapinessViewController, UIPopoverPresentationControllerDelegate
{
    override var hapiness:Int
    {
        didSet { diagnosticHistory += [hapiness] }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    var diagnosticHistory: [Int]
    {
        get { return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? [Int]() }
        set
        {
            defaults.setObject(newValue, forKey: History.DefaultsKey)
            defaults.synchronize()
        }
    }
    
    private struct History
    {
        static let SegueIdentifier = "showHistory"
        static let DefaultsKey = "diagnosticHistory.key"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let identifier = segue.identifier
        {
            if identifier != History.SegueIdentifier { return }
            
            if let vc = segue.destinationViewController as? TextViewController
            {
                if let ppc = vc.popoverPresentationController { ppc.delegate = self }
                vc.text = "History: \(diagnosticHistory)"
                vc.popoverBounds = self.view.bounds.size
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
    }

}
