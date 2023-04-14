//
//  EntryViewController.swift
//  Daily Journal
//
//  Created by Leandro Farias Lourenco on 17/02/23.
//

import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var entryTextField: UITextView!
    
    @IBOutlet weak var datePickerField: UIDatePicker!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var entriesVC: EntriesTableViewController?
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if entry == nil {
            let context = entriesVC!.getAppDelegate()!.persistentContainer.viewContext
            entry = Entry(context: context)
            entry!.date = datePickerField.date
            entry!.text = entryTextField.text
            entryTextField.becomeFirstResponder()
        } else {
            datePickerField.date = entry!.date!
            entryTextField.text = entry!.text
        }
        
        entryTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        entriesVC?.getAppDelegate()?.saveContext()
        entriesVC!.tableView.reloadData()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            bottomConstraint.constant = keyboardHeight
        }
    }
    
    @IBAction func deleteAction(_ sender: UIBarButtonItem) {
        if entry != nil {
            let context = entriesVC!.getAppDelegate()!.persistentContainer.viewContext
            context.delete(entry!)
            try? context.save()
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerDidChange() {
        entry?.date = datePickerField.date
        entriesVC?.getAppDelegate()!.saveContext()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = entryTextField.text
        entriesVC!.getAppDelegate()!.saveContext()
    }
}
