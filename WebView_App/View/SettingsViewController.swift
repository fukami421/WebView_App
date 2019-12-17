//
//  SettingsViewController.swift
//  WebView_App
//
//  Created by 深見龍一 on 2019/12/11.
//  Copyright © 2019 深見龍一. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var disposeBag = DisposeBag()
    private var viewModel: SettingsViewModel!

    // データソースを指定する
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(configureCell: configureCell)
    
    // TableViewCellはこれ
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SettingsSectionModel>.ConfigureCell = {
        [weak self] (dataSource, tableView, indexPath, _) in
        let item = dataSource[indexPath]
        switch item {
        case .description(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = text
            cell.isUserInteractionEnabled = false
            return cell
        default:
            let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")! as! TableViewCell

//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.accessoryType = item.accessoryType
            return cell
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNav()
        self.setupTableView()
        self.setupViewModel()
    }
    
    private func setUpNav() {
        self.title = "設定"
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.backgroundColor = .white
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        // セル選択時の処理はここに書ける
        tableView.rx.itemSelected.subscribe(onNext: {
            [weak self] indexPath in
            guard let item = self?.dataSource[indexPath] else { return }
            self?.tableView.deselectRow(at: indexPath, animated: true)
            
            switch item {
            case .account:
                // 繊維させる処理(省略のためbreak)
                break
            default:
                break
                
            }
        })
        .disposed(by: disposeBag)
        
    }
    
    private func setupViewModel() {
        self.viewModel = SettingsViewModel()
        
        self.viewModel.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        self.viewModel.updateItems()
    }


}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeihgt
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        if section == 0
        {
            headerView.backgroundColor = .gray
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .gray
        return footerView
    }
}
