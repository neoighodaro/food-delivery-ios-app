//
//  PizzaListTableViewController.swift
//  pizzarea
//
//  Created by Neo Ighodaro on 06/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit
import Alamofire

class PizzaListTableViewController: UITableViewController {

    var pizzas: [Pizza] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Select Pizza"
        
        fetchInventory { pizzas in
            guard pizzas != nil else { return }
            
            self.pizzas = pizzas!
            self.tableView.reloadData()
        }
    }

    private func fetchInventory(completion: @escaping ([Pizza]?) -> Void) {
        Alamofire.request(AppConstants.APIURL+"/inventory", method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else { return completion(nil) }
                guard let rawInventory = response.result.value as? [[String: Any]?] else { return completion(nil) }
                
                let inventory = rawInventory.flatMap { pizzaDict -> Pizza? in
                    var data = pizzaDict!
                    data["image"] = UIImage(named: pizzaDict!["image"] as! String)
                    
                    return Pizza(data: data)
                }
                
                completion(inventory)
            }
    }
    
    @IBAction func ordersButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "orders", sender: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pizza", for: indexPath) as! PizzaTableViewCell
        
        cell.name.text = pizzas[indexPath.row].name
        cell.imageView?.image = pizzas[indexPath.row].image
        cell.amount.text = "$\(pizzas[indexPath.row].amount)"
        cell.miscellaneousText.text = pizzas[indexPath.row].description

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pizza", sender: self.pizzas[indexPath.row] as Pizza)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pizza" {
            guard let vc = segue.destination as? PizzaViewController else { return }
            vc.pizza = sender as? Pizza
        }
    }    
}
