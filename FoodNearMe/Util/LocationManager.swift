//
//  File.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 09/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationFetcher {
    func getCurrentLocation(success: @escaping LocationHandler, failure: @escaping LocationErrorHandler)
}

enum LocationError: Error {
    case servicesDisabled
    case notFound
    case otherError
}

typealias LocationHandler = (CLLocation) -> Void
typealias LocationErrorHandler = (LocationError) -> Void

class LocationManager: NSObject {

    var successHandler: LocationHandler?
    var failureHandler: LocationErrorHandler?

    let locationManager: CLLocationManager

    init(nativeManager: CLLocationManager) {
        locationManager = nativeManager
    }

    static let sharedInstance = LocationManager(nativeManager: CLLocationManager())

    private func startFetchingLocation() {
        let status  = CLLocationManager.authorizationStatus()

        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }

        if status == .denied || status == .restricted {
            sendError(.servicesDisabled)
            return
        }

        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    private func sendLocation(_ location: CLLocation) {
        successHandler?(location)
        clearHandlers()
    }

    private func sendError(_ error: LocationError) {
        failureHandler?(error)
        clearHandlers()
    }

    private func clearHandlers() {
        successHandler = nil
        failureHandler = nil
    }
}

extension LocationManager: LocationFetcher {

    func getCurrentLocation(success: @escaping LocationHandler, failure: @escaping LocationErrorHandler) {
        successHandler = success
        failureHandler = failure
        startFetchingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            sendLocation(location)
        } else {
            sendError(.notFound)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        sendError(.otherError)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        startFetchingLocation()
    }
}
