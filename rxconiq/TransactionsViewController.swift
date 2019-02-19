//
//  ViewController.swift
//  rxconiq
//
//  Created by Boska on 2019/1/17.
//  Copyright © 2019 boska. All rights reserved.
//

import UIKit
import RxSwift

final class TransactionsViewController: UIViewController {
  private let tableView = UITableView()
  private var disposeBag = DisposeBag()
  private let viewModel: TransactionsViewModel
  
  init(viewModel: TransactionsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.title = "Transactions"
    tableView.translatesAutoresizingMaskIntoConstraints = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    self.view = tableView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = nil
    tableView.register(TransactionCell.self, forCellReuseIdentifier: "Cell")
    
    viewModel.items
      .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: TransactionCell.self)) { (_, data, cell) in
        cell.configure(data: data)
      }.disposed(by: disposeBag)
    
    tableView.rx.modelSelected(Transaction.self)
      .subscribe (onNext: {
        TinyRouter.shared.navigate(to: $0)
      }).disposed(by: disposeBag)
    
    tableView.rx.contentOffset
      .filter({ [tableView] offset in
        tableView.contentSize.height > 0 && offset.y >= tableView.contentSize.height - tableView.frame.size.height })
      .map({ _ in true })
      .bind(to: viewModel.loadNextPage)
      .disposed(by: disposeBag)
    
  }
}

extension TransactionsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
