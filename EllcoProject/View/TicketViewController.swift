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
    
    private lazy var pageActivityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        activity.hidesWhenStopped = true
        activity.style = .medium
        return activity
    }()
    
    private let networkManager = NetworkManager.shared
    
    private var tickets: [TicketModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backColor = #colorLiteral(red: 0.4390679896, green: 0.9930132031, blue: 1, alpha: 1)
        self.tableView.backgroundColor = backColor
        
        configureTableView()
        loadTickets()
    }
    
    private func loadTickets() {
        networkManager.getTickets(succes: { [weak self] (result) in
            self?.ticketLoaded(result)
            self?.tableView.tableFooterView = nil
            self?.pageActivityIndicator.startAnimating()
        }) { [weak self] (error) in
            let alert = UIAlertController(title: "Ошибка!", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self?.present(alert, animated: true, completion: nil)
            self?.tableView.tableFooterView = nil
            self?.pageActivityIndicator.startAnimating()
        }
    }
    
    private func ticketLoaded(_ items: [TicketModel]) {
        self.tickets += items
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + tableView.bounds.height >= tableView.contentSize.height - 200 && !networkManager.isLoading && !networkManager.isFinished {
            tableView.tableFooterView = pageActivityIndicator
            pageActivityIndicator.startAnimating()
            loadTickets()
        }
    }
}

