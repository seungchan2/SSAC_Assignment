//
//  MapViewController.swift
//  Day13_Assignment-TrendMedia
//
//  Created by 김승찬 on 2021/10/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    var theaterList = TheaterList()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignMapKit()
        initNavigationBar()
        showAllAnnotation()
    }
    
    // MARK: - Functions
    
    private func assignMapKit() {
        locationManager.delegate = self
    }
    
    private func initNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(touchFilterButton))
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func touchFilterButton() {
        
        let actionsheetController = UIAlertController(title: "영화관을 선택해주세요", message: "보여질 영화관을 선택해주세요", preferredStyle: .actionSheet)

        let actionLotteCinema = UIAlertAction(title: "롯데시네마", style: .default) { action in
            self.filterAnnotation(keyword: "롯데시네마")
        }

        let actionMegaBox = UIAlertAction(title: "메가박스", style: .default) { action in
            self.filterAnnotation(keyword: "메가박스")
        }
        
        let actionCGV = UIAlertAction(title: "CGV", style: .default) { action in
            self.filterAnnotation(keyword: "CGV")
        }

        let actionShowAll = UIAlertAction(title: "전체보기", style: .default) { action in
            self.showAllAnnotation()
        }
        
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionsheetController.addAction(actionLotteCinema)
        actionsheetController.addAction(actionMegaBox)
        actionsheetController.addAction(actionCGV)
        actionsheetController.addAction(actionShowAll)
        actionsheetController.addAction(actionCancel)
        
        self.present(actionsheetController, animated: true, completion: nil)
        
    }
    
    func filterAnnotation(keyword : String) {
        for theater in theaterList.mapAnnotations {
            let location = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.subtitle = theater.type
            
            mapView.addAnnotation(annotation)
            
            let removes = mapView.annotations.filter { anno in
                if anno.subtitle == keyword { return false }
                else {
                    return true
                }
            }
            mapView.removeAnnotations(removes)
        
        }
    }
    
    func showAllAnnotation() {
        for theater in theaterList.mapAnnotations {
            let location = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.subtitle = theater.type
            
            mapView.addAnnotation(annotation)
        
        }
    }
    
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true) {
            print("alert")
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   
        if let coordinate = locations.last?.coordinate{
      
            let annotation = MKPointAnnotation()
            annotation.title = "현재 위치"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // 확대?범위
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            locationManager.stopUpdatingLocation()

            showTitle(coordi: coordinate)
            
        } else {
            print("Location Cannot Find")
        }
    }
    
    func showTitle(coordi: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        let findLocation = CLLocation(latitude: coordi.latitude, longitude: coordi.longitude)
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address : [CLPlacemark] = placemarks {
                let gu = address[0].locality
                let dong = address[0].thoroughfare
                
                self.title = "\(gu!) \(dong!)"
            }
            
        })
    }
    
    func goToSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url) { success in
                print("\(success)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let coordinate = CLLocationCoordinate2D(latitude: 37.566442275899, longitude: 126.97798742412988)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.title = "서울시청"
        annotation.coordinate = coordinate // 좌표를 넣음
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        
        print("didFailWithError")

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServiceAuthoriztaion()
    }
    
    func checkUserLocationServiceAuthoriztaion() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }

        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        } else {
            print("위치 서비스가 꺼져있음")
        }
        
    }

    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined: // 권한이 아예 설정 안되어있을 때
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
            showAlert(title: "위치 권한", message: "서울시청으로 가시죠", okTitle: "설정하기") {
                self.goToSetting()
            }
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            print("always")
        @unknown default:
            print("default")
        }
        
        if #available(iOS 14.0, *){
            let accurancyState = locationManager.accuracyAuthorization
            switch accurancyState {
            case .fullAccuracy:
                print("Full")
            case .reducedAccuracy:
                print("reduce")
            @unknown default:
                print("default")
            
            }
        }
    }
}
