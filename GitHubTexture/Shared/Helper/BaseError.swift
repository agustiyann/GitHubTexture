//
//  GUError.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import Foundation

enum BaseError: String, Error {
    case errorNetwork = "Found error from network. Please try again later."
    case invalidResponse = "Invalid data receiced from the server. Please try again later."
    case invalidData = "The data received from the server was invalid. Please try again later."
    case invalidDecoding = "Failed when decoding. Please try again later."
    case invalidConvertingData = "Failed converting to data. Please try again later."
}
