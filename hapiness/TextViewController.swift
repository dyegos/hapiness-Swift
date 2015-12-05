//
//  TextViewController.swift
//  hapiness
//
//  Created by iPicnic Digital on 12/5/15.
//  Copyright © 2015 Dyego Silva. All rights reserved.
//

import UIKit

class TextViewController: UIViewController
{

    @IBOutlet weak var historyText: UITextView!
    {
        didSet { historyText.text = text }
    }
    
    var text: String = ""
    {
        didSet { historyText?.text = text }
    }
    
    var popoverBounds: CGSize?
    
    override var preferredContentSize: CGSize
    {
        get
        {
            if historyText != nil && presentingViewController != nil
            {
                return historyText.sizeThatFits(popoverBounds ?? presentingViewController!.view.bounds.size)
            }
            else
            { return super.preferredContentSize }
        }
        set { super.preferredContentSize = newValue }
    }
}
