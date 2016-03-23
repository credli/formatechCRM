//
//  DetailsViewController.swift
//  FormatechCRM
//
//  Created by Nicholas Credli on 3/15/16.
//  Copyright © 2016 Novium Collective SARL. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var map: MKMapView!
    var customer: Customer!
    var moneyFormatter: NSNumberFormatter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav title
        self.navigationItem.title = "ID: \(customer.id)"
        
        // Name label
        self.nameLabel.text = customer.name
        
        // Amount
        self.moneyFormatter = NSNumberFormatter()
        self.moneyFormatter?.numberStyle = .CurrencyStyle
        self.moneyFormatter?.currencySymbol = "USD "
        self.balanceLabel.text = self.moneyFormatter?.stringFromNumber(NSNumber(double: customer.balance))
        
        // Map
        let customerCoordinate = CLLocationCoordinate2D(latitude: self.customer.latitude, longitude: self.customer.longitude)
        let customerRegion = MKCoordinateRegion(center: customerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.020, longitudeDelta: 0.020))
        self.map.setRegion(customerRegion, animated: true)
        self.map.userInteractionEnabled = true
        self.map.delegate = self // IMPORTANT: if we don't set this then we won't receive any delegate calls from the map
        
        // Add the annotation, which contains both the pin and callout
        let customerAnnotation = CustomerAnnotation(location: customerRegion.center, title: customer.name, subtitle: "A test subtitle")
        self.map.addAnnotation(customerAnnotation)
        
        // Show the callout by default
        self.map.selectAnnotation(customerAnnotation, animated: true)
        
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

extension DetailsViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // do not drop pin on the current user location, instead use MKMapView's own logic for this
        if annotation is MKUserLocation {
            return nil
        }
        
        if annotation.isKindOfClass(CustomerAnnotation) {
            let customerAnnotation = annotation as! CustomerAnnotation
            mapView.translatesAutoresizingMaskIntoConstraints = false
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomerAnnotation")
            
            if annotationView == nil {
                annotationView = customerAnnotation.annotationView()
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        } else {
            return nil
        }
    }
}