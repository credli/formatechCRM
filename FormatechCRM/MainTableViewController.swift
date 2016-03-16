//
//  MainTableViewController.swift
//  FormatechCRM
//
//  Created by Nicholas Credli on 3/15/16.
//  Copyright © 2016 Novium Collective SARL. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var customers: [Customer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Customers"
        weak var weakSelf = self
        
        CRMService.sharedService.getCustomers() {
            customers, error in
            
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                weakSelf?.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            
            self.customers = customers
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.customers == nil ? 0 : self.customers!.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customerCellWithOnlyLabel", forIndexPath: indexPath) as! CustomerTableViewCell
        
        if let c = customers?[indexPath.row] {
            cell.nameLabel.text = c.name
        } else {
            cell.nameLabel.text = "Untitled Customer"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetailsSegue", sender: self.customers?[indexPath.row])
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailsSegue" {
            let detailsVC = segue.destinationViewController as! DetailsViewController
            detailsVC.customer = sender as! Customer
        }
    }

}
