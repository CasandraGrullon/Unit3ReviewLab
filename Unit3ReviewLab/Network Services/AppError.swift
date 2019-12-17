//
//  AppError.swift
//  Unit3ReviewLab
//
//  Created by casandra grullon on 12/16/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

enum AppError: Error, CustomStringConvertible {
  case badURL(String) // associated value
  case noResponse
  case networkClientError(Error) // no internet connection
  case noData
  case decodingError(Error)
  case encodingError(Error)
  case badStatusCode(Int) // 404, 500
  case badMimeType(String) // image/jpg
    
    //now have the option to add descriptions to our errors
    var description: String {
        return "AppError \(self)"
    }
}
