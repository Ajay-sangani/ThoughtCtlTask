//
//  DataViewModel.swift
//  ThoughtCtlTask
//
//  Created by Apple on 01/01/24.
//

import Foundation
class DataViewModel {
    
    var searchResults: [ImgurImage] = [] // Model to hold image data
    var isGridMode = true // To toggle between list and grid
    
    typealias FetchImageUpdatedCallback = (_ message: String?, _ error: Error?) -> Void
    
    var updatedOnImageList: FetchImageUpdatedCallback?
    
    // Function to fetch Imgur images based on search query
    func fetchImagesFromImgur(for query: String) {
        // Make API request using URLSession or Alamofire
        // Parse the response and update the searchResults array
        // Imgur API endpoint for fetching top images of the week
        // CLIENT Secret :: 6052d037a691cb97c5efd68539c4a49f3f2c0d27
        
        let clientID = "a45c02e43990f14" // Replace with your Imgur API client ID
        let searchQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://api.imgur.com/3/gallery/search/top?q=\(searchQuery)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
        
        searchResults = []
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // Parse the JSON response
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                // Access the necessary data from the JSON response and update searchResults array
                if let imageData = json?["data"] as? [[String: Any]] {
                    for image in imageData {
                        // Parse necessary details and create ImgurImage objects
                        let title = image["title"] as? String ?? "Untitled"
                        let date = image["datetime"] as? TimeInterval ?? 0
                        // Convert date to desired format (DD/MM/YY hh:mm am/pm)
                        let formattedDate = self?.formatDateFromTimeStamp(date)
                        let additionalImages = image["images_count"] as? Int ?? 0
                        var imageUrl = ""
                        if let images = image["images"] as? [[String: Any]], let firstImage = images.first {
                            imageUrl = firstImage["link"] as? String ?? ""
                        }
                        
                        let imgurImage = ImgurImage(title: title, date: formattedDate ?? "", additionalImages: additionalImages, imageUrl: imageUrl)
                        self?.searchResults.append(imgurImage)
                    }
                    
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        // Reload TableView or UICollectionView with updated searchResults
                        // self?.tableView.reloadData()
                        self?.updatedOnImageList!(nil,nil)
                    }
                } else {
                    self?.updatedOnImageList!("Something went wrong",nil)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func formatDateFromTimeStamp(_ timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy hh:mm a"
        return dateFormatter.string(from: date)
    }
}
