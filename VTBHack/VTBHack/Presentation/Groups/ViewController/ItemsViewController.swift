//
//  ItemsViewController.swift
//  VTBHack
//
//  Created by Кирилл Володин on 15/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

protocol ItemsViewControllerDelegate: class {
    func didTapAddItem()
}

class ItemsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanQRButton: UIButton!
    
    var isQRCodeParsed = false
    var model = ItemsDataSource()
    var people = [Contact]()
    var currentPersonId = 0
    
    var qrCodeRawString: String? = nil
    
    weak var delegate: ItemsViewControllerDelegate?
    
    private let itemCellID = "\(ItemCell.self)"
    private let addCellID = "\(AddItemCell.self)"
    private let headerID = "\(GroupSectionView.self)"
    private var cnt: PeopleSelectorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupScanQRButton()
        setupPicker()
        cnt.isHidden = true
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if model.items.count > 0 {
            validate()
            cnt.people = people
            cnt.setup()
        }
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
    
    func obtainCheckData() {
        guard let raw = qrCodeRawString else { return }
        ModalLoadingIndicator.show()
        ServiceLayer.shared.checkService.obtainCheckInfo(rawQRCode: raw) { [weak self] result in
            switch result {
            case .error(let error):
                self?.showError(error)
            case .success(let model):
                self?.model.checkItemsDto = model
                self?.updateData()
            }
            ModalLoadingIndicator.hide()
        }
    }
    
    func updateData() {
        model.updateData()
        isQRCodeParsed = true
        scanQRButton.isHidden = true
        tableView.reloadData()
        cnt.people = people
        cnt.setup()
        cnt.isHidden = false
    }
    
    func setupPicker() {
        cnt = PeopleSelectorView.loadFromNib()
        view.addSubview(cnt)
        cnt.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cnt.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cnt.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        cnt.people = people
        cnt.selectedBlock = {
            selId in
            self.currentPersonId = selId
            self.tableView.reloadData()
        }
        cnt.setup()
    }
    
    func validate() {
        if model.items.filter({ $0.selectedPersonId == nil }).count == 0 {
            scanQRButton.setTitle("Рассчитаться", for: .normal)
            scanQRButton.backgroundColor = UIColor.Color.statusGreen
            scanQRButton.isHidden = false
            cnt.isHidden = true
        } else {
            scanQRButton.setTitle("Сканируй QR код", for: .normal)
            scanQRButton.backgroundColor = UIColor.Color.darkBlue
            scanQRButton.isHidden = true
            cnt.isHidden = false
        }
    }
}



extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 55
        case 1:
            return 55
        case 2:
            return 0
        default:
           return 0
        }
        
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 2 else {
            return nil
        }
        let f = UIView.init(frame: .zero)
        f.backgroundColor = UIColor.Color.backgroundGray
        return f
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == 2 else {
            return 0.0
        }
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? GroupSectionView
        var tit = ""
        switch section {
        case 0:
            tit = "ПОЗИЦИИ ЧЕКА"
        case 1:
            tit = "\(currentPersonId == 0 ? "Мои позииции" : people[currentPersonId].phone)"
        case 2:
            tit = "Действия"
        default:
            tit = ""
        }
        
        header?.headerTitle.text = tit
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 {
            delegate?.didTapAddItem()
        }
        
        if indexPath.section == 1 {
            let el = model.items.first(where: { return
                $0.title == model.items.filter({ $0.selectedPersonId == currentPersonId })[indexPath.row].title
                && $0.selectedPersonId == currentPersonId
            })
            el?.selectedPersonId = nil
        } else {
            model.items[indexPath.row].selectedPersonId = currentPersonId
        }
        
        tableView.reloadData()
        validate()
        
    }
}

extension ItemsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return model.items.count
        case 1:
            return model.items.filter({ $0.selectedPersonId ?? -999 == currentPersonId }).count
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Последняя ячейка для добавить
        if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: addCellID, for: indexPath)
                as? AddItemCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemCellID, for: indexPath)
            as? ItemCell else { return UITableViewCell() }
        var item = model.items[indexPath.row]
        
        if indexPath.section == 1 {
            item = model.items.filter({ $0.selectedPersonId ?? -999 == currentPersonId })[indexPath.row]
        }
        
        cell.fill(item: item, people: people)
        return cell
    }
    
}

extension ItemsViewController: QRCodeScanViewControllerDelegate {
    func didScanQRCode(rawString: String) {
        qrCodeRawString = rawString
        obtainCheckData()
    }
}

extension UIViewController {
    func takeScreenshot() -> UIImage? {
        var screenshotImage: UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
}
