//
//  ViewController.swift
//  NodejsAPIwithSwift
//
//  Created by MCT on 14.04.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var postListViewModel: PostListViewModel!
    var chosenPost : PostViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.fetchData()
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Posts"
        navigationItem.rightBarButtonItem = .init(title: "Create Post", style: .done, target: self, action: #selector(createPost))
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
                   self.fetchData()
        }
    }
    
    
    func fetchData(){
        Service.service.fetchPosts { (postList) in
            if let postList = postList {
                self.postListViewModel = PostListViewModel(postList: postList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func createPost(){
        performSegue(withIdentifier: "toNewPost", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postListViewModel == nil ? 0 : postListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let postView = postListViewModel.cellForRowAt(indexPath.row)
        cell.textLabel?.text = postView.title
        cell.detailTextLabel?.text = postView.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = self.postListViewModel.cellForRowAt(indexPath.row)
            Service.service.deletePost(postId: post.id) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self.postListViewModel.removePost(indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    print("success")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenPost = postListViewModel.cellForRowAt(indexPath.row)
        self.performSegue(withIdentifier: "toNewPost", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewPost" {
            let destination = segue.destination as! NewPostViewController
            destination.selectedPost = chosenPost
        }
    }
    
    
    
    
}

