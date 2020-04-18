//
//  NewPostViewController.swift
//  NodejsAPIwithSwift
//
//  Created by MCT on 17.04.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var updateButton: UIButton!
    var selectedPost : PostViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedPost != nil {
            titleTf.text = selectedPost?.title
            descriptionTF.text = selectedPost?.description
            updateButton.isHidden = false
            updateButton.isEnabled = true
            saveButton.isHidden = true
            saveButton.isEnabled = false
        }else{
            updateButton.isHidden = true
            updateButton.isEnabled = false
            saveButton.isHidden = false
            saveButton.isEnabled = true
        }
       
    }
    
    @IBAction func updateClicked(_ sender: Any) {
        
        if titleTf.text != nil && descriptionTF.text != nil {
            
            DispatchQueue.main.async {
            
                Service.service.updatePost(postId: self.selectedPost!.id, title: self.titleTf.text!, description: self.descriptionTF.text!) { (err) in
                    if let err = err {
                        self.makeAlert(title: "Error!", message: err.localizedDescription )
                    }
                }
                self.selectedPost = nil
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if titleTf.text != nil && descriptionTF.text != nil {
            
            DispatchQueue.main.async {
                Service.service.createPost(title: self.titleTf.text!, description: self.descriptionTF.text!) { (error) in
                        if let errror = error {
                            self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                        }
                    }
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
 
    
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    
}
