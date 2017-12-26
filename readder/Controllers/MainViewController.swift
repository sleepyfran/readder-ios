//
//  MainViewController.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class MainViewController : UIViewController {
    // Segmented buttons with the time selected by the user.
    @IBOutlet weak var timeButtons: UISegmentedControl!
    
    // Button that allows the user to select the subreddit from which to pick the post.
    @IBOutlet weak var selectedSubredditButton: UIButton!
    
    // MARK: Lifecycle events.
    override func viewDidLoad() {
        selectedSubredditButton.setTitle("select subreddit", for: .normal)
        
        // Hide the top bar.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Show the top bar again.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: User interaction.
    @IBAction func goPressed(_ sender: UIButton) {
        // Show a load view,
        // Load the top 10 posts of the last 24 hours from the selected subreddit,
        // Filter them by time,
        // Show a random one from those!
    }
    
    @IBAction func selectSubredditPressed(_ sender: UIButton) {
        // Load the subreddits from the saved ones by the user and get its names.
        let subreddits = Database.getSavedSubreddits()
        let subredditsName = subreddits.map { $0.name }
        
        StringPickerPopover(title: "Subreddit", choices: subredditsName)
            .setSelectedRow(0)
            .setDoneButton(action: { (popover, selectedRow, selectedString) in
                self.selectedSubredditButton.setTitle(selectedString, for: .normal)
            })
            .setCancelButton(title: "Edit", action: { (popover, selectedRow, selectedString) in
                // Override the cancel button to show an eddit action that allows the user to edit the subreddits
                // that are shown here. Basically perform the editSubreddits segue.
                self.performSegue(withIdentifier: "editSubreddits", sender: sender)
            })
            .appear(originView: sender, baseViewController: self)
    }
}
