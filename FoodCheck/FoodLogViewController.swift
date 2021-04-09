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
    
    @IBOutlet weak var Date: UITextField!
    
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
        
        if self.Name.text == "" || self.Category.text == "" || self.Date.text == "" {
            let foodLog = PFObject(className: "FoodLog")
            foodLog["Name"] = Name.text
            foodLog["Date"] = Date.text
            foodLog["Category"] = Category.text
            
            foodLog.saveInBackground { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    
                    self.errorLabel.isHidden = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.errorLabel.isHidden = true

                    }
                    print("Success")
                } else {
                    print("Error")
                }
            }

                    
        } else {
            self.submittedLabel.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.submittedLabel.isHidden = true
            }
        }
        
        
        
        
    }
    
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
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
