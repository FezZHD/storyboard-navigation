//
//  LocalTableView.swift
//  navigation
//
//  Created by Evgeni' Roslik on 05/04/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit
import SwiftyJSON

class LocalTableView: UITableViewController {

    
    var objectList = [LocalObject]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBOutlet var localTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.hidesBottomBarWhenPushed = false;
        if let path = NSDataAsset(name: "jsonText"){
            do
            {
                //let jsonString = String)
                //let json:NSData = data(using:String.Encoding.utf8.rawValue)! as NSData
                let resultJson = JSON(path.data);
                for (index, currentJson) in resultJson {
                    let object = LocalObject(uri: currentJson["imageUri"].string!, title: currentJson["title"].string!, shordDesc:currentJson["shortDesc"].string!, desc: currentJson["desc"].string! );
                    objectList.append(object);
                }
                self.localTable.reloadData();
            }catch let error{
                print(error.localizedDescription, "shit");
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.objectList.removeAll();
        self.localTable.reloadData();
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectList.count;
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocalCell", for: indexPath) as! LocalCell;
        cell.cellImage?.image = UIImage(named: objectList[indexPath.item].uri);
        cell.name?.text = objectList[indexPath.item].title;
        cell.shortDesc?.text = objectList[indexPath.item].shortDesc;

        // Configure the cell...

        return cell
    }

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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PushCell"){
            let destVC = segue.destination as? PushCellController;
            destVC?.hidesBottomBarWhenPushed = true;
            let index = self.localTable.indexPathForSelectedRow?.row;
            destVC?.uri = self.objectList[index!].uri;
            destVC?.desc = self.objectList[index!].desc;
            destVC?.pictureName = self.objectList[index!].shortDesc;
            destVC?.navigationTitle = self.objectList[index!].title;
        }
        
    }


}
