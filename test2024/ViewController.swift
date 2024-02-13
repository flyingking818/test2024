//
//  ViewController.swift
//  test2024
//
//  Created by Jeremy Wang on 1/17/24.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showAddress(_ sender: UIButton) {
        let geocoder = CLGeocoder()
            if let address = addressTextField.text {
                geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
                    if let placemark = placemarks?.first, let location = placemark.location {
                        let coordinate = location.coordinate
                        self?.mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
                    }
                }
            }
        
    }
    

}

