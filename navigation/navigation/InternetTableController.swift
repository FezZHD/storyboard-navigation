//
//  InternetTableController.swift
//  navigation
//
//  Created by Evgeni' Roslik on 21/03/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit
import Alamofire

class InternetTableController: UITableViewController {

    
    typealias jsonList = (Int, String, String, String)
    
    var activityIndecator:UIActivityIndicatorView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndecator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        activityIndecator?.color = UIColor.blue;
        let barButton = UIBarButtonItem(customView: activityIndecator!)
        self.navigation.setRightBarButton(barButton, animated: true)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var table: UITableView!
    
    @IBOutlet var navigation: UINavigationItem!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndecator?.startAnimating()
        DispatchQueue.global(qos: .utility).async{
            Alamofire.request("https://jsonplaceholder.typicode.com/posts", method: .get).responseString(completionHandler: {response in
            if (response.result.isSuccess)
            {
                let resultJson = response.result.value!;
                print(resultJson);
            }
                
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.activityIndecator?.stopAnimating();
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
