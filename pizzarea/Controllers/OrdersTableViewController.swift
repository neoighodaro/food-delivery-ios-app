//
//  OrdersTableViewController.swift
//  pizzarea
//
//  Created by Neo Ighodaro on 09/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    var orders = [
        Order(
            pizza: Pizza(data: [
                "name": "Pizza Margherita",
                "description": "Features tomatoes, sliced mozzarella, basil, and extra virgin olive oil.",
                "amount": 39.99 as Float,
                "image": UIImage(named: "pizza1")!
            ]),
            status: .pending
        ),
        Order(
            pizza: Pizza(data: [
                "name": "Bacon cheese fry",
                "description": "Features tomatoes, bacon, cheese, basil and oil",
                "amount": 29.99 as Float,
                "image": UIImage(named: "pizza2")!
            ]),
            status: .delivered
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orders"
    }

    @IBAction func ordersButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath)
        let order = orders[indexPath.row]

        cell.textLabel?.text = order.pizza.name
        cell.imageView?.image = order.pizza.image
        cell.detailTextLabel?.text = "$\(order.pizza.amount) - \(order.status.rawValue)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "order", sender: orders[indexPath.row] as Order)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "order" {
            guard let vc = segue.destination as? OrderViewController else { return }
            vc.order = sender as? Order
        }
    }
}
