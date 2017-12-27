//
//  StoryViewController.swift
//  readder
//
//  Created by Fran González on 27/12/17.
//  Copyright © 2017 Fran González. All rights reserved.
//

import UIKit
import WebKit

class StoryViewController: UIViewController {
    // Web view in which we'll show the content of the post.
    @IBOutlet weak var webView: WKWebView!
    
    // Details of the post we're going to show
    var storyTitle: String!
    var storyContent: String!
    
    // MARK: Lifecycle events.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide the navigations bar when the user scrolled through the story.
        navigationController?.hidesBarsOnSwipe = true
        setupNavigationBar()
        showStory()
    }
    
    // MARK: UI setup.
    func setupNavigationBar() {
        self.title = storyTitle
    }
    
    func showStory() {
        self.webView.loadHTMLString(storyContent, baseURL: nil)
    }
}
