//
//  NetworkManager.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 14.02.2023.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    
    func loginRequest(completion: @escaping (Result<Oauth,Error>) -> Void){
        let headers = [
            "Authorization": "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz",
            "Content-Type": "application/json"
        ]
        let parameters = [
            "username": "365",
            "password": "1"
        ] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.baubuddy.de/index.php/login")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                do{
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                    guard let oauth = dictionary["oauth"] as? Dictionary<String, Any> else {return}
                    let accessToken = oauth["access_token"]
                    let refreshToken = oauth["refresh_token"]
                    let userOauth = Oauth(access_token: accessToken as! String, refresh_token: refreshToken as! String )
                    completion(.success(userOauth))
                } catch {
                    completion(.failure(error))
                }
            }
        })
        dataTask.resume()
    }
    
    func fetchTasks(with userOauth: Oauth, completion: @escaping ([Task]) -> Void) {
        let userAccessTokenString : String = "\(userOauth.access_token ?? "")"
        let userRefreshTokenString : String = "\(userOauth.refresh_token ?? "")"
        let baubuddyURL = "https://api.baubuddy.de/dev/index.php/v1/tasks/select?access_token=\(userAccessTokenString)&expires_in=1200&token_type=Bearer&scope=&refresh_token=\(userRefreshTokenString)&"
        var request = URLRequest(url: URL(string: baubuddyURL)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            do {
                let tasks = try JSONDecoder().decode([Task].self, from: data!)
                completion(tasks)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
