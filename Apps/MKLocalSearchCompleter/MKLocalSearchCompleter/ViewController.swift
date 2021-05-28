//
//  ViewController.swift
//  MKLocalSearchCompleter
//
//  Created by Александр on 28.05.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchCompleter.delegate = self
    }
}

extension ViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            //get result, transform it to our needs and fill our dataSource
        self.searchResults = completer.results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //handle the error
        print(error.localizedDescription)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let result = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = result.title
        
        let search = MKLocalSearch(request: searchRequest)

        search.start { response, error in
            
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            let item = response.mapItems.first!
            print(item.name!,"\n",item.placemark.coordinate.latitude,item.placemark.coordinate.longitude)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            //change searchCompleter depends on searchBar's text
            if !searchText.isEmpty {
                searchCompleter.queryFragment = searchText
                searchCompleter.resultTypes = .address
            }
        }
}

