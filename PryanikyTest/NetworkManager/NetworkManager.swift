//
//  NetworkManager.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/25/22.
//

import UIKit
import Alamofire

final class NetworkManager {
    let decoder = JSONDecoder()
    private let configuration = URLConfiration()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }

    func getData(completion: @escaping (Result<GlobalJsonData, Errors>) -> Void) {
        AF.request(configuration.getURL(), method: .get).response { response in
            guard let data = response.data else { return }

            do {
                let result = try self.decoder.decode(GlobalJsonData.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invaliedData))
            }
        }
    }
}

