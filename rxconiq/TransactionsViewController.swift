//
//  ViewController.swift
//  rxconiq
//
//  Created by Boska on 2019/1/17.
//  Copyright © 2019 boska. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift
import RxCocoa
import Cartography

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
      .asDriver().drive(tableView.rx.items(cellIdentifier: "Cell", cellType: TransactionCell.self)) { (_, data, cell) in
        cell.configure(data: data)
      }.disposed(by: disposeBag)

    tableView.rx.modelSelected(Transaction.self)
      .debug("🔍")
      .subscribe (onNext: {
        TinyRouter.shared.navigate(to: $0)
      }).disposed(by: disposeBag)

    tableView.rx.contentOffset
      .filter { $0.y >= self.tableView.contentSize.height - self.tableView.frame.size.height }
      .skip(2)
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

final class TransactionCell: UITableViewCell {
  private let descriptionLabel: UILabel
  private let amountLabel: UILabel

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

  private func setupConstraints() {
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
    amountLabel.textColor = data.amount.hasPrefix("-") ? .red : .black
  }
}
