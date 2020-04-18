//
//  WebSerivece.swift
//  NodejsAPIwithSwift
//
//  Created by MCT on 14.04.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import Foundation

class Service{
    
    static let service = Service()
    
    func fetchPosts(completion: @escaping ([Post]?) -> ()){
        
        guard let url = URL(string:"http://localhost:3000/posts") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err{
                completion(nil)
                print(err.localizedDescription)
            }else if let data = data{
                
                let postList = try? JSONDecoder().decode([Post].self, from: data)
                if let postList = postList {
                    completion(postList)
                }
            }
        }.resume()
    }
    
    func createPost(title:String,description:String,completion: @escaping (Error?) -> ()){
        
        guard let url = URL(string: "http://localhost:3000/posts") else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["title":title, "description":description]
        
        
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
                if let err = err {
                    completion(nil)
                    print(err)
                    return
                }
                guard let data = data else{return}
                completion(nil)
                print("succes")
            }.resume()
        } catch {
            completion(nil)
        }
    }
    
    
    func updatePost(postId:String,title:String,description:String, completion: @escaping (Error?) -> ()){
        
        guard let url = URL(string: "http://localhost:3000/posts/\(postId)") else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        
        let params = ["title":title,"description":description]
        
        do{
            
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
                if let err = err {
                    completion(nil)
                    print(err)
                    return
                }
                guard let data = data else {return}
                completion(nil)
                print("succes")
            }.resume()
        }catch{
            completion(nil)
        }
        
        
        
    }
    
    
    func  deletePost(postId:String, completion: @escaping (Error?) -> ()){
        
        guard let url = URL(string: "http://localhost:3000/posts/\(postId)") else{return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            if let err = err {
                completion(err)
                return
            }
            completion(nil)
        }.resume()
    }
    
    
    
    
}
