//
//  TicketViewController.swift
//  EllcoProject
//
//  Created by Eldar on 26.01.2021.
//

import UIKit

class TicketViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var tickets: [TicketModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backColor = #colorLiteral(red: 0.4390679896, green: 0.9930132031, blue: 1, alpha: 1)
        self.tableView.backgroundColor = backColor
        
        configureTableView()
        NetworkManager.shared.getTickets(succes: { [weak self] (result) in
            self?.ticketLoaded(result)
        }) { [weak self] (error) in
            let alert = UIAlertController(title: "Ошибка!", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self?.present(alert, animated: true, completion: nil)
            
        }
    }
    
    private func ticketLoaded(_ items: [TicketModel]) {
        self.tickets = items
        
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            print("gj")
        }
    }
}

extension TicketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell", for: indexPath) as! TicketTableViewCell
         
        let ticket = tickets[indexPath.row]
        cell.configure(with: ticket)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ticket = tickets[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "TicketDetailVC") as! SecondTableViewController
        detailVC.ticket = ticket
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

