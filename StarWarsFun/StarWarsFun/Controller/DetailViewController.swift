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
    
    var name: String?
    var gender: String?
    var height: String?
    var hairColor: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("DetailVC Did Load")
        self.nameLabel.text = self.name!
        self.genderLabel.text = self.gender!
        self.heightLabel.text = "\(self.height!)cm"
        self.hairColorLabel.text = "\(self.hairColor!) hair"
    }
}
