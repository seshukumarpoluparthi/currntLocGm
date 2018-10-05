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
    @IBOutlet weak var lbl_Address1: UILabel!
    @IBOutlet weak var lbl_Address2: UILabel!
    
    let locationManager = CLLocationManager()
    let infoMarker = GMSMarker()
   // var mapView : GMSMapView!
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         converting array into string
        let lat = 17.361564
        let long = 78.474665
        array.append(lat)
        array.append(long)
        print(array)
        let sring = array.map({String($0)}).joined(separator: ",")
        print(sring)
 */
        //(17.361564, 78.474665)
 
   // let camera = GMSCameraPosition.camera(withLatitude: 17.361564,
                                         //     longitude:78.474665,
                                          //    zoom:14)
      //  self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
     //   mapView.delegate = self
     // self.view = mapView
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        infoMarker.isDraggable = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
       locationManager.startUpdatingLocation()
        }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let markerr = GMSMarker(position: coordinate)
        markerr.isDraggable = true
        markerr.position.latitude = coordinate.latitude
        markerr.position.longitude = coordinate.longitude
        markerr.map = mapView
    }
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Palo Alto"
        marker.snippet = "San Francisco"
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("did begin dragging")
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("did begin dragging")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("did end dragging")
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
       // self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.mapView.animate(to: camera)
      //  self.view = mapView
        mapView.delegate = self
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        debugPrint(location?.coordinate.latitude as Any)
        debugPrint(location?.coordinate.longitude as Any)
        marker.isDraggable = true
        marker.title = "Current Location"
        marker.snippet = "Hyd"
        marker.map = mapView
        let userLocation :CLLocation = locations[0] as CLLocation
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                self.lbl_Address1.text = placemark.subLocality!
                self.lbl_Address2.text = placemark.name!
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.name!)
                print(placemark.subAdministrativeArea!)
                print(placemark.country!)
                print(placemark.subLocality!)
            }
        self.locationManager.stopUpdatingLocation()
    }
}

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    
    
    
    
    
}
