//
//  Post.swift
//  NodejsAPIwithSwift
//
//  Created by MCT on 14.04.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let id, title, postDescription, date: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case postDescription = "description"
        case date
        case v = "__v"
    }
}
 

