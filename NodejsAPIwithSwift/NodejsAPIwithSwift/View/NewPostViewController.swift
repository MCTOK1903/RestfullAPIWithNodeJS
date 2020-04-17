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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if titleTf.text != nil && descriptionTF.text != nil {
            
            DispatchQueue.main.async {
                Service.service.createPost(title: self.titleTf.text!, description: self.descriptionTF.text!) { (error) in
                        if let errror = error {
                            print(error?.localizedDescription)
                        }
            }
                
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }
        
        
    }
    
    
}
