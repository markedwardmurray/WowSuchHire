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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("dogeCell", forIndexPath: indexPath)
        
        return cell
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        if let content = inputField.text {
            let message = PFObject(className: "message")
            message["content"] = content
            message.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print("Message has been saved.")
            }
            inputField.text = ""
            tableView.reloadData()
        }
    }
}

