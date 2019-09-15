//
//  ItemsViewController.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanQRButton: UIButton!
    
    var isQRCodeParsed = false
    var model = ItemsDataSource()
    
    var qrCodeRawString: String? = nil
    
    private let itemCellID = "\(ItemCell.self)"
    private let addCellID = "\(AddItemCell.self)"
    private let headerID = "\(GroupSectionView.self)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupScanQRButton()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: itemCellID, bundle: nil), forCellReuseIdentifier: itemCellID)
        tableView.register(UINib(nibName: addCellID, bundle: nil), forCellReuseIdentifier: addCellID)
        tableView.register(UINib(nibName: headerID, bundle: nil), forHeaderFooterViewReuseIdentifier: headerID)
    }
    
    func setupScanQRButton() {
        scanQRButton.layer.cornerRadius = 27
        scanQRButton.clipsToBounds = true
    }

    @IBAction func qrCodeScanDidTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toQRCode", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? QRCodeScanViewController else { return }
        destination.delegate = self
    }
    
    func updateData() {
        guard let raw = qrCodeRawString else { return }
        ModalLoadingIndicator.show()
        ServiceLayer.shared.checkService.obtainCheckInfo(rawQRCode: raw) { [weak self] result in
            switch result {
            case .error(let error):
                self?.showError(error)
            case .success(let model):
                dump(model)
            }
            ModalLoadingIndicator.hide()
        }
    }
    
}

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? GroupSectionView
        let title = section == 0 ? "ПОЗИЦИИ ЧЕКА" : ""
        header?.headerTitle.text = title
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == model.items.count {
            // Вызов UI добавления айтема
        }
        
    }
}

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Последняя ячейка для добавить
        if indexPath.row == model.items.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: addCellID, for: indexPath)
                as? AddItemCell else { return UITableViewCell() }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemCellID, for: indexPath)
            as? ItemCell else { return UITableViewCell() }
        let item = model.items[indexPath.row]
        cell.fill(item: item)
        return cell
    }
    
}

extension ItemsViewController: QRCodeScanViewControllerDelegate {
    func didScanQRCode(rawString: String) {
        qrCodeRawString = rawString
        updateData()
    }
}
