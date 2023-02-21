//
//  ViewController.swift
//  test
//
//  Created by Tilseam on 2023/2/20.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate{

    @IBOutlet weak var parentTableView: NSTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parentTableView.delegate = self
        parentTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

var childViewData = ["111","222","333","444","555","666","777","888","999"]

extension ViewController{
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if tableView.identifier == NSUserInterfaceItemIdentifier(rawValue: "parentTableView"){
            return 200
        }
        
        if tableView.identifier == NSUserInterfaceItemIdentifier(rawValue: "childTableView"){
            return 30
        }
        
        return 0
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return NSTableRowView()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView.identifier == NSUserInterfaceItemIdentifier(rawValue: "parentTableView"){
            return 8
        }
        
        if tableView.identifier == NSUserInterfaceItemIdentifier(rawValue: "childTableView"){
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
       
        if tableView.identifier == NSUserInterfaceItemIdentifier(rawValue: "parentTableView"),
            let parentCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "parentCellView"), owner: self) as? ParentCellView,
           let childTableView = parentCellView.childTableView as? ChildTableView{
            parentCellView.textField?.stringValue = "\(row)"
            childTableView.childTableData = childViewData[row]
            childTableView.delegate = self
            childTableView.dataSource = self
            return parentCellView
        }
        
        if tableView.identifier == NSUserInterfaceItemIdentifier(rawValue: "childTableView"),
           let tableView = tableView as? ChildTableView,
           let childCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "childCellView"), owner: self) as? NSTableCellView{
            childCellView.textField?.stringValue = tableView.childTableData ?? ""
            return childCellView
        }
        return nil
    }
}

class ParentCellView: NSTableCellView{
    
    @IBOutlet weak var childTableView: NSTableView!
    
}


class ChildTableView: NSTableView{
    
    var childTableData: String?
    
}
