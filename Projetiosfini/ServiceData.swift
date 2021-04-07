//
//  ServiceData.swift
//  Projetiosfini
//
//  Created by user187202 on 4/3/21.
//

import Foundation
func getJson(completion: @escaping (Response) -> ()) {
    let urlString = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees?api_key=key1gxH6SEzy1SOJS&maxRecords=3&view=All%20people"
    if let url = URL(string: urlString){
        URLSession.shared.dataTask(with: url){ data, res, err in
            if let data = data {
                print("heyfh")
                
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(Response.self, from: data){
                    print("ok")
                    completion(json)
                    
                    
                }
                print(data)
            }
            
        }.resume()
    }
}
