//
//  ViewController.swift
//  rxconiq
//
//  Created by Boska on 2019/1/17.
//  Copyright © 2019 boska. All rights reserved.
//
/*
 db   db d88888b db      db       .d88b.
 88   88 88'     88      88      .8P  Y8.
 88ooo88 88ooooo 88      88      88    88
 88~~~88 88~~~~~ 88      88      88    88
 88   88 88.     88booo. 88booo. `8b  d8'
 YP   YP Y88888P Y88888P Y88888P  `Y88P'
 
 d8888b.  .d8b.  db    db  .o88b.  .d88b.  d8b   db d888888b  .d88b.
 88  `8D d8' `8b `8b  d8' d8P  Y8 .8P  Y8. 888o  88   `88'   .8P  Y8.
 88oodD' 88ooo88  `8bd8'  8P      88    88 88V8o 88    88    88    88
 88~~~   88~~~88    88    8b      88    88 88 V8o88    88    88    88
 88      88   88    88    Y8b  d8 `8b  d8' 88  V888   .88.   `8P  d8'
 88      YP   YP    YP     `Y88P'  `Y88P'  VP   V8P Y888888P  `Y88'Y8
*/

import UIKit
import RxAlamofire
import RxSwift
import RxCocoa

class TransactionsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var disposeBag = DisposeBag()
  let viewModel = TransactionsTableViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = nil

    viewModel.items
      .asObservable()
      .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: TransactionCell.self)) { (_, data, cell) in
        cell.configure(data: data)
      }.disposed(by: disposeBag)

    tableView.rx.modelSelected(Transaction.self)
      .subscribe {
        print($0)
        self.performSegue(withIdentifier: "user", sender: nil)
      }.disposed(by: disposeBag)

    tableView.rx.contentOffset
      .filter { $0.y >= self.tableView.contentSize.height - self.tableView.frame.size.height }
      .skipWhile { _ in self.viewModel.items.value.isEmpty }
      .debounce(0.5, scheduler: MainScheduler.instance)
      .map { _ in true }
      .bind(to: viewModel.loadNextPage)
      .disposed(by: disposeBag)
  }
}

extension TransactionsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

class TransactionCell: UITableViewCell {
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  func configure(data: Transaction) {
    descriptionLabel.text = data.description
    amountLabel.text = "€ \(data.amount)"
  }
}
