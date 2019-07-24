//
//  ConnectionUtil.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 21/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias Parameters = [String: Any]

class ConnectionUtil {
    
    //MARK: - Variables
    static let shared = ConnectionUtil()
    private var downloadSession = URLSession(configuration: .ephemeral)
    private var activeDownloads: [String: URLSessionTask] = [:]
    private var imageCache = NSCache<NSString, UIImage>()
    
    //MARK: - Life Cycle
    private init() {}
    
    //MARK: - Requests
    /// Make a request.
    ///
    /// - Parameters:
    ///   - url: The request's url.
    ///   - method: The HTTP method used on the request.
    ///   - parameters: The request's parameters.
    ///   - completion: A block object to be executed when the request ends.
    func request<T>(on url: URL?, method: HTTPMethod, parameters: Parameters?, completion: @escaping (_ result: Result<T,Error>) -> Void) where T: Codable {
        guard
            let url = url
            else {
                completion(.failure(NSError(domain: "URL isn't defined.",
                                            code: 100,
                                            userInfo: nil)))
                return
        }
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                completion(.failure(NSError(domain: "Problem encoding the request parameters.",
                                            code: 102,
                                            userInfo: nil)))
            }
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "Problem parsing the response data.",
                                            code: 101,
                                            userInfo: nil)))
            }
        }
        task.resume()
    }
    
    /// Download an image.
    ///
    /// - Parameters:
    ///   - url: The image's url.
    ///   - completion: A block object to be executed when the download ends.
    func downloadImage(on url: URL?, completion: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        guard
            let url = url
            else {
                completion(.failure(NSError(domain: "URL isn't defined.",
                                            code: 100,
                                            userInfo: nil)))
                return
        }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
        } else {
            let task = downloadSession.dataTask(with: url) { (data, _, error) in
                self.activeDownloads[url.absoluteString] = nil
                if let error = error {
                    completion(.failure(error))
                } else if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(.success(image))
                } else {
                    completion(.failure(NSError(domain: "Problem parsing the response data.",
                                                code: 103,
                                                userInfo: nil)))
                }
            }
            task.resume()
            activeDownloads[url.absoluteString] = task
        }
    }
}
