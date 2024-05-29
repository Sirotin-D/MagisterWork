//
//  ApiKeyConstants.swift
//

import Foundation

enum KeyConstants {
  static func loadAPIKeys() async throws  {
    let request = NSBundleResourceRequest(tags: ["APIKeys"])
    try await request.beginAccessingResources()

    let url = Bundle.main.url(forResource: "APIKeys", withExtension: "json")!
    let data = try Data(contentsOf: url)
    APIKeys.storage = try JSONDecoder().decode([String: String].self, from: data)

    request.endAccessingResources()
  }

  enum APIKeys {
    static fileprivate(set) var storage = [String: String]()
    static var nutritionAPIKey: String { storage["NUTRITION_API_KEY"] ?? "" }
  }
}
