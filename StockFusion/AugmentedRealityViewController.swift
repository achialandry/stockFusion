//
//  AugmentedRealityViewController.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-30.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import MapKit
import SceneKit
import ARCL
import CoreLocation




@available(iOS 11.0, *)
class AugmentedRealityViewController: UIViewController {

//    @IBOutlet weak var mapView: MKMapView!
    
    var sceneLocationView = SceneLocationView()
    
    let mapView = MKMapView()
    var userAnnotation: MKPointAnnotation?
    var locationEstimateAnnotation: MKPointAnnotation?
    
    var updateUserLocationTimer: Timer?
    
    ///Whether to show a map view
    ///The initial value is respected
    var showMapView: Bool = true
    
    var centerMapOnUserLocation: Bool = true
    
    ///Whether to display some debugging data
    ///This currently displays the coordinate of the best location estimate
    ///The initial value is respected
    var displayDebugging = false
    
    var infoLabel = UILabel()
    
    var updateInfoLabelTimer: Timer?
    
    var adjustNorthByTappingSidesOfScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "HD - Augmented Reality"
        
//        sceneLocationView.run()
//        let coordinate = CLLocationCoordinate2D(latitude: 49.213426, longitude: -122.943179)
//        let location = CLLocation(coordinate: coordinate, altitude: 300)
//        let image = UIImage(named: "pin")!
//
//        let annotationNode = LocationAnnotationNode(location: location, image: image)
//        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
//        view.addSubview(sceneLocationView)
        
        infoLabel.font = UIFont.systemFont(ofSize: 10)
        infoLabel.textAlignment = .left
        infoLabel.textColor = UIColor.white
        infoLabel.numberOfLines = 0
        sceneLocationView.addSubview(infoLabel)
        
        updateInfoLabelTimer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(self.updateInfoLabel),
            userInfo: nil,
            repeats: true)
        
        // Set to true to display an arrow which points north.
        //Checkout the comments in the property description and on the readme on this.
        //        sceneLocationView.orientToTrueNorth = false
        //        sceneLocationView.locationEstimateMethod = .coreLocationDataOnly
        sceneLocationView.showAxesNode = true
        sceneLocationView.locationDelegate = self
        
        if displayDebugging {
            sceneLocationView.showFeaturePoints = true
        }
        
        buildStockMarketData().forEach { sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: $0) }
        
        view.addSubview(sceneLocationView)
        
        if showMapView {
            mapView.delegate = self as MKMapViewDelegate
            mapView.showsUserLocation = true
            mapView.alpha = 0.8
            view.addSubview(mapView)
            
            updateUserLocationTimer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(self.updateUserLocation),
                userInfo: nil,
                repeats: true)
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        sceneLocationView.frame = view.bounds
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("run")
        sceneLocationView.run()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("pause")
        // Pause the view's session
        sceneLocationView.pause()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
        
        infoLabel.frame = CGRect(x: 6, y: 0, width: self.view.frame.size.width - 12, height: 14 * 4)
        
        if showMapView {
            infoLabel.frame.origin.y = (self.view.frame.size.height / 2) - infoLabel.frame.size.height
        } else {
            infoLabel.frame.origin.y = self.view.frame.size.height - infoLabel.frame.size.height
        }
        
        mapView.frame = CGRect(
            x: 0,
            y: self.view.frame.size.height / 2,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height / 2)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @objc func updateUserLocation() {
        guard let currentLocation = sceneLocationView.currentLocation() else {
            return
        }
        
        DispatchQueue.main.async {
            if let bestEstimate = self.sceneLocationView.bestLocationEstimate(),
                let position = self.sceneLocationView.currentScenePosition() {
                print("")
                print("Fetch current location")
                print("best location estimate, position: \(bestEstimate.position), location: \(bestEstimate.location.coordinate), accuracy: \(bestEstimate.location.horizontalAccuracy), date: \(bestEstimate.location.timestamp)")
                print("current position: \(position)")
                
                let translation = bestEstimate.translatedLocation(to: position)
                
                print("translation: \(translation)")
                print("translated location: \(currentLocation)")
                print("")
            }
            
            if self.userAnnotation == nil {
                self.userAnnotation = MKPointAnnotation()
                self.mapView.addAnnotation(self.userAnnotation!)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                self.userAnnotation?.coordinate = currentLocation.coordinate
            }, completion: nil)
            
            if self.centerMapOnUserLocation {
                UIView.animate(withDuration: 0.45, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                    self.mapView.setCenter(self.userAnnotation!.coordinate, animated: false)
                }, completion: { _ in
                    self.mapView.region.span = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
                })
            }
            
            if self.displayDebugging {
                let bestLocationEstimate = self.sceneLocationView.bestLocationEstimate()
                
                if bestLocationEstimate != nil {
                    if self.locationEstimateAnnotation == nil {
                        self.locationEstimateAnnotation = MKPointAnnotation()
                        self.mapView.addAnnotation(self.locationEstimateAnnotation!)
                    }
                    
                    self.locationEstimateAnnotation!.coordinate = bestLocationEstimate!.location.coordinate
                } else {
                    if self.locationEstimateAnnotation != nil {
                        self.mapView.removeAnnotation(self.locationEstimateAnnotation!)
                        self.locationEstimateAnnotation = nil
                    }
                }
            }
        }
    }
    
    @objc func updateInfoLabel() {
        if let position = sceneLocationView.currentScenePosition() {
            infoLabel.text = "x: \(String(format: "%.2f", position.x)), y: \(String(format: "%.2f", position.y)), z: \(String(format: "%.2f", position.z))\n"
        }
        
        if let eulerAngles = sceneLocationView.currentEulerAngles() {
            infoLabel.text!.append("Euler x: \(String(format: "%.2f", eulerAngles.x)), y: \(String(format: "%.2f", eulerAngles.y)), z: \(String(format: "%.2f", eulerAngles.z))\n")
        }
        
        if let heading = sceneLocationView.locationManager.heading,
            let accuracy = sceneLocationView.locationManager.headingAccuracy {
            infoLabel.text!.append("Heading: \(heading)º, accuracy: \(Int(round(accuracy)))º\n")
        }
        
        let date = Date()
        let comp = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: date)
        
        if let hour = comp.hour, let minute = comp.minute, let second = comp.second, let nanosecond = comp.nanosecond {
            infoLabel.text!.append("\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", second)):\(String(format: "%03d", nanosecond / 1000000))")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard
            let touch = touches.first,
            let touchView = touch.view
            else {
                return
        }
        
        if mapView == touchView || mapView.recursiveSubviews().contains(touchView) {
            centerMapOnUserLocation = false
        } else {
            let location = touch.location(in: self.view)
            
            if location.x <= 40 && adjustNorthByTappingSidesOfScreen {
                print("left side of the screen")
                sceneLocationView.moveSceneHeadingAntiClockwise()
            } else if location.x >= view.frame.size.width - 40 && adjustNorthByTappingSidesOfScreen {
                print("right side of the screen")
                sceneLocationView.moveSceneHeadingClockwise()
            } else {
                let image = UIImage(named: "pin")!
                let annotationNode = LocationAnnotationNode(location: nil, image: image)
                annotationNode.scaleRelativeToDistance = true
                sceneLocationView.addLocationNodeForCurrentPosition(locationNode: annotationNode)
            }
        }
    }
    

}

// MARK: - MKMapViewDelegate
@available(iOS 11.0, *)
extension AugmentedRealityViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        guard let pointAnnotation = annotation as? MKPointAnnotation else {
            return nil
        }
        
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
        marker.displayPriority = .required
        
        if pointAnnotation == self.userAnnotation {
            marker.glyphImage = UIImage(named: "user")
        } else {
            marker.markerTintColor = UIColor(hue: 0.267, saturation: 0.67, brightness: 0.77, alpha: 1.0)
            marker.glyphImage = UIImage(named: "compass")
        }
        
        return marker
    }
}

// MARK: - SceneLocationViewDelegate
@available(iOS 11.0, *)
extension AugmentedRealityViewController: SceneLocationViewDelegate {
    func sceneLocationViewDidAddSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
        print("add scene location estimate, position: \(position), location: \(location.coordinate), accuracy: \(location.horizontalAccuracy), date: \(location.timestamp)")
    }
    
    func sceneLocationViewDidRemoveSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
        print("remove scene location estimate, position: \(position), location: \(location.coordinate), accuracy: \(location.horizontalAccuracy), date: \(location.timestamp)")
    }
    
    func sceneLocationViewDidConfirmLocationOfNode(sceneLocationView: SceneLocationView, node: LocationNode) {
    }
    
    func sceneLocationViewDidSetupSceneNode(sceneLocationView: SceneLocationView, sceneNode: SCNNode) {
        
    }
    
    func sceneLocationViewDidUpdateLocationAndScaleOfLocationNode(sceneLocationView: SceneLocationView, locationNode: LocationNode) {
        
    }
}

// MARK: - Data Helpers
@available(iOS 11.0, *)
private extension AugmentedRealityViewController {
    func buildStockMarketData() -> [LocationAnnotationNode] {
        var nodes: [LocationAnnotationNode] = []
        
        // added a few points of interest.
        let vanStockExchangeMarket = buildNode(latitude: 49.285679, longitude: -123.115909, altitude: 225, imageName: "pin")
        nodes.append(vanStockExchangeMarket)
        
        let tdCanadaTrust = buildNode(latitude: 49.282477, longitude: -123.118136, altitude: 14.3, imageName: "pin")
        nodes.append(tdCanadaTrust)
        
        let salmanPartners = buildNode(latitude: 49.286888, longitude: -123.119633, altitude: 236, imageName: "pin")
        nodes.append(salmanPartners)
        
        let globalSecurityCorp = buildNode(latitude: 49.288288, longitude: -123.115317, altitude: 236, imageName: "pin")
        nodes.append(globalSecurityCorp)
        
        return nodes
    }
    
    func buildNode(latitude: CLLocationDegrees, longitude: CLLocationDegrees, altitude: CLLocationDistance, imageName: String) -> LocationAnnotationNode {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let location = CLLocation(coordinate: coordinate, altitude: altitude)
        let image = UIImage(named: imageName)!
        return LocationAnnotationNode(location: location, image: image)
    }
}

extension DispatchQueue {
    func asyncAfter(timeInterval: TimeInterval, execute: @escaping () -> Void) {
        self.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(timeInterval * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: execute)
    }
}

extension UIView {
    func recursiveSubviews() -> [UIView] {
        var recursiveSubviews = self.subviews
        
        for subview in subviews {
            recursiveSubviews.append(contentsOf: subview.recursiveSubviews())
        }
        
        return recursiveSubviews
    }
}


