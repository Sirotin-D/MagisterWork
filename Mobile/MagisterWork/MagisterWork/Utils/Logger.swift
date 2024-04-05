//
//  Logger.swift
//

import Foundation

class Logger {
    static let shared = Logger()
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    }
    
    func d(_ tag: String, _ content: String) {
        log(tag, content, logLevel: .Debug)
    }
    
    func i(_ tag: String, _ content: String) {
        log(tag, content, logLevel: .Info)
    }
    
    func e(_ tag: String, _ content: String) {
        log(tag, content, logLevel: .Error)
    }
    
    private func log(_ tag: String, _ content: String, logLevel: LogLevel) {
        print("[\(dateFormatter.string(from: Date()))] [\(logLevel.getLevelColor())] [\(logLevel.rawValue)] [\(tag)] \(content)")
    }
    
    private enum LogLevel: String {
        case Debug
        case Info
        case Error
        
        func getLevelColor() -> String {
            var levelColor: String
            switch self {
            case .Debug:
                levelColor = "🟤"
            case .Info:
                levelColor = "🟡"
            case .Error:
                levelColor = "🔴"
            }
            return levelColor
        }
    }
}
