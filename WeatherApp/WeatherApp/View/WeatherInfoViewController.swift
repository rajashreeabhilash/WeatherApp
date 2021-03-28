//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created by AADM504 on 28/3/21.
//

import UIKit

class WeatherInfoViewController: UIViewController {
    @IBOutlet weak var weatherInfoTableView: UITableView!
    
    fileprivate var viewModel = WeatherInfoViewModel()
    private var context = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: NSNotification.Name("ListUpdated"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Private methods

extension WeatherInfoViewController {
    @objc private func refreshTable() {
        self.weatherInfoTableView.reloadData()
    }
}

// MARK: - Table view datasource

extension WeatherInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.suburbsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableId = "WeatherInfoCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath) as! WeatherInfoTableViewCell
        cell.configure(with: viewModel.suburbsList[indexPath.row])
        return cell
    }
}

// MARK: - Table view delegate

extension WeatherInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "WeatherInfo", bundle: Bundle(for: Self.self))
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        viewController.setUpViewModel(with: viewModel.suburbsList[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


