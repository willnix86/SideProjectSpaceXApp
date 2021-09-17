//
//  UpcomingViewController.swift
//  SideProjectSpaceXApp
//
//  Created by Will Nixon on 9/17/21.
//

import UIKit
import SpaceXApiModule

class UpcomingViewController: UIViewController {
  private var safeArea: UILayoutGuide!
  
  private let service: SpaceXApiService
  private var upcomingLaunches: [Launch]?
  
  private var tableView: UITableView!
  private var loadingIndicator: UIActivityIndicatorView!

  init(service: SpaceXApiService) {
    self.service = service
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    safeArea = view.layoutMarginsGuide
    
    view.backgroundColor = .systemPink
    
    _ = service.getUpcomingLaunches(completion: { result in
      switch result {
        case .success(let launches):
          self.upcomingLaunches = launches
          DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadingIndicator.isHidden = true
            self.tableView.isHidden = false
          }
        case .failure(_):
          print("Failed to fetch latest launch")
      }
    })
    
    let title: UILabel = {
      let label = UILabel()
      let title = "Upcoming Launches"
      label.text = title
      label.accessibilityLabel = title
      label.isAccessibilityElement = true
      label.textColor = .white
      label.font = .boldSystemFont(ofSize: 26)
      label.adjustsFontForContentSizeCategory = true
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    view.addSubview(title)
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
      title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      title.heightAnchor.constraint(equalToConstant: 50)
    ])
    
    tableView = {
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LaunchTableViewCell")
      tableView.delegate = self
      tableView.dataSource = self
      tableView.isHidden = true
      return tableView
    }()
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
    ])
    
    loadingIndicator = {
      let indictor = UIActivityIndicatorView(style: .large)
      return indictor
    }()
    view.addSubview(loadingIndicator)
    NSLayoutConstraint.activate([
      loadingIndicator.topAnchor.constraint(equalTo: tableView.bottomAnchor),
      loadingIndicator.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
      loadingIndicator.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
      loadingIndicator.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
    ])

  }
}

extension UpcomingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.upcomingLaunches?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath)
    if let launch: Launch = self.upcomingLaunches?[indexPath.row] {
      cell.textLabel?.text = "hello"
    }
    return cell
  }
}

extension UpcomingViewController: UITableViewDelegate {
  // Add as needed
}




