//
//  MyAnnotationView.swift
//  Les Calanques
//
//  Created by Mattias on 11/02/2020.
//  Copyright © 2020 Mattias. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotationView: MKAnnotationView {
    
    var controller: ControllerWithCart?
    
    init(controller: ControllerWithCart, annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.controller = controller
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupAnnotation()
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupAnnotation()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAnnotation()
    }
    func setupAnnotation() {
        image = UIImage(named: "placeholder")
        canShowCallout = true
        
        leftCalloutAccessoryView = setupLeft()
        rightCalloutAccessoryView = setupRight()
        detailCalloutAccessoryView = setupCenter()
    }
    
    func setupLeft() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "distance"), for: .normal)
        button.addTarget(self, action: #selector(gps), for: .touchUpInside)
        return button
    }
    
    func setupRight() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "detail"), for: .normal)
        button.addTarget(self, action: #selector(detail), for: .touchUpInside)
        return button
    }
    
    func setupCenter() -> UIView? {
        guard let anno = annotation as? MyAnnotation else { return nil}
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 125).isActive = true
        view.heightAnchor.constraint(equalToConstant: 125).isActive = true
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = anno.calanque.image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        return view
    }
    
    @objc func detail() {
        guard let anno = annotation as? MyAnnotation else { return }
//        controller?.toDetail(calanque: anno.calanque)
        NotificationCenter.default.post(name: Notification.Name("detail"), object: anno.calanque)
    }
    
    @objc func gps() {
        guard let anno = annotation as? MyAnnotation else { return }
        let placeMark = MKPlacemark(coordinate: anno.coordinate )
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        let map = MKMapItem(placemark: placeMark)
        map.openInMaps(launchOptions: options)
    }
}
