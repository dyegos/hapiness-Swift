//
//  PsycologistViewController.swift
//  hapiness
//
//  Created by iPicnic Digital on 12/5/15.
//  Copyright © 2015 Dyego Silva. All rights reserved.
//

import UIKit

class PsycologistViewController: UIViewController
{
    @IBAction func nothing(sender: UIButton)
    {
        performSegueWithIdentifier("nothing", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        var destination = segue.destinationViewController
        if let navCon = destination as? UINavigationController
        {
            destination = navCon.visibleViewController!
        }
        
        if let hvc = destination as? HapinessViewController
        {
            if let indentifier = segue.identifier
            {
                switch indentifier
                {
                case "sad": hvc.hapiness = 0
                case "happy": hvc.hapiness = 100
                case "nothing": hvc.hapiness = 25
                default: hvc.hapiness = 50
                }
            }
        }
    }
}
