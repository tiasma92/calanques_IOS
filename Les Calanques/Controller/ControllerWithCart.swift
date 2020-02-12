//
//  ControllerWithCart.swift
//  Les Calanques
//
//  Created by Mattias on 10/02/2020.
//  Copyright © 2020 Mattias. All rights reserved.
//

import UIKit
import MapKit

class ControllerWithCart: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var userPosition: CLLocation?
    var calanques: [Calanque] = CalanqueCollection().all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
        MapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        addAnnotation()
        NotificationCenter.default.addObserver(self, selector: #selector(notifDetail), name: Notification.Name("detail"), object: nil)
        if calanques.count > 0 {
            let premiere = calanques[0].coordonnee
            setupMap(coordonnees: premiere)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            if let myPosition = locations.last {
                userPosition = myPosition
            }
        }
    }
    
    func setupMap(coordonnees: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.35, longitudeDelta: 0.35)
        let region = MKCoordinateRegion(center: coordonnees, span: span)
        MapView.setRegion(region, animated: true)
    }
    
    @objc func notifDetail(notification: Notification){
        if let calanque = notification.object as? Calanque {
            print("j'ai une calanque")
            toDetail(calanque: calanque)
        }
    }
    
    func toDetail(calanque: Calanque) {
        performSegue(withIdentifier: "detail", sender: calanque)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let controller = segue.destination as? DetailController {
                controller.calanqueGet = sender as? Calanque
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "reuseID"
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        if let anno = annotation as? MyAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier:  reuseIdentifier)
            if annotationView == nil {
//                annotationView = MyAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                annotationView = MyAnnotationView(controller: self, annotation: anno, reuseIdentifier: reuseIdentifier)
                
//                annotationView = MKAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
//                annotationView?.image = UIImage(named: "placeholder")
//                annotationView?.canShowCallout = true
                return annotationView
            } else {
                return annotationView
            }
        }
        return nil
    }
    
    func addAnnotation() {
        for calanque in calanques{
            
            
            //            Basic annotation
            //            let annotation = MKPointAnnotation()
            //            annotation.coordinate = calanque.coordonnee
            //            annotation.title = calanque.nom
            //            MapView.addAnnotation(annotation)
            
            //            Annotation Custom
            let annotation =  MyAnnotation(calanque)
            MapView.addAnnotation(annotation)
        }
    }
    @IBAction func SegmentedChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: MapView.mapType = MKMapType.standard
        case 1: MapView.mapType = .satellite
        case 2: MapView.mapType = .hybrid
        default:
            break
        }
    }
    
    @IBAction func GetPosition(_ sender: Any) {
        if userPosition != nil {
            setupMap(coordonnees: userPosition!.coordinate)
        }
    }
    
}
