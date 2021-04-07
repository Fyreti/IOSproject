//
//  AttendeeTableViewController.swift
//  Projetiosfini
//
//  Created by user187202 on 3/24/21.
//
struct FieldsDataAttendee: Codable{
    var role: String?
    var company: [String]?
    var name: String?
    var email: String?
    var speaking: [String]?
    var phone: String?
    private enum CodingKeys: String, CodingKey {
        case role = "Role"
        case email = "Email"
        case speaking = "Speaking at"
        case name = "Name"
        case company = "Company"
        case phone = "Phone"
    }
}

struct DataAttendee: Codable{
    let id: String?
    var fields: FieldsDataAttendee
    //let createTime: String?
}

struct ResponseDataAttendee: Codable {
    var records: [DataAttendee]
}


struct NameCompagnie: Codable {
    let id: String
    let fields: FieldsCompagnie
    let createdTime: String
}

// MARK: - Fields
struct FieldsCompagnie: Codable {
    let company: String

    enum CodingKeys: String, CodingKey {
        case company = "Company"
    }
}




struct SpeakingAt: Codable {
    let id: String
    let fields: SpeakingAtFields
    let createdTime: String
}

// MARK: - Fields
struct SpeakingAtFields: Codable {
    let topicTheme, speakerS: [String]
    let end, activity, type, start: String
    let location: [String]

    enum CodingKeys: String, CodingKey {
        case topicTheme = "Topic / theme"
        case speakerS = "Speaker(s)"
        case end = "End"
        case activity = "Activity"
        case type = "Type"
        case start = "Start"
        case location = "Location"
    }
}

import UIKit


class AttendeeTableViewController: UITableViewController {
    var resultAttendee: ResponseDataAttendee!
    var resultAttendeeCount: Int = 0
    override func viewDidLoad() {
        
        let url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees?api_key=key1gxH6SEzy1SOJS&maxRecords=3&view=All%20people"
        getData(from: url)
        while(self.resultAttendeeCount == 0){
            
        }
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    public func getData(from url: String){
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else{
                print("error")
                return
            }
            
            
            //hava data
            
            do{
                self.resultAttendee = try JSONDecoder().decode(ResponseDataAttendee.self, from: data)
                
                for index in (0...self.resultAttendee.records.count-1) {
                    self.getDataName(from: self.resultAttendee.records[index].fields.company ?? [], from: index, from:"compagnie")
                    self.getDataName(from: self.resultAttendee.records[index].fields.speaking ?? [], from: index, from:"speakeur")
                }
                
                
            }
            catch{
                print("fail \(error.localizedDescription)")
            }
            
            
        })
        
        task.resume()
        
        
    }
    
    public func getDataName(from id: [String], from test : Int, from which: String){
            var count = 0
            var url = ""
            for i in id{
            if (which == "compagnie"){
                url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors/"+i+"?api_key=key1gxH6SEzy1SOJS"
            }
            if (which == "speakeur"){
                url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Event%20locations/"+i+"?api_key=key1gxH6SEzy1SOJS"
            }
          
            print(url)
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
              guard let data = data, error == nil else{
                  print("error")
                  return
              }
              
              
              //hava data
              
            var compagnie: NameCompagnie?
            var speakeur: SpeakingAt?
            do{
                if (which == "compagnie"){
                    compagnie = try JSONDecoder().decode(NameCompagnie.self, from: data)
                    self.resultAttendee.records[test].fields.company?[count] = compagnie?.fields.company ?? ""
                    
                }
                if (which == "speakeur"){
                    speakeur = try JSONDecoder().decode(SpeakingAt.self, from: data)
                    self.resultAttendee.records[test].fields.speaking?[count] = speakeur?.fields.activity ?? ""
                    self.resultAttendee.records[test].fields.speaking?[count] += "\n"
                    self.resultAttendee.records[test].fields.speaking?[count] += String(speakeur?.fields.start.dropLast(5) ?? "" ).replacingOccurrences(of: "T", with: " ")
                    self.resultAttendee.records[test].fields.speaking?[count] += "\n"
                    self.resultAttendee.records[test].fields.speaking?[count] += String(speakeur?.fields.start.dropLast(5) ?? "" ).replacingOccurrences(of: "T", with: " ")
                    self.resultAttendee.records[test].fields.speaking?[count] += "\n"
                }
                
                count += 1
                if ((test == self.resultAttendee.records.count-1)){
                    self.resultAttendeeCount = self.resultAttendee.records.count
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
        return resultAttendeeCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendeeCell", for: indexPath) as! AttendeeTableViewCell

        cell.role?.text = "Role : " + (self.resultAttendee.records[indexPath.row].fields.role ?? "")
        cell.email?.text = "Email : " + (self.resultAttendee.records[indexPath.row].fields.email ?? "")
        
        var compagnie = "Company : "
        for i in self.resultAttendee.records[indexPath.row].fields.company ?? []{
            compagnie += i
            compagnie += " "
        }
        cell.compagnie?.text = compagnie
        cell.nom?.text = "Nom : " + (self.resultAttendee.records[indexPath.row].fields.name ?? "")
        cell.numero?.text = "Numero : " + (self.resultAttendee.records[indexPath.row].fields.phone ?? "")
        
        var speaking = "Parle a : "
        for i in self.resultAttendee.records[indexPath.row].fields.speaking ?? []{
            speaking += i
            speaking += " "
        }
        cell.speaking?.text = speaking

        return cell
    }
    
}
