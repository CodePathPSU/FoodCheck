//
//  FoodLogViewController.swift
//  FoodCheck
//
//  Created by Sana Tipnis on 4/8/21.
//

import UIKit
import Parse

class FoodLogViewController: UIViewController {
    
    @IBOutlet weak var submittedLabel: UILabel!
    
    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var dateText: UITextField!
    
    @IBOutlet weak var Category: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onSubmit(_ sender: Any) {
        let foodLog = PFObject(className: "FoodLog")

        if self.Name.text != "" && self.Category.text != "" && self.dateText.text != "" {

            foodLog["Name"] = Name.text
            foodLog["Date"] = dateText.text
            foodLog["Category"] = Category.text
            foodLog["Author"] = PFUser.current()

            foodLog.saveInBackground { (success, error) in
                
            if success {
                self.dismiss(animated: true, completion: nil)
                self.submittedLabel.isHidden = false

                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.submittedLabel.isHidden = true
                }
                
                print("Success")

            } else {
                print("Error")
            }
            }
        
            
        } else {
            self.errorLabel.isHidden = false


            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.errorLabel.isHidden = true

            print("Unfilled fields")
        }

    }
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
        var currentUser = PFUser.current()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        
        delegate.window?.rootViewController = loginViewController
    }
}
