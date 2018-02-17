//
//  OrdersTableViewController.swift
//  pizzarea
//
//  Created by Neo Ighodaro on 09/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit
import Alamofire

class OrdersTableViewController: UITableViewController {

    var orders: [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orders"

        fetchOrders { orders in
            self.orders = orders!
            self.tableView.reloadData()
        }
    }

    private func fetchOrders(completion: @escaping([Order]?) -> Void) {
        Alamofire.request(AppConstants.APIURL+"/orders").validate().responseJSON { response in
            guard response.result.isSuccess else { return completion(nil) }
            
            guard let rawOrders = response.result.value as? [[String: Any]?] else { return completion(nil) }

            let orders = rawOrders.flatMap { ordersDict -> Order? in
                guard let orderId = ordersDict!["id"] as? String,
                      let orderStatus = ordersDict!["status"] as? String,
                      var pizza = ordersDict!["pizza"] as? [String: Any] else { return nil }
                
                pizza["image"] = UIImage(named: pizza["image"] as! String)

                return Order(
                    id: orderId,
                    pizza: Pizza(data: pizza),
                    status: OrderStatus(rawValue: orderStatus)!
                )
            }

            completion(orders)
        }
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
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
