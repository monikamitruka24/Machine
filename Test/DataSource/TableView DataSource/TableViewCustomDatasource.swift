//
//  TableViewCustomDatasource.swift
//  Test
//
//  Created by Monika on 21/04/18.
//  Copyright © 2018 Monika. All rights reserved.
//

import UIKit

typealias  ListCellConfigureBlock = (_ cell : AnyObject , _ item : AnyObject , _ indexpath: IndexPath) -> ()
typealias  DidSelectedRow = (_ indexPath : IndexPath) -> ()
typealias ViewForHeaderInSection = (_ section : Int) -> UIView?
typealias WillDisplayCell = (_ indexPath : IndexPath) -> ()
typealias ScrollDidScroll = (_ scrollView: UIScrollView) -> ()

class TableViewCustomDatasource: NSObject {
    
    var items : Array<AnyObject>?
    var cellIdentifier : String?
    var tableView  : UITableView?
    var tableViewRowHeight : CGFloat?
    var tableViewEstimatedRowHeight : CGFloat?
    var configureCellBlock : ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    var viewforHeaderInSection : ViewForHeaderInSection?
    var willDisplayCell : WillDisplayCell?
    var headerHeight : CGFloat? = 0.0
    var scrollDidScroll : ScrollDidScroll?
    
    init (items : Array<AnyObject>? , height : CGFloat ,estimatedHeight :CGFloat , tableView : UITableView? , cellIdentifier : String?  , configureCellBlock : ListCellConfigureBlock? , aRowSelectedListener :   DidSelectedRow?,willDisplayCell : WillDisplayCell?,scrollDidScroll : ScrollDidScroll? = nil) {
        
        self.tableView = tableView
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.tableViewRowHeight = height
        self.tableViewEstimatedRowHeight = estimatedHeight
        self.configureCellBlock = configureCellBlock
        self.aRowSelectedListener = aRowSelectedListener
        self.willDisplayCell = willDisplayCell
        self.scrollDidScroll = scrollDidScroll
       // self.tableView?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override init() {
        super.init()
    }
}
extension TableViewCustomDatasource : UITableViewDelegate , UITableViewDataSource{
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if let block = self.configureCellBlock , let item: AnyObject = self.items as AnyObject?{
            block(cell , item , indexPath )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let block = self.willDisplayCell {
            block(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = self.aRowSelectedListener{
            block(indexPath)
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewEstimatedRowHeight!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewRowHeight!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let block = viewforHeaderInSection else { return nil }
        return block(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerHeight ?? 0.0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let block = self.scrollDidScroll{
            block(scrollView)
        }
        
    }
    

}

