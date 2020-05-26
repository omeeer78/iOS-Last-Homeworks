//
//  MainMainViewController.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import UIKit

protocol MainViewInput: class {
    
    func reloadTable()
    func set(dataSource: UITableViewDataSource)
    func didFinishedEditingHeroes()
    func triggerHapticFeedback()
}

protocol MainViewOutput {
    
    func viewIsReady()
    func loadHeroes()
    var navTitle: String { get }
    func didActivateDeleteAction(at indexPath: IndexPath)
    func didActivateRenameAction(at indexPath: IndexPath)
    func didLongPressedOnCell(at indexPath: IndexPath)
}

class MainViewController: UIViewController, MainViewInput {
    
    var output: MainViewOutput!
    
    /// Table view for heroes
    private var tableView: UITableView!
    
    /// Haptic touch generator
    private let generator = UIImpactFeedbackGenerator(style: .light)
    
    /// Gesture recognizers for view
    private lazy var longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressAction(_:)))
    
    var coverView = UIVisualEffectView()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
        initVeiws()
    }
    
    private func initVeiws() {
        
        initTableView()
        
        title = output.navTitle
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /// Method, that initialize tableView & add constraints to it
    private func initTableView() {
        
        tableView = UITableView()
        tableView.backgroundColor = .white
        
        longPressGesture.minimumPressDuration = 0.4
        tableView.addGestureRecognizer(longPressGesture)
        
        tableView.delegate = self        
        tableView.register(cell: HeroCell.self)
        tableView.frame = view.frame
        view.addSubview(tableView)
    }
    
    /// Method for reload table after data got
    func reloadTable() {        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /// Meethod to set data source to table
    /// - Parameter dataSource: datasource to be install as datasource
    func set(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    // MARK: MainViewInput
    func triggerHapticFeedback() {
        generator.impactOccurred()
    }
    
    func didFinishedEditingHeroes() {
        output.loadHeroes()
    }
    
    @objc private func didLongPressAction(_ gesture: UILongPressGestureRecognizer) {
        
        guard gesture.state == .began else { return }
        
        let point = gesture.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        output.didLongPressedOnCell(at: indexPath)
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        generator.impactOccurred()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let renameButton = UIContextualAction(style: .normal, title: Constants.renameButtonTitle) { [weak self] (_, _, completion) in
            self?.output.didActivateRenameAction(at: indexPath)
            completion(true)
        }
        
        let deleteButton = UIContextualAction(style: .destructive, title: Constants.deleteButtonTitle) { [weak self] (_, _, completion) in
            
            self?.output.didActivateDeleteAction(at: indexPath)
            completion(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteButton, renameButton])
        
        configuration.performsFirstActionWithFullSwipe = true        
        
        return configuration
    }
}
