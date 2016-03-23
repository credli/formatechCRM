//
//  CustomerAnnotation.swift
//  FormatechCRM
//
//  Created by Nicholas Credli on 3/23/16.
//  Copyright © 2016 Novium Collective SARL. All rights reserved.
//

import UIKit
import MapKit

class CustomerAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(location: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = location
        self.title = title
        self.subtitle = subtitle
    }
    
    func annotationView() -> MKAnnotationView {
        let view = MKAnnotationView(annotation: self, reuseIdentifier: "CustomerAnnotation")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.enabled = true
        view.canShowCallout = true
        view.image = UIImage(named: "location-pin")
        view.calloutOffset = CGPointMake(0, -32)
        return view
    }
}
