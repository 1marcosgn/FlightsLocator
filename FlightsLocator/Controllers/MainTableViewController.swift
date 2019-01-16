//
//  MainTableViewController.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    /// Array to manage the available flights
    var flights = [Flight]()
    let interactor = Interactor.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIForTableView()
        loadInitialTableInformation()
        setUpSearchController()
    }
    
    
    
    

    

}


// MARK: - Extension to handle User interface realted operations
extension MainTableViewController {
    
    func setUpUIForTableView() {
        let nib = UINib(nibName: "FlightCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "flightCell")
        tableView.tableFooterView = FooterView().view
        tableView.separatorStyle = .singleLine //.none //remove separator .. the ui design will be handled in the cell
    }
    
}

// MARK: - Extension to Manage Logic of the App
extension MainTableViewController {
    
    /// will be called initially
    func loadInitialTableInformation() {
        
        /// -- App Cycle -- ///
        
        // First thing, after the app is launched:
        
        // Use the 'interactor' to ask the 'DataManager' if there is already information stored
        
            // if there is local information available then retrieve the 'LocalInformation'
        
            // validate the local information time and compare it to see if it is valid information (no older than 10 minutes)
        
                // if information is older than 10 minutes then get the stored 'airportCode' and use the 'interactor' to 'requestFlightsFor' that airport code, update then the table view, search bar and save the new local information
        
                // if the information is younger than 10 minutes then use that information to fill the sear bar with the 'airportCode' and the 'flights' with local 'flights'
        
            // if No local information is available at all then display a message indication that In order to see information in the table, the user needs to enter a 3 character search in the search bar
    }
    
    
    /// this will get called by the user
    func userLookForInformation() {
        
        /// If response is successfully executed .. hide the search bar
        searchController.isActive = false
        
        
        /// Create a class with a method to validate the user input,
        
            /// it should be only characters between [A-Z] && [a-z], we will transform them to Upper case
        
                    //'searchController.searchBar.text'
        
        /// Once we get a valid user input then:
        
            /// hide the keyboard if visible
 
            /// use the 'interactor' to 'requestFlightsFor' the Airport code introduced
        
            /// on the completion .. update the 'flights' and reload the table view cells
        
            /// this operation should save the information in the nsuserdefaults as we planned
    }
    
    
    
}

// MARK: - Extension to manage Table view data source
extension MainTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12//flights.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightCell", for: indexPath) as! FlightCell
        
        //let achievement = flights[indexPath.item]
        // set up cell here
        
        return cell
    }
    
}



// MARK: - Extension to manage Search Bar
extension MainTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func setUpSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter 3 Letter Airport Code"
        
        searchController.searchBar.autocapitalizationType = .allCharacters
        //searchController.searchBar.enablesReturnKeyAutomatically = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        //filterContentForSearchText(searchController.searchBar.text!)
        
        
    }
    
    
    /// Returns true if the text is empty or nil
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    /// Determines if you are currently filtering results or not
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if ((searchBar.text?.count)! < 3) {
            return
        }
        else {
            /// Fetch flight only if the 3 Letter of the airport are in
            userLookForInformation()
        }

    }
    
    /// Limits the number of character input to 3 and Validates that User has entered Letters Only
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let lenght = (searchBar.text?.count)! + text.count - range.length

        if lenght <= 3 && StringValidator.containsOnlyLetters(text) || text == "\n" {
            return true
        }
        
        return false
    }
    

    
}


