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
    
}
