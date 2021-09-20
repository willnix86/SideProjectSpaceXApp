//
//  UpcomingViewController.swift
//  SideProjectSpaceXApp
//
//  Created by Will Nixon on 9/17/21.
//

import UIKit
import SpaceXApiModule

class UpcomingViewController: UIViewController {
  private let service: SpaceXApiService
  private var upcomingLaunches: [Launch]?
  
  private var safeArea: UILayoutGuide!
  
  private let titleLabel: UILabel = {
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
  
  private var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .black
    tableView.register(LaunchCell.self, forCellReuseIdentifier: "LaunchCell")
    tableView.isHidden = true
    return tableView
  }()
  
  private var loadingIndicator: UIActivityIndicatorView = {
    let indictor = UIActivityIndicatorView(style: .large)
    indictor.color = .white
    indictor.translatesAutoresizingMaskIntoConstraints = false
    indictor.startAnimating()
    return indictor
  }()

  init(service: SpaceXApiService) {
    self.service = service
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    _ = service.getUpcomingLaunches(completion: { result in
      switch result {
        case .success(let launches):
          self.upcomingLaunches = launches
          DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadingIndicator.removeFromSuperview()
            self.tableView.isHidden = false
          }
        case .failure(_):
          print("Failed to fetch latest launch")
      }
    })
    
    safeArea = view.layoutMarginsGuide
    view.backgroundColor = .systemPink
    
    view.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 50)
    ])
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
    ])
    
    view.addSubview(loadingIndicator)
    NSLayoutConstraint.activate([
      loadingIndicator.topAnchor.constraint(equalTo: tableView.topAnchor),
      loadingIndicator.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
      loadingIndicator.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
      loadingIndicator.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
    ])
    
    tableView.delegate = self
    tableView.dataSource = self

  }
}

extension UpcomingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.upcomingLaunches?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
    if let launch: Launch = self.upcomingLaunches?[indexPath.row] {
      cell.launch = launch
//      if let imageURL = launch.links.patch.small {
//        DispatchQueue.global().async {
//          if let data = try? Data(contentsOf: URL(fileURLWithPath: imageURL)) {
//            if let image = UIImage(data: data) {
//              DispatchQueue.main.async {
//                cell.launchImageView.image = image
//                self.tableView.reloadData()
//              }
//            }
//          }
//        }
//      }
    }
    return cell
  }
}

extension UpcomingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90.0
  }
}




