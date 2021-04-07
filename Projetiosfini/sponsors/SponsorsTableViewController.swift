//
//  SponsorsTableViewController.swift
//  Projetiosfini
//
//  Created by user187202 on 3/31/21.
//

import UIKit

struct FieldsData: Codable{
    var company: String?
    //let Status: String?
    var contact: [String]?
    var Sponsoredamount: Int?
    private enum CodingKeys: String, CodingKey {
        case Sponsoredamount = "Sponsored amount"
        case company = "Company"
        case contact = "Contact(s)"
        case notes = "Notes"
    }
    //let Previous_sponsor: Bool?
    var notes: String?
}

struct DataSponsor: Codable{
    var id: String?
    var fields: FieldsData
    //let createTime: String?
}

struct ResponseData: Codable {
    var records: [DataSponsor]
}


struct FieldsDataName: Codable{
    var Name:String?
}


struct NameData: Codable {
    
    var id: String?
    var fields: FieldsDataName?
}

class SponsorsTableViewController: UITableViewController {
    
    var resultSponsor: ResponseData!
    var resultSponsorCount: Int = 0
    
    override func viewDidLoad() {
        let url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors?api_key=key1gxH6SEzy1SOJS&view=All%20sponsor%20companies"
        getData(from: url)
        while(self.resultSponsorCount == 0){
            
        }
        super.viewDidLoad()
        
    }
    
    public func getData(from url: String){
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else{
                print("error")
                return
            }
            
            
            //hava data
            
            do{
                self.resultSponsor = try JSONDecoder().decode(ResponseData.self, from: data)
                
                for index in (0...self.resultSponsor.records.count-1) {
                    self.getDataName(from: self.resultSponsor.records[index].fields.contact ?? [], from: index)
                }
                
                
            }
            catch{
                print("fail \(error.localizedDescription)")
            }
            
            
        })
        
        task.resume()
        
        
    }

    public func getDataName(from id: [String], from test : Int){
          var count = 0
          for i in id{
          
          let url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees/"+i+"?api_key=key1gxH6SEzy1SOJS"
            print(url)
          let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
              guard let data = data, error == nil else{
                  print("error")
                  return
              }
              
              
              //hava data
              
            var vroom: NameData?
              do{
                vroom = try JSONDecoder().decode(NameData.self, from: data)
                self.resultSponsor.records[test].fields.contact?[count] = vroom?.fields?.Name ?? ""
                count += 1
                
                if (test == self.resultSponsor.records.count-1){
                    self.resultSponsorCount = self.resultSponsor.records.count
                }
                  
              }
              catch{
                  print("fail \(error.localizedDescription)")
              }
              
              
          })
          
          task.resume()
          }
      }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return resultSponsorCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sponsorCell", for: indexPath) as! SponsorsTableViewCell
        
            
        cell.sponsorName?.text = "Nom du sponsort : " + (self.resultSponsor.records[indexPath.row].fields.company ?? "")
        cell.sponsorNote?.text = "Note du sponsort : " + (self.resultSponsor.records[indexPath.row].fields.notes ?? "")
        let amount : Int? = self.resultSponsor.records[indexPath.row].fields.Sponsoredamount
        
        cell.sponsorAmount?.text = "Montant du don : "
        if (amount != nil){
            cell.sponsorAmount?.text! += String(amount!)
        }
        
        var contact = "Contact : "
        for i in self.resultSponsor.records[indexPath.row].fields.contact ?? [] {
            print(i)
            contact += i
        }
        
        cell.sponsorContact?.text = contact
        
        
       

        return cell
    }

}
