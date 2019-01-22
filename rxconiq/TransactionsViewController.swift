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
import Cartography

class TransactionsViewController: UIViewController {
  let tableView = UITableView()
  var disposeBag = DisposeBag()
  let viewModel: TransactionsViewModel


  init(viewModel: TransactionsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.title = "Transactions"
    setupConstraints()

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
      .asDriver().drive(tableView.rx.items(cellIdentifier: "Cell", cellType: TransactionCell.self)) { (_, data, cell) in
        cell.configure(data: data)
      }.disposed(by: disposeBag)

    tableView.rx.modelSelected(Transaction.self)
      .subscribe {
      }.disposed(by: disposeBag)

    tableView.rx.contentOffset
      .filter { $0.y >= self.tableView.contentSize.height - self.tableView.frame.size.height }
      .skip(2)
      .debounce(0.5, scheduler: MainScheduler.instance)
      .map { _ in true }
      .bind(to: viewModel.loadNextPage)
      .disposed(by: disposeBag)

  }
  func setupConstraints() {

  }
}

extension TransactionsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

class TransactionCell: UITableViewCell {
  let descriptionLabel: UILabel
  let amountLabel: UILabel

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    self.descriptionLabel = UILabel()
    self.amountLabel = UILabel()

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.addSubview(descriptionLabel)
    self.addSubview(amountLabel)
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupConstraints() {
    constrain(descriptionLabel, amountLabel, self) { descriptionLabel, amountLabel, view in
      descriptionLabel.top == view.top + 16
      descriptionLabel.left == view.left + 16
      descriptionLabel.bottom == view.bottom - 16
      descriptionLabel.right == amountLabel.left
      amountLabel.top == view.top + 16
      amountLabel.right == view.right - 16
      amountLabel.bottom == view.bottom - 16
    }
  }

  func configure(data: Transaction) {
    descriptionLabel.text = data.description
    amountLabel.text = "€ \(data.amount)"
  }
}
