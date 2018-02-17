//
//  OrdersTableViewController.swift
//  PizzareaAdmin
//
//  Created by Neo Ighodaro on 11/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit
import Alamofire

class OrdersTableViewController: UITableViewController {

    var orders: [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Client Orders"
        
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
    
    private func updateOrderStatus(_ status: OrderStatus, order: Order, completion: @escaping(Bool) -> Void) {
        let url = AppConstants.APIURL+"/orders/" + order.id
        let params = ["status": status.rawValue]

        Alamofire.request(url, method: .put, parameters: params).validate().responseJSON { response in
            guard response.result.isSuccess else { return completion(false) }
            guard let data = response.result.value as? [String: Bool] else { return completion(false) }
            
            completion(data["status"]!)
        }
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
        let order: Order = orders[indexPath.row]
        
        let alertCtrl = UIAlertController(
            title: "Change Status",
            message: "Change the status of the order based on the progress made.",
            preferredStyle: .actionSheet
        )
        
        alertCtrl.addAction(createActionForStatus(.pending, order: order))
        alertCtrl.addAction(createActionForStatus(.accepted, order: order))
        alertCtrl.addAction(createActionForStatus(.dispatched, order: order))
        alertCtrl.addAction(createActionForStatus(.delivered, order: order))
        alertCtrl.addAction(createActionForStatus(nil, order: nil))
        
        present(alertCtrl, animated: true, completion: nil)
    }
    
    private func createActionForStatus(_ status: OrderStatus?, order: Order?) -> UIAlertAction {
        let alertTitle = status == nil ? "Cancel" : status?.rawValue
        let alertStyle: UIAlertActionStyle = status == nil ? .cancel : .default
        
        let action = UIAlertAction(title: alertTitle, style: alertStyle) { action in
            if status != nil {
                self.setStatus(status!, order: order!)
            }
        }
        
        if status != nil {
            action.isEnabled = status?.rawValue != order?.status.rawValue
        }
        
        return action
    }
    
    private func setStatus(_ status: OrderStatus, order: Order) {
        updateOrderStatus(status, order: order) { successful in
            guard successful else { return }
            guard let index = self.orders.index(where: {$0.id == order.id}) else { return }

            self.orders[index].status = status
            self.tableView.reloadData()
        }
    }
}
