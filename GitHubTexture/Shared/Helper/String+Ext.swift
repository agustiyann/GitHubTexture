//
//  String+Ext.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 13/03/22.
//

import Foundation

extension String {
    mutating func dateFormater(_ format: String) -> String {
        var res = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format

        if let date = dateFormatterGet.date(from: self) {
            res = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return res
    }
}
