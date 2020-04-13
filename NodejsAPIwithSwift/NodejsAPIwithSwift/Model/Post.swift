//
//  Post.swift
//  NodejsAPIwithSwift
//
//  Created by MCT on 14.04.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let id: String
    let title: String
    let description:String
}
