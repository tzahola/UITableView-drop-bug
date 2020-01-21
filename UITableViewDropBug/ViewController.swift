//
//  ViewController.swift
//  UITableViewDropBug
//
//  Created by Tamás Zahola on 2020. 01. 21..
//  Copyright © 2020. Tamás Zahola. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

class ViewController: UIViewController {

    @IBOutlet weak var dragView: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        dragView.addInteraction(UIDragInteraction(delegate: self))

        tableView.dropDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.label.text = items[indexPath.row]
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

extension ViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let row = coordinator.destinationIndexPath?.row ?? items.count
        items.insert("Item \(items.count)", at: row)

        tableView.performBatchUpdates({
            tableView.insertRows(at: [[0, row]], with: .automatic)
        }, completion: nil)
        coordinator.drop(coordinator.items[0].dragItem, toRowAt: [0, row])
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
}

extension ViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider(item: "" as NSString, typeIdentifier: ""))]
    }
}
