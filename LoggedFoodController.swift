//
//  LoggedFoodController.swift
//  FoodCheck
//
//  Created by Sana Tipnis on 3/29/21.
//

import UIKit
import Parse

class LoggedFoodController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var userFoods = [PFObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.row > userFoods.count-1) {
            return UITableViewCell()
        }
        
        else {
        
            let food = userFoods[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
            
            //let user = food["Author"] as? PFUser
            
            let name = food["Name"] as! String
            
            //let category = food["Category"] as! String
            
            let date = food["Date"] as! String
            
            let calendar = Calendar.current
            let today = Date()
            let formatter = DateFormatter()
            
            formatter.dateStyle = .short
            formatter.dateFormat = "MM/dd/yyyy"
            let end = formatter.date(from: date)!
            
            let days = calendar.dateComponents([.day], from: today, to: end)
            
            
            cell.foodLabel.text = name
            cell.daysLabel.text = String(days.day! + 1)
            
            
            return cell

        }
        
    

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let query = PFQuery(className:"FoodLog")
        query.includeKeys(["Name", "Date", "Category", "Author"])
        query.limit = 100
        
        query.whereKey("Author", equalTo: PFUser.current())
        query.order(byAscending: "Date")

        query.findObjectsInBackground { (success, error) in
            if success != nil {
                self.userFoods = success!
                self.tableView.reloadData()
            } else {
                print("error")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onLogout(_ sender: Any) {
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
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//            // #warning Incomplete implementation, return the number of sections
//            return 1
//        }
//
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            // #warning Incomplete implementation, return the number of rows
//            return 5
//        }
    
}
