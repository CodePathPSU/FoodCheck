//
//  LoginViewController.swift
//  FoodCheck
//
//  Created by Sana Tipnis on 3/29/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                //self.performSegue(withIdentifier: "loginSegue", sender: nil)
                var currentUser = PFUser.current()
                //let query = PFUser.query()
                //query?.whereKey("Author", equalTo: self.usernameField.text)

                self.loginChange()
                
                
            } else {
                print ("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
               // self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.loginChange()
                var currentUser = PFUser.current()

            } else {
                print ("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    
    func loginChange() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate).changeRootViewController(mainTabBarController)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
