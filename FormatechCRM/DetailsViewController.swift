//
//  DetailsViewController.swift
//  FormatechCRM
//
//  Created by Nicholas Credli on 3/15/16.
//  Copyright © 2016 Novium Collective SARL. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    var customer: Customer!
    var moneyFormatter: NSNumberFormatter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ID: \(customer.id)"
        self.nameLabel.text = customer.name
        self.moneyFormatter = NSNumberFormatter()
        self.moneyFormatter?.numberStyle = .CurrencyStyle
        self.moneyFormatter?.currencySymbol = "USD "
        self.balanceLabel.text = self.moneyFormatter?.stringFromNumber(NSNumber(double: customer.balance))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
