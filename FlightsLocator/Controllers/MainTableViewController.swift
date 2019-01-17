//
//  MainTableViewController.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

enum ActivityStatus {
    case start
    case stop
}

class MainTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let errorView = ErrorView()
    
    /// Array to manage the available flights
    var flights = [Flight]()
    
    /// To handle the logic of the app
    let interactor = Interactor.init()
    
    /// To work with the stored information
    var savedInformation: LocalInformation? = nil
    
    // UI ELEMENTS
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
        tableView.separatorStyle = .none //remove separator .. the ui design will be handled in the cell
        tableView.backgroundColor = .gray
        tableView.backgroundView = errorView.view
        updateErrorScreen(errorMessage: "")
    }
    
    /// Updates the error/status string and the activity indicator
    func updateErrorScreen(errorMessage: String, _ activityStatus: ActivityStatus? = nil) {
        errorView.statusMessage.text = errorMessage
        
        if activityStatus == .stop {
            errorView.activityIndicator.stopAnimating()
        } else if activityStatus == .start {
            errorView.activityIndicator.isHidden = false
            errorView.activityIndicator.startAnimating()
        }
    }
}

// MARK: - Extension to Manage Logic of the App
extension MainTableViewController {
    
    /// Will be called initially
    func loadInitialTableInformation() {
        
        /// -- App Cycle -- ///
        // Use the 'interactor' to ask the 'DataManager' if there is already information stored and retrieve it
        let localInformation = interactor.retrieveLocalInformation()
        
        // if there is local information available then
        if localInformation != nil {
            
            if localInformation?.flights.count == 0 {
                updateErrorScreen(errorMessage: "You haven't Search for any Airport Pull Down the Screen to Search", .stop)
                self.title = ""
                return
            }
            
            savedInformation = localInformation
            
            // validate the local information time and compare it to see if it is valid information (no older than 10 minutes)
            guard let storedTime = localInformation?.time else {
                return
            }
            
            let informationAge = TimeConfiguration.getTimeDifferenceInMinutesBetween(dateA: storedTime, dateB: Date())
            
            // if information is older than 10 minutes then
            if informationAge > 10 {
                //get the stored 'airportCode' and use the 'interactor' to 'requestFlightsFor' that airport code, update then the table view, search bar and save the new local information
                guard let airportCode = localInformation?.airportCode else {
                    return
                }
                
                updateErrorScreen(errorMessage: "", .start)
                
                interactor.requestFlightsFor(airportCode) { (success) in
                    if success {
                        guard let fetchedFlights = self.interactor.availableFlights else {
                            return
                        }
                        
                        self.flights = TimeConfiguration.orderBasedOnDate(fetchedFlights) 
                        DispatchQueue.main.async { [unowned self] in
                            self.title = localInformation?.airportCode
                            self.tableView.reloadData()
                            self.updateErrorScreen(errorMessage: "", .stop)
                        }
                    } else {
                        DispatchQueue.main.async { [unowned self] in
                            self.title = airportCode
                            self.flights = [Flight]()
                            self.tableView.reloadData()
                            self.updateErrorScreen(errorMessage: "We were not able to fetch information for " + airportCode + " at this moment", .stop)
                        }
                    }
                }
            } else {
                // if the information is younger than 10 minutes then use that information to fill the sear bar with the 'airportCode' and the 'flights' with local 'flights'
                guard let storedFlights = localInformation?.flights else {
                    return
                }
                
                self.title = localInformation?.airportCode
                flights = storedFlights
                tableView.reloadData()
            }
        } else {
            // if No local information is available at all then display a message indication that In order to see information in the table, the user needs to enter a 3 character search in the search bar
            updateErrorScreen(errorMessage: "You haven't Search for any Airport Pull Down the Screen to Search")
        }
    }
    
    
    /// This will be called by the user
    func userLookInformationFor(airport: String?) {
        /// If response is successfully executed .. hide the search bar
        searchController.isActive = false
        flights = [Flight]()
        tableView.reloadData()

        /// use the 'interactor' to 'requestFlightsFor' the Airport code introduced
        guard let airportCode = airport else {
            return
        }

        updateErrorScreen(errorMessage: "", .start)
        
        interactor.requestFlightsFor(airportCode) { (success) in
            if success {
                /// on the completion .. update the 'flights' and reload the table view cells
                guard let fetchedFlights = self.interactor.availableFlights else {
                    return
                }
                
                self.flights = TimeConfiguration.orderBasedOnDate(fetchedFlights)
                
                if self.flights.count == 0 {
                    DispatchQueue.main.async { [unowned self] in
                        self.updateErrorScreen(errorMessage: "We were not able to fetch information for " + airportCode + " at this moment", .stop)
                        self.title = ""
                    }
                } else {
                    
                    DispatchQueue.main.async { [unowned self] in
                        self.title = airportCode
                        self.savedInformation = LocalInformation(airportCode: airportCode, flights: self.flights, time: Date())
                        self.tableView.reloadData()
                        self.updateErrorScreen(errorMessage: "", .stop)
                        
                        
                    }
                }
            } else {
                DispatchQueue.main.async { [unowned self] in
                    self.title = airportCode
                    self.flights = [Flight]()
                    self.tableView.reloadData()
                    self.updateErrorScreen(errorMessage: "We were not able to fetch information for " + airportCode + " at this moment", .stop)
                    self.title = ""
                }
            }
        }
    }
}

// MARK: - Extension to manage Table view data source
extension MainTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flightCell", for: indexPath) as! FlightCell
        let flight = flights[indexPath.item]
        
        // set up cell here
        cell.number.text = flight.number
        cell.origin.text = flight.originCode
        cell.arrival.text = TimeConfiguration.getHMStringFrom(flight.arrivalTime)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView().view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let localInfo = savedInformation {
            if localInfo.flights.count > 0 {
                let footer = FooterView.init()
                footer.status = "Last Updated: " + (TimeConfiguration.getHMStringFrom(localInfo.time) ?? "--") + " " + TimeConfiguration.getLocalTime()
                return footer.view
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let localInfo = savedInformation {
            if localInfo.flights.count > 0 {
                return 45
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
}

// MARK: - Extension to manage Search Bar
extension MainTableViewController: UISearchBarDelegate {
    
    func setUpSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter 3 Letter Airport Code"
        searchController.searchBar.autocapitalizationType = .allCharacters
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if ((searchBar.text?.count)! < 3) {
            return
        }
        else {
            /// Fetch flight only if the 3 Letter of the airport are in
            userLookInformationFor(airport: searchBar.text)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let lenght = (searchBar.text?.count)! + text.count - range.length

        /// Limits the number of character typed to 3 and Validates that User has entered Letters Only, also detects if the last 'char' is \n to determine if the user pressed 'Search' in the Keyboard
        if lenght <= 3 && StringValidator.containsOnlyLetters(text) || text == "\n" {
            return true
        }
        
        return false
    }
    
}


