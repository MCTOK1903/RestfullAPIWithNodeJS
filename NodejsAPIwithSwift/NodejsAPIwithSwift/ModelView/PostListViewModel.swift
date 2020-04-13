//
//  PostListViewModel.swift
//  NodejsAPIwithSwift
//
//  Created by MCT on 14.04.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import Foundation

struct PostListViewModel {
    var postList : [Post]
}

extension PostListViewModel{
    
    func numberOfRowsInSection() -> Int{
        return postList.count
    }
    
    func cellForRowAt(_ index:Int) -> PostViewModel {
        let post = self.postList[index]
        return PostViewModel(postViewModel: post)
    }
    
    mutating func removePost(_ index: Int){
        self.postList.remove(at: index)
    }
    
    
    
}
