//
//  HomeTableViewController.swift
//  Projetiosfini
//
//  Created by user187202 on 3/24/21.
//

import UIKit

struct ResponseDataEvent: Codable {
    var records: [Record]
}

struct Record: Codable {
    let id: String
    var fields: Fieldse
    let createdTime: String
}

struct Fieldse: Codable {
    var topicTheme, speakerS: [String]?
    let notes: String?
    let end, activity, type, start: String
    var location: [String]?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case topicTheme = "Topic / theme"
        case speakerS = "Speaker(s)"
        case notes = "Notes"
        case end = "End"
        case activity = "Activity"
        case type = "Type"
        case start = "Start"
        case location = "Location"
    }
}
struct FieldsDataNameEvent: Codable{
    var Name:String?
}


struct NameDataEvent: Codable {
    
    var id: String?
    var fields: FieldsDataNameEvent?
}


struct FieldsDataTopicEvent: Codable{
    var topicTheme:String?
    enum CodingKeys: String, CodingKey {
        case topicTheme = "Topic / theme"
    }
}

struct TopicDataEvent: Codable {
    
    var id: String?
    var fields: FieldsDataTopicEvent?
}

struct PhotoSURL: Codable {
    var id: String
    var url: String
    var filename: String
    var size: Int
    var type: String
}

struct FieldsDataLocationEvent: Codable{
    var location:String?
    var photoS: [PhotoSURL]
    enum CodingKeys: String, CodingKey {
        case location = "Space name"
        case photoS = "Photo(s)"
    }
}

struct NameLocationEvent: Codable {
    
    var id: String?
    var fields: FieldsDataLocationEvent?
}

var resultEvent: ResponseDataEvent!
var resultEventCount: Int = 0
var myIndex : Int = 0

class HomeTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        
        let url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule?api_key=key1gxH6SEzy1SOJS&view=Full%20schedule"
        getData(from: url)
        while(resultEventCount == 0){
            
        }
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func getData(from url: String){
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else{
                print("error")
                return
            }
            
            
            //hava data
            
            do{
                resultEvent = try JSONDecoder().decode(ResponseDataEvent.self, from: data)
                resultEventCount = resultEvent.records.count
                for index in (0...resultEvent.records.count-1) {
                    self.getDataName(from: resultEvent.records[index].fields.topicTheme ?? [], from: index, from:"topic")
                    self.getDataName(from: resultEvent.records[index].fields.location ?? [], from: index, from:"location")
                    self.getDataName(from: resultEvent.records[index].fields.speakerS ?? [], from: index, from:"speakeur")
                }
                
            }
            catch{
                print("fail \(error.localizedDescription)")
            }
            
            
        })
        
        task.resume()
        
        
    }
    
    private func getDataName(from id: [String], from test : Int, from which: String){
            var count = 0
            var url = ""
            for i in id{
            if (which == "topic"){
                url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Topics%20%26%20themes/"+i+"?api_key=key1gxH6SEzy1SOJS"
            }
            if (which == "location"){
                url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Event%20locations/"+i+"?api_key=key1gxH6SEzy1SOJS"
            }
            if (which == "speakeur"){
                url = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees/"+i+"?api_key=key1gxH6SEzy1SOJS"
            }
          
            print(url)
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
              guard let data = data, error == nil else{
                  print("error")
                  return
              }
              
              
              //hava data
              
            var topic: TopicDataEvent?
            var location: NameLocationEvent?
            var speakeur: NameDataEvent?
            do{
                if (which == "topic"){
                    topic = try JSONDecoder().decode(TopicDataEvent.self, from: data)
                    resultEvent.records[test].fields.topicTheme?[count] = topic?.fields?.topicTheme ?? ""
                }
                if (which == "location"){
                    location = try JSONDecoder().decode(NameLocationEvent.self, from: data)
                    if (location?.fields?.photoS.count != 0){
                        resultEvent.records[test].fields.url = location?.fields?.photoS[0].url
                    }
                    resultEvent.records[test].fields.location?[count] = location?.fields?.location ?? ""
                }
                if (which == "speakeur"){
                    speakeur = try JSONDecoder().decode(NameDataEvent.self, from: data)
                    resultEvent.records[test].fields.speakerS?[count] = speakeur?.fields?.Name ?? ""
                }
                
                count += 1
                
                  
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
        return resultEventCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! HomeTableViewCell
        
        cell.Event.text = resultEvent.records[indexPath.row].fields.activity
        
        cell.Heure.text = String(resultEvent.records[indexPath.row].fields.start.dropLast(5)).replacingOccurrences(of: "T", with: " ")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
