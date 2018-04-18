//
//  DetailViewController.swift
//  StarWarsFun
//
//  Created by James H Layton on 4/18/18.
//  Copyright © 2018 james. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    
    // Segue data
    var data: StarWarPerson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: data could be nil at time, should check in production
        // Display the detailed data
        self.nameLabel.text = self.data!.peopleNameForSegue!
        self.genderLabel.text = self.data!.peopleGenderForSegue!
        self.heightLabel.text = "\(self.data!.peopleHeightForSegue!)cm"
        self.hairColorLabel.text = "\(self.data!.peopleHairColorForSegue!) hair"
    }
}
