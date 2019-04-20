//
//  FurnituresTableViewModel.swift
//  FurnitureFuture
//
//  Created by Wojtek on 10/01/2019.
//  Copyright © 2019 Wojtek. All rights reserved.
//

import UIKit

struct CellData {
    let image: UIImage?
    let message: String?
}

class FurnituresTableViewModel: UITableViewController {
    
    var data = [CellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        data = [CellData.init(image: UIImage(named: "chestimg"), message: "chest"),CellData.init(image: UIImage(named: "chairimg"), message: "chair")]
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "custom")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomTableViewCell
        cell.mainImage = data[indexPath.row].image
        cell.message = data[indexPath.row].message
        cell.layoutSubviews()
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presenter = presentingViewController as? DesignViewModel {
            presenter.selectedItem = data[indexPath.row].message!
        }
        dismiss(animated: true, completion: nil)
    }
}
