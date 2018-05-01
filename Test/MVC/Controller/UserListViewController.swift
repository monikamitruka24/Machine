//
//  UserListViewController.swift
//  Test
//
//  Created by MACMINI_CBL on 5/1/18.
//  Copyright © 2018 Monika. All rights reserved.
//

import UIKit
import ESPullToRefresh

class UserListViewController: UIViewController {
    
    //MARK:- outlet
    @IBOutlet var tableView: UITableView!
    
    
    //MARK:- variable
    var pageNo = 1
    var arrUsers : [UserList] = []
    var loadMore = true
    var tableViewDataSource : TableViewCustomDatasource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                 handlePagination()
        apiUserList()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func apiUserList() {
        APIConstants.usersList = "users?page=\(pageNo)"
        APIManager.shared.request(with: HomeEndpoint.usersList()) { (response) in
            switch response{
            case .success(let response):
                guard let data = response as? UserListData else { return }
                for item in data.arrUserList {
                    self.arrUsers.append(item)
                }
                self.loadMore = data.arrUserList.count == 3
                
                self.pageNo = self.pageNo + 1
                if self.arrUsers.count > 0 {
                    self.configureTableView()
                    self.tableView.isHidden = false
                }else {
                    self.tableView.isHidden = true
                }
                                self.tableView?.es.stopLoadingMore()
                                self.loadMore ? self.tableView?.es.resetNoMoreData() : self.tableView?.es.noticeNoMoreData()
                
            case .failure(let str):
                Alerts.shared.show(alert: .oops, message: str as? String ?? "" , type: .error)
            }
        }
    }
    
    
}
//MARK:- table view configuration
extension UserListViewController {
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrUsers , height: UITableViewAutomaticDimension, estimatedHeight: 96, tableView: tableView, cellIdentifier: CellIdentifiers.UserListTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? UserListTableViewCell
            cell?.configureCell(model : self.arrUsers[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
                guard let vc = R.storyboard.main.userDetailViewController() else { return }
                vc.userObj = self.arrUsers[indexPath.row]
                vc.index = indexPath.row
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
        }, willDisplayCell: { (indexPath) in
        })
        
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.reloadData()
    }
    
    
    
}
extension UserListViewController : UserDetailProtocol {
    func sendImageUrl(index : Int,url : String) {
        arrUsers[index].avatar = url
        configureTableView()
    }
}
extension UserListViewController   {
        func resetNoMoreData(){
            self.tableView?.es.resetNoMoreData()
        }
    
        func foundNoMoreData(){
            self.tableView.es.stopLoadingMore()
            self.tableView.es.noticeNoMoreData()
        }
    
        func handlePagination(){
            let _ = tableView.es.addInfiniteScrolling { [unowned self] in
                if self.loadMore {
                    self.apiUserList()
                }else{
                    self.foundNoMoreData()
                }
    
            }
        }
    
}
