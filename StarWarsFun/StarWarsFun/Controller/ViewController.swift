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

    private let network = NetworkManager.shared
    private let people = DownloadPeople()
    private let swData = StarWarData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.network.checkStatus() {
        case .NoNetwork, .Unknown:
            //Show alert message
            break
        case .FourG, .Wifi, .OtherNetwork:
            // Show spinner
            self.getData(dataModel: self.swData, objects: ["name","gender","height","hair_color"])
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }
    
    @objc func nextButtonTapped() {
        
    }
    
    @objc func previousButtonTapped() {
        
    }
}

//MARK: - Data Handle
extension ViewController {
    func getData(dataModel: StarWarData, objects: [String]) {
        self.people.requestPeopleData(completion: {(next, previous, people) in
            dataModel.nextPage = next
            dataModel.previousPage = previous
            dataModel.peopleArr = people
            
            dataModel.names.append(contentsOf: ParseManager.shared.parseArrayOfDictionary(dataModel.peopleArr!, object: objects[0]))
            dataModel.genders.append(contentsOf: ParseManager.shared.parseArrayOfDictionary(dataModel.peopleArr!, object: objects[1]))
            dataModel.heights.append(contentsOf: ParseManager.shared.parseArrayOfDictionary(dataModel.peopleArr!, object: objects[2]))
            dataModel.hairColors.append(contentsOf: ParseManager.shared.parseArrayOfDictionary(dataModel.peopleArr!, object: objects[3]))
            
            // Hide spinner
            self.myTableView.reloadData()
        })
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
        
        //Segue to detail view
    }
}

//MARK: - UI
extension ViewController {
    func updateUI() {
        self.myTableView.tableFooterView = UIView()
    }
    
    func createNextButton() {
        
    }
    
    func createPreviousButton() {
        
    }
}
