//
//  TicketTableViewCell.swift
//  EllcoProject
//
//  Created by Eldar on 26.01.2021.
//

import UIKit

class TicketTableViewCell: UITableViewCell {

    
    @IBOutlet var conteinerView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        conteinerView.layer.cornerRadius = 10
        conteinerView.layer.masksToBounds = true
        conteinerView.layer.borderWidth = 2
        let borderColor = #colorLiteral(red: 0.4390679896, green: 0.9930132031, blue: 1, alpha: 1)
        conteinerView.layer.borderColor = borderColor.cgColor
        contentView.backgroundColor = borderColor
        conteinerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        conteinerView.layer.shadowOpacity = 0.7
        conteinerView.layer.shadowRadius = 10
        
    }
    
    func configure(with ticket: TicketModel) {
        nameLabel.text = ticket.name
        descriptionLabel.text = ticket.description
        senderLabel.text = ticket.sender.username
   
    }
}
