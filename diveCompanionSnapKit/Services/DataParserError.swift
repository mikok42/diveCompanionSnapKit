//
//  DataParserError.swift
//  diverCompanion
//
//  Created by Mikołaj Linczewski on 11/04/2021.
//
import Foundation

enum DataParserError: String, Error {
    case wrongUrl = "wrong url"
    case fourOThree = "error 403"
    case invalidName = "provided name cant be converted into a string"
    case fileDoesNotExist = "file does not exist"
    case unableToDecode = "the file cannot be decoded"
    case cantFindEmail = "cos"
    case cantFindPassword = "cos2"
//    var message: String {
//        switch self {
//        case .wrongUrl:
//            return "wrong url"
//        case .fourOThree:
//            return "error 403"
//        case .invalidName:
//            return "provided name cant be converted into a string"
//        case .fileDoesNotExist:
//            return "file does not exist"
//        case .unableToDecode:
//            return "the file cannot be decoded"
//        }
//    }
}
