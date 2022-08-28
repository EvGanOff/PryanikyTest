//
//  URLConfiguration.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/26/22.
//

import UIKit

final class URLConfiration {
    func getURL() -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pryaniky.com"
        urlComponents.path = "/static/json/sample.json"

        return urlComponents.url?.absoluteString ?? "something was wrong"
    }
}
