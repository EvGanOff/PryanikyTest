//
//  Errors.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/25/22.
//

import Foundation

enum Errors: Error {
    case unableToComplete
    case invaliedRespons
    case invaliedData
    case decoderError
}

extension Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unableToComplete:
            return "Не удается обработать ваш запрос. Пожалуйста, проверьте ваше интернет-соединение"
        case .invaliedRespons:
            return "Неверный ответ от сервера. Пожалуйста, попробуйте еще раз"
        case .invaliedData:
            return "Данные, полученные с сервера, недействительны. Пожалуйста, попробуйте еще раз"
        case .decoderError:
           return "Не смог декодировать data"
        }
    }
}
