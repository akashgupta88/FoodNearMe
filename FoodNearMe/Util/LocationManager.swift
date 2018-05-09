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
    func getCurrentLocation(handler: @escaping LocationHandler)
}

enum LocationResult {
    case location(CLLocation)
    case error(LocationError)
}

enum LocationError: Error {
    case servicesDisabled
    case notFound
    case otherError

    func description() -> String {
        switch self {
        case .notFound:
            return "We were not able to determine your location."
        case .servicesDisabled:
            return "Please turn on location services for this app."
        case .otherError:
            return "There was a problem getting your location."
        }
    }
}

typealias LocationHandler = (LocationResult) -> Void

class LocationManager: NSObject {

    var handler: LocationHandler?

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
        handler?(.location(location))
        clearHandlers()
    }

    private func sendError(_ error: LocationError) {
        handler?(.error(error))
        clearHandlers()
    }

    private func clearHandlers() {
        handler = nil
    }
}

extension LocationManager: LocationFetcher {

    func getCurrentLocation(handler: @escaping LocationHandler) {
        self.handler = handler
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
