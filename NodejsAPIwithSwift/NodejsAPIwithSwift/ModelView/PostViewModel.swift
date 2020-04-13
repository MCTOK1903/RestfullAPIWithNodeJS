//
//  PostViewModel.swift
//  NodejsAPIwithSwift
//
//  Created by MCT on 14.04.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import Foundation


struct PostViewModel {
    let postViewModel : Post
}

extension PostViewModel{
    var id: String {
        return self.postViewModel.id
    }
    var title: String{
        return self.postViewModel.title
    }
    var description: String {
        return self.postViewModel.description
    }
}
