//
//  SecondTableViewController.swift
//  EllcoProject
//
//  Created by Eldar on 29.01.2021.
//

import UIKit

class SecondTableViewController: UITableViewController {
    
    var ticket: TicketModel!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var descriptionManagerLabel: UILabel!
    @IBOutlet var tooltipLabel: UILabel!
    @IBOutlet var senderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = #colorLiteral(red: 0.9380168319, green: 0.7504708171, blue: 1, alpha: 1)
        tableView.tableFooterView = UIView()
        configureTicketDetail()
    }

    private func configureTicketDetail() {
        nameLabel.text = ticket.name
        descriptionLabel.text = ticket.description
        descriptionManagerLabel.text = ticket.status.description
        tooltipLabel.text = ticket.status.tooltip
        senderLabel.text = ticket.sender.username
        
        
    }

}
