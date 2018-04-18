//
//  DownloadPeople.swift
//  StarWarsFun
//
//  Created by James H Layton on 4/17/18.
//  Copyright © 2018 james. All rights reserved.
//

import Foundation

class DownloadPeople: NSObject {
    
    final let urlStr = "https://swapi.co/api/people/"
    
    struct PeopleList {
        let count: Int
        let nextUrl: String
        let previousUrl: String
        let results: NSArray
        
        init(json: [String: Any]) {
            count = json["count"] as? Int ?? -1
            nextUrl = json["next"] as? String ?? ""
            previousUrl = json["previous"] as? String ?? ""
            results = json["results"] as? NSArray ?? [""]
        }
    }
    
    func requestPeopleData(completion: @escaping (_ next: String?, _ previous: String?, _ people: NSArray) -> Void) {
        NetworkManager.shared.requestDataWith(urlStr: self.urlStr, completion: {(data, error) in
            if let err = error {
                print(err)
            }
            else {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] else {return}
                    let peoplelist = PeopleList(json: json)
                    completion(peoplelist.nextUrl, peoplelist.previousUrl, peoplelist.results)
                } catch let jsonError {
                    print("Error with json: ", jsonError)
                }
            }
        })
    }
}
