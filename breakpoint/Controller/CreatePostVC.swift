//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Alex on 3/2/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if textView.text != "" && textView.text != "Say something here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text!, forUID: (Auth.auth().currentUser?.uid)!, withUsername: (Auth.auth().currentUser?.email)!, withGroupKey: nil) { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.view.endEditing(true)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("There was an error")
                }
            }
            
        }
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
 
}
