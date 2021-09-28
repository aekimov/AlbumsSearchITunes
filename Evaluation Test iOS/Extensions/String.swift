//
//  String.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 26.09.2021.
//

import UIKit

extension String {
    var encodeUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl: String {
        return self.removingPercentEncoding!
    }
    
    //MARK: - DateFormatter func
    func transformDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy"
            dateFormatter.locale = tempLocale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return ""
    }
}
