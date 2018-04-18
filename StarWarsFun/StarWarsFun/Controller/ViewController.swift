//
//  ViewController.swift
//  StarWarsFun
//
//  Created by James H Layton on 4/17/18.
//  Copyright © 2018 james. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    private var nextButton: UIButton!
    private var previousButton: UIButton!

    private let parseData = ParseManager.shared
    private let network = NetworkManager.shared
    
    private let loader = LoadingViewHelper()
    private let swData = StarWarData()
    
    private var segueData: StarWarPerson?
    private var people: DownloadPeople?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check network status
        switch self.network.checkStatus() {
        case .NoNetwork, .Unknown:
            // Show alert if no network or unknown
            self.createAlertLabel()
            break
        case .FourG, .Wifi, .OtherNetwork:
            // Present loader and prepare for API request
            self.presentLoader()
            self.people = DownloadPeople()
            self.people?.delegate = self
            break
        }
        
        self.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if the next and previous are empty
        // First time definetley empty
        if self.swData.nextPage != nil && self.swData.nextPage != "" {
            self.nextButton(isEnable: true)
        }
        
        if self.swData.previousPage != nil && self.swData.previousPage != "" {
            self.previousButton(isEnable: true)
        }
    }
    
    @objc func nextButtonTapped() {
        if self.swData.nextPage != "" {
            self.nextButton(isEnable: false)
            self.previousButton(isEnable: false)
            self.presentLoader()
            self.people?.requestPeopleData(withUrl: self.swData.nextPage!)
        }
    }
    
    @objc func previousButtonTapped() {
        if self.swData.previousPage != "" {
            self.nextButton(isEnable: false)
            self.previousButton(isEnable: false)
            self.presentLoader()
            self.people?.requestPeopleData(withUrl: self.swData.previousPage!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details" {
            let dvc = segue.destination as! DetailViewController
            dvc.data = self.segueData!
        }
    }
}

//MARK: - Data Handle
extension ViewController: DownloadPeopleDelegate {
    
    // Return the API request data with a call back function so no dirct access to the data or the request
    func getData(next: String?, previous: String?, people: NSArray) {
        
        // Clean up date for another page of data
        self.swData.removeData()
        
        self.swData.nextPage = next
        self.swData.previousPage = previous
        self.swData.peopleArr = people
        
        // Parse the array of dictionary data and store in the data model class
        self.swData.names.append(contentsOf: self.parseData.parseArrayOfDictionary(self.swData.peopleArr!, object: self.swData.dataObjects[0]))
        self.swData.genders.append(contentsOf: self.parseData.parseArrayOfDictionary(self.swData.peopleArr!, object: self.swData.dataObjects[1]))
        self.swData.heights.append(contentsOf: self.parseData.parseArrayOfDictionary(self.swData.peopleArr!, object: self.swData.dataObjects[2]))
        self.swData.hairColors.append(contentsOf: self.parseData.parseArrayOfDictionary(self.swData.peopleArr!, object: self.swData.dataObjects[3]))
        
        if self.swData.nextPage != "" {
            self.nextButton(isEnable: true)
        }
        
        if self.swData.previousPage != "" {
            self.previousButton(isEnable: true)
        }
        
        self.stopLoader()
        self.myTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.swData.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = self.swData.names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Only let seguedata exist at time but no need keep it
        // Prepare data for segue
        self.segueData = StarWarPerson()
        self.segueData?.peopleNameForSegue = self.swData.names[indexPath.row]
        self.segueData?.peopleGenderForSegue = self.swData.genders[indexPath.row]
        self.segueData?.peopleHeightForSegue = self.swData.heights[indexPath.row]
        self.segueData?.peopleHairColorForSegue = self.swData.hairColors[indexPath.row]
        
        // Segue to next viewcontroller
        self.performSegue(withIdentifier: "Details", sender: self)
    }
}

//MARK: - UI
extension ViewController {
    func updateUI() {
        self.myTableView.tableFooterView = UIView()
        self.createPreviousButton()
        self.createNextButton()
        
        self.nextButton(isEnable: false)
        self.previousButton(isEnable: false)
    }
    
    func presentLoader() {
        self.view.isUserInteractionEnabled = false
        self.loader.startLoaderWith(view: self.view, loadViewColor: .gray, style: .whiteLarge)
    }
    
    func stopLoader() {
        self.view.isUserInteractionEnabled = true
        self.loader.stopLoader()
    }
    
    func nextButton(isEnable: Bool) {
        if isEnable == true {
            self.nextButton.setTitleColor(.black, for: .normal)
        }
        else {
            self.nextButton.setTitleColor(.lightGray, for: .normal)
        }
        self.nextButton.isEnabled = isEnable
    }
    
    func previousButton(isEnable: Bool) {
        if isEnable == true {
            self.previousButton.setTitleColor(.black, for: .normal)
        }
        else {
            self.previousButton.setTitleColor(.lightGray, for: .normal)
        }
        self.previousButton.isEnabled = isEnable
    }
    
    func createNextButton() {
        self.nextButton = UIButton(type: .system)
        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.setTitleColor(.black, for: .normal)
        self.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: UIControlEvents.touchUpInside)
        let nextBarButtonItem = UIBarButtonItem(customView: self.nextButton)
        self.navigationItem.rightBarButtonItem = nextBarButtonItem
    }
    
    func createPreviousButton() {
        self.previousButton = UIButton(type: .system)
        self.previousButton.setTitle("Previous", for: .normal)
        self.previousButton.setTitleColor(.black, for: .normal)
        self.previousButton.addTarget(self, action: #selector(previousButtonTapped), for: UIControlEvents.touchUpInside)
        let previousBarButtonItem = UIBarButtonItem(customView: self.previousButton)
        self.navigationItem.leftBarButtonItem = previousBarButtonItem
    }
    
    func createAlertLabel() {
        let label = UILabel(frame: CGRect(x: self.view.frame.size.width/2-100, y: self.view.frame.size.height/2, width: 200, height: self.view.frame.size.height*0.1))
        label.text = "No network!\nTry again later."
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor.lightGray
        self.view.addSubview(label)
    }
}
