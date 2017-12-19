//
//  MainViewController.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import UIKit

class MainViewController : UIViewController {
    // Segmented buttons with the time selected by the user.
    @IBOutlet weak var timeButtons: UISegmentedControl!
    
    // Picker with the chosen subreddit. We'll pick our posts from this subreddit.
    @IBOutlet weak var subredditPicker: UIPickerView!
    
    // MARK: Lifecycle events.
    override func viewDidLoad() {
        // Load the subreddits specified by the user.
    }
    
    // MARK: User interaction.
    @IBAction func editSubredditsPressed(_ sender: UIButton) {
        // Show the subreddit editing screen.
    }
    
    @IBAction func goPressed(_ sender: UIButton) {
        // Show a load view,
        // Load the top 10 posts of the last 24 hours from the selected subreddit,
        // Filter them by time,
        // Show a random one from those!
    }
}
