# ThoughtCtlTask
Imgur Gallery Search App

Xcode Version: 15.0.1
Minimum Deployment Target : 13.0

Overview
This iOS application allows users to search for the top images of the week from the Imgur gallery based on their input query. It provides a toggle feature to switch between a 'List' view and a 'Grid' view for displaying search results.

Features

* Search for top images based on user input
    * Display search results with detailed information:
    * Title
    * Date of the post (local time)
    * Number of additional images
    * Image (thumbnail or larger based on display mode)
* Toggle between 'List' and 'Grid' view
* Sort search results in reverse chronological order

How to Run the App
* Clone the repository or download the project zip file.
* Open the project in Xcode.
* Ensure you have Swift installed.
* Build and run the app on a simulator or a physical device.

Third-Party Libraries
* SDWebImage: For asynchronous image loading and caching.

Design Decisions
* List View: Uses full-width horizontal cells to display detailed information.
* Grid View: Displays larger thumbnails in a grid layout with additional information alongside each thumbnail.
