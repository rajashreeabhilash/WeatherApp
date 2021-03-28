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
    private var isFiltered: Bool = false
    private var suburbsList: [WeatherInfoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suburbsList = viewModel.suburbsList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: NSNotification.Name("ListUpdated"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Action

extension WeatherInfoViewController {
    @IBAction func sortAlphabetically(_ sender: Any) {
        suburbsList.sort(by: {$0.name < $1.name })
        weatherInfoTableView.reloadData()
    }
    
    @IBAction func sortTemp(_ sender: Any) {
        suburbsList.sort(by: {$0.temperature ?? "100" < $1.temperature ?? "100" })
        weatherInfoTableView.reloadData()
    }
    
    @IBAction func sortDatewise(_ sender: Any) {
        suburbsList.sort(by: {$0.updatedDate ?? Date() < $1.updatedDate ?? Date() })
        weatherInfoTableView.reloadData()
    }
    
    @IBAction func filter(_ sender: Any) {
        // TODO: Filtering is based on 2 countries for now, need a new controller to display all
        if (isFiltered) {
            suburbsList = viewModel.suburbsList.filter({$0.country.name == "Australia"})
        } else {
            suburbsList = viewModel.suburbsList.filter({$0.country.name == "New Zealand"})
        }
        isFiltered = !isFiltered
        weatherInfoTableView.reloadData()
    }
}

// MARK: - Private methods

extension WeatherInfoViewController {
    @objc private func refreshTable() {
        suburbsList = viewModel.suburbsList
        self.weatherInfoTableView.reloadData()
    }
}

// MARK: - Table view datasource

extension WeatherInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suburbsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableId = "WeatherInfoCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath) as! WeatherInfoTableViewCell
        cell.configure(with: suburbsList[indexPath.row])
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
        viewController.setUpViewModel(with: suburbsList[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


