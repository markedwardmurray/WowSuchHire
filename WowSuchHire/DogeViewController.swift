//
//  ViewController.swift
//  WowSuchHire
//
//  Created by Mark Murray on 12/10/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import Parse

class DogeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputField: UITextField!
    
    var messages = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // setup for KIF tester - begin //
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        // setup for KIF tester - end ////
        
        // doge-ify - begin //
        self.tableView.backgroundColor = UIColor.clearColor()
        let dogeImage = UIImage(named: "Doge-Meme-Blank-13.jpg")
        self.tableView.backgroundView = UIImageView(image: dogeImage)
        self.tableView.backgroundView?.alpha = 0.125
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // doge-ify - end ////
        
        let query = PFQuery(className:"Message")
        query.findObjectsInBackgroundWithBlock { (response, error) -> Void in
            if error != nil {
                print(error)
            }
            
            if let response = response {
                self.messages = response
                self.tableView.reloadData()
            } else {
                print("PFQuery responded with nil")
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // estimates the height of each cell's label - thanks, ios 9
        
        let calcLabel = UILabel()
        calcLabel.numberOfLines = 0
        let message = self.messages[indexPath.row]
        if let content = message["content"] as? String {
            calcLabel.text = content
        }
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let size = calcLabel.sizeThatFits(CGSizeMake(screenSize.width, CGFloat(FLT_MAX)))
        
        let padding: CGFloat = 10
        return size.height + padding*2

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("dogeCell", forIndexPath: indexPath)
        
        // for doge-ification
        cell.backgroundColor = UIColor.clearColor()
        
        let message = messages[indexPath.row]
        if let content = message["content"] as? String {
            cell.textLabel?.text = content
        }
        
        return cell
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        if inputField.text?.characters.count == 0 {
            return
        }
        
        if let content = inputField.text {
            let message = PFObject(className: "Message")
            message["content"] = content
            message.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("Message saved with content: \(content)")
                self.messages.append(message)
                self.tableView.reloadData()
            }
            inputField.text = ""
        }
    }
}

