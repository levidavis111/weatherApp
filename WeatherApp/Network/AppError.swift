//
//  AppError.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/9/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
