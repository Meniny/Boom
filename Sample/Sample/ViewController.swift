//
//  ViewController.swift
//  Sample
//
//  Created by 李二狗 on 2018/6/5.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import UIKit
import Boom

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = #colorLiteral(red:0.79, green:0.80, blue:0.67, alpha:1.00)
        
        self.setupFlow()
    }

    func setupFlow() {
        self.setupAdapter()
        
        self.tableView.manager.add(section: self.generateSection())
        
        self.tableView.manager.rowHeight = .autoLayout(estimated: 100)
        
        self.tableView.manager.reloadData(after: { _ in
            return TableReloadAnimations.default()
        }, onEnd: nil)
    }
    
    func setupAdapter() {
        let adapter = TableAdapter<CellData, ConversationTableViewCell>()
        adapter.on.dequeue = { ctx in
            ctx.cell?.avatarImageView.image = ctx.model.avatar
            ctx.cell?.titleLbale?.text = ctx.model.title
            ctx.cell?.subtitleLabel?.text = ctx.model.detail
        }
        adapter.on.tap = { ctx in
            print("Tapped on \(ctx.model.identifier)")
            return .deselectAnimated
        }
        self.tableView.manager.register(adapter: adapter)
    }
    
    func generateSection() -> TableSection {
        let dataSet = (0..<10).map { i -> CellData in
            return CellData.init(avatar: #imageLiteral(resourceName: "Doggie"), title: "Cell at \(i)", detail: "Boom~")
        }
        
        let header = TableSectionView<TableExampleHeaderView>()
        header.on.height = { _ in
            return 50
        }
        
        let footer = TableSectionView<TableFooterExample>()
        footer.on.height = { _ in
            return 30
        }
        footer.on.dequeue = { ctx in
            ctx.view?.titleLabel?.text = "\(dataSet.count) Data"
        }
        
        return TableSection(headerView: header, footerView: footer, models: dataSet)
    }
}

