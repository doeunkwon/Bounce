//
//  LibraryViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-02.
//

import UIKit

class LibraryViewController: UIViewController {
    
    let coreDataManager = CoreDataManager()
    
    @IBOutlet weak var eventTableView: UITableView!
    
    var eventArray = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDataManager.loadEvents(&eventArray)
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "reusableCell")
        
        eventArray.sort { $0.day < $1.day}
        
    }
    
}

//MARK: - UITableViewDelegate

// enables the 'swipe to delete' feature
extension LibraryViewController: UITableViewDelegate {
    
    private func handleMoveToDelete(_ tableView: UITableView, _ indexPath: IndexPath) {
        coreDataManager.delete(eventArray[indexPath.row])
        eventArray.remove(at: indexPath.row)
        coreDataManager.save()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                       title: "Delete") { [weak self] (action, view, completionHandler) in
                                        self?.handleMoveToDelete(tableView, indexPath)
                                        completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
}

//MARK: - UITableViewDataSource

extension LibraryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dayTime : String?
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! EventCell
        cell.eventLabel.text = "\(eventArray[indexPath.row].event!)"
        switch eventArray[indexPath.row].day {
        case 0:
            dayTime = "early"
        case 1:
            dayTime = "noon"
        case 2:
            dayTime = "late"
        default:
            dayTime = "noon"
        }
        
        cell.infoLabel.text = "\(dayTime!) · \(eventArray[indexPath.row].time)h"
        return cell
        
    }
    
}
