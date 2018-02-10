//
//  PizzaViewController.swift
//  pizzarea
//
//  Created by Neo Ighodaro on 06/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit

class PizzaViewController: UIViewController {
    
    var pizza: Pizza?

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var pizzaDescription: UILabel!
    @IBOutlet weak var pizzaImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = pizza!.name
        pizzaImageView.image = pizza!.image
        pizzaDescription.text = pizza!.description
        amount.text = "$\(String(describing: pizza!.amount))"
    }

    @IBAction func buyButtonPressed(_ sender: Any) {
        let alertCtrl = UIAlertController(
            title: "Purchase Successful",
            message: "You have ordered successfully. Your order will be confirmed soon.",
            preferredStyle: .alert
        )

        alertCtrl.addAction(UIAlertAction(title: "Okay", style: .cancel) { action in
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alertCtrl, animated: true, completion: nil)
    }
}
