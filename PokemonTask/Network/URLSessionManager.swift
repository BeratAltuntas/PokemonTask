//
//  URLSessionManager.swift
//  PokemonTask
//
//  Created by BERAT ALTUNTAŞ on 1.08.2022.
//

import Foundation
import UIKit.UIImage

struct ApiError: Error {
    let desc: String?
}


final class URLSessionManager {
    static let shared = URLSessionManager()
    typealias Completion<T> = (Result<T, ApiError>)-> Void where T: Decodable
    typealias CompletionImage = (_ success: Bool,_ result: UIImage)-> Void
    
    func FetchData<T: Decodable>(endPoint: String, type: T?.Type, completion: @escaping Completion<T> ) {
        guard let url = URL(string: endPoint) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.init(desc: "httpResponse Error")))
                return
            }
            do {
                if let data = data, let tSummary = try JSONDecoder().decode(type, from: data) {
                    completion(.success(tSummary))
                }
            }
            catch{
                print("JSON decode failed: \(error)")
            }
        })
        task.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping CompletionImage) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    completion(true,image)
                }
            }
        }
    }
}

