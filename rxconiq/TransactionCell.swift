//
//  TransactionCell.swift
//  rxconiq
//
//  Created by Boska on 2019/2/18.
//  Copyright © 2019 boska. All rights reserved.
//

import UIKit
import Cartography

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
