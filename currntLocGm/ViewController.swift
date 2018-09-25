//
//  ViewController.swift
//  currntLocGm
//
//  Created by venkatarao on 23/05/18.
//  Copyright © 2018 Exaact. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController,GMSMapViewDelegate {
    let locationManager = CLLocationManager()
    let infoMarker = GMSMarker()
    var mapView : GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //(17.361564, 78.474665)
        let camera = GMSCameraPosition.camera(withLatitude: 17.361564,
                                              longitude:78.474665,
                                              zoom:14)
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        self.view = mapView
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        }
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String,
                 name: String, location: CLLocationCoordinate2D) {
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
        print("You tapped \(name): \(placeID), \(location.latitude)/\(location.longitude)")
    }

    
}

extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17)
        self.mapView.animate(to: camera)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        debugPrint(location?.coordinate.latitude as Any)
        debugPrint(location?.coordinate.longitude as Any)
        marker.title = "Current Location"
        marker.snippet = "Hyd"
        marker.map = mapView
        self.locationManager.stopUpdatingLocation()
    }
}


