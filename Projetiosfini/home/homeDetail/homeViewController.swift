//
//  homeViewController.swift
//  Projetiosfini
//
//  Created by user187202 on 3/31/21.
//

import UIKit


class homeViewController: UIViewController {

    
    @IBOutlet weak var debut: UILabel?
    @IBOutlet weak var fin: UILabel?
    @IBOutlet weak var note: UILabel?
    @IBOutlet weak var speakeur: UILabel?
    @IBOutlet weak var location: UILabel?
    @IBOutlet weak var activity: UILabel?
    @IBOutlet weak var image: UIImageView?
    @IBOutlet weak var theme: UILabel?
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //detail.text = datasEvent[myIndex].detail
        location?.text = "Localisation : "
        for i in resultEvent.records[myIndex].fields.location ?? [] {
            location?.text! += i
        }
        note?.text = "Note : " + (resultEvent.records[myIndex].fields.notes ?? "")
        
        speakeur?.text = "Orateur : "
        for i in resultEvent.records[myIndex].fields.speakerS ?? [] {
            speakeur?.text! += i
        }
        
        theme?.text = "Theme : "
        for i in resultEvent.records[myIndex].fields.topicTheme ?? [] {
            theme?.text! += i
        }
        activity?.text = "Activité : " + resultEvent.records[myIndex].fields.activity
        fin?.text = String(resultEvent.records[myIndex].fields.end.dropLast(5)).replacingOccurrences(of: "T", with: " ")
        debut?.text = String(resultEvent.records[myIndex].fields.start.dropLast(5)).replacingOccurrences(of: "T", with: " ")
        
        print("Begin of code")
        let url = URL(string: resultEvent.records[myIndex].fields.url ?? "")!
        downloadImage(from: url)
        print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.image?.image = UIImage(data: data)
            }
        }
    }
    

}
