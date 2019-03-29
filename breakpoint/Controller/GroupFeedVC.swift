//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Alex on 3/27/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableTopConstraint: NSLayoutConstraint!
    var group: Group?
    var groupMessages = [Message]()
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmailsFor(group: group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        DataService.instance.getAllMessagesFor(desiredGroup: self.group!) { (returnedGroupMessages) in
            self.groupMessages = returnedGroupMessages
            self.tableView.reloadData()
            if self.groupMessages.count > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
//        mainView.bindKeyboard()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        mainView.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(changeKeyboard), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func changeKeyboard(notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        print(deltaY)
        if deltaY < 0 { //up
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
                self.bottomConstraint.constant -= deltaY + 34
                print(self.tableBottomConstraint.constant)
                self.tableBottomConstraint.constant -= deltaY + 34
                print(self.tableBottomConstraint.constant)
                self.view.layoutIfNeeded()
                if self.groupMessages.count != 0 {
                self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            },completion: nil)
        } else if deltaY > 0 {
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
                self.bottomConstraint.constant -= deltaY - 34
                self.tableBottomConstraint.constant -= deltaY - 34
                self.view.layoutIfNeeded()
                if self.groupMessages.count != 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            },completion: nil)
        }
    }
    
    @objc func hideKeyboard() {
        messageTextField.endEditing(true)
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withUsername: (Auth.auth().currentUser?.email)!, withGroupKey: group?.key) { (complete) in
                if complete {
                    self.messageTextField.text! = ""
                    self.messageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            }
        }
    }
    
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = groupMessages[indexPath.row].content
        let username = groupMessages[indexPath.row].username
        cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: username, content: message)
        return cell
    }
    
}

extension GroupFeedVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.groupMessages.count > 0 {
            self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
        }
    }
}
