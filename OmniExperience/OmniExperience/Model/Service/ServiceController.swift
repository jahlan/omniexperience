//
//  ServiceController.swift
//  OmniExperience
//
//  Created by Yalan Bravo Olvera on 05/07/20.
//  Copyright © 2020 Yalan Bravo. All rights reserved.
//

import Foundation

enum APIError : Error {
    case InvalidURL
    case InvalidData
}

class ServiceController{
    
    let apiUrl : String = "https://www.reddit.com/r"
    let topPath : String = "/all/top.json"
    
    //Singleton
    static let shared = ServiceController()
    
    func getRedditPosts(path: String?, limit: Int, after: String?, completion: @escaping (Result<[Post], APIError>) -> (Void)){
        
        var parameters : [String : String] = [:]
        parameters["t"] = "all"
        parameters["limit"] = String(limit)
        parameters["after"] = after ?? ""

        var serviceUrl = "\(self.apiUrl)\(path ?? self.topPath)"
        
        for (index, param) in parameters.enumerated(){
            if index == 0{
                serviceUrl += "?"
            }else{
                serviceUrl += "&"
            }
            serviceUrl += "\(param.key)=\(param.value)"
        }
        
        //Call API
        guard let url = URL(string: serviceUrl) else {
            completion(.failure(.InvalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url){ data, response, error in
            //Handle error
            guard let jsonData = data else{
                completion(.failure(.InvalidData))
                return
            }
            
            //Parse posts
            do{
                
                var redditPosts : [Post] = []
                
                if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any] {
                    if let data = json["data"] as? [String : Any]{
                        if let children = data["children"] as? [[String : Any]]{
                            for child in children {
                                if let childrenData = child["data"] as? [String : Any] {
                                    
                                    //Append posts
                                    if let id = childrenData["id"] as? String,
                                       let author = childrenData["author"] as? String,
                                       let title = childrenData["title"] as? String,
                                       let date = childrenData["created"] as? Int,
                                       let comments = childrenData["num_comments"] as? Int,
                                       let unread = childrenData["clicked"] as? Bool{
                                        
                                        let post = Post(
                                            id,
                                            title: title,
                                            author: author,
                                            date: date,
                                            thumbnail: childrenData["thumbnail"] as? String,
                                            numberOfComments: comments,
                                            unreadStatus: unread)
                                        
                                        redditPosts.append(post)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                
                completion(.success(redditPosts))
                
                
            }catch{
                completion(.failure(.InvalidData))
            }
            
        }
        
        dataTask.resume()
        
    }
        
}
