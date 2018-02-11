//
//  Order.swift
//  pizzarea
//
//  Created by Neo Ighodaro on 10/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import Foundation

struct Order {
    let id: String
    let pizza: Pizza
    var status: OrderStatus
}

enum OrderStatus: String {
    case pending = "Pending"
    case accepted = "Accepted"
    case dispatched = "Dispatched"
    case delivered = "Delivered"
}
