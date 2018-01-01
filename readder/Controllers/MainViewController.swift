//
//  MainViewController.swift
//  readder
//
//  Created by Fran González on 17/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import SwiftSpinner

class MainViewController : UIViewController {
    // Segmented buttons with the time selected by the user.
    @IBOutlet weak var timeButtons: UISegmentedControl!
    
    // Button that allows the user to select the subreddit from which to pick the post.
    @IBOutlet weak var selectedSubredditButton: UIButton!
    
    // Name of the selected subreddit.
    var selectedSubreddit: String? = nil
    
    // Story (post) we're going to send the StoryViewController.
    var story: Story? = nil
    
    // MARK: Lifecycle events.
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedSubredditButton.setTitle("select subreddit", for: .normal)
        
        // Initialize the Reddit things.
        SwiftSpinner.show("Connecting to Reddit...")
        _ = RedditApi.getAccessToken().subscribe(
            onNext: { _ in SwiftSpinner.hide() },
            onError: { error in print(error) }
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the top bar.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the top bar again.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: User interaction.
    @IBAction func goPressed(_ sender: UIButton) {
        SwiftSpinner.show("Loading your story from \(selectedSubreddit!)...")
        
        _ = RedditApi.getStories(from: selectedSubreddit!, time: .day).subscribe(
            onNext: { stories in
                self.story = randomStory(from: stories)
                SwiftSpinner.hide()
                
                self.performSegue(withIdentifier: "showStory", sender: sender)
            },
            onError: { error in print(error) }
        )
    }
    
    @IBAction func selectSubredditPressed(_ sender: UIButton) {
        // Load the subreddits from the saved ones by the user and get its names.
        let subreddits = Database.getSavedSubreddits()
        let subredditsName = subreddits.map { $0.name }
        
        StringPickerPopover(title: "Subreddit", choices: subredditsName)
            .setSelectedRow(0)
            .setDoneButton(action: { (popover, selectedRow, selectedString) in
                self.selectedSubredditButton.setTitle(selectedString, for: .normal)
                self.selectedSubreddit = selectedString
            })
            .setCancelButton(title: "Edit", action: { (popover, selectedRow, selectedString) in
                // Override the cancel button to show an edit action that allows the user to edit the subreddits
                // that are shown here. Basically perform the editSubreddits segue.
                self.performSegue(withIdentifier: "editSubreddits", sender: sender)
            })
            .appear(originView: sender, baseViewController: self)
    }
    
    // MARK: Segue-related methods.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Show story segue.
        if segue.identifier == "showStory" {
            // Pass the title and post content of the story.
            let storyViewController = segue.destination as! StoryViewController
            storyViewController.story = story
        }
    }
}
