//
//  HistoricTableViewCell.swift
//  FreeLife
//
//  Created by ihan carlos on 08/12/23.
//

import UIKit

class HistoricTableViewCell: UITableViewCell {
    
    static let identifier: String = "HistoricTableViewCell"
    
    lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Data: 00/00/00"
        label.font = .dsFonts(.subText)
        label.textColor = .black
        return label
    }()
    
    lazy var paymentLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pagamento: R$ 00,00"
        label.font = .dsFonts(.subText)
        label.textColor = .black
        return label
    }()
    
    lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 00,00"
        label.font = .dsFonts(.subText)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoricTableViewCell: ViewCodeType {
    func buildViewHierarchy() {
        addSubview(dateLabel)
        addSubview(paymentLabel)
        addSubview(priceLabel)
    }
    
    func setupConstraints() {
        dateLabel.anchor(
            top: topAnchor,
            left: leftAnchor,
            leftConstant: 20
        )
        
        paymentLabel.anchor(
            top: dateLabel.bottomAnchor,
            left: dateLabel.leftAnchor
        )
        
        priceLabel.anchor(
            right: rightAnchor,
            centerY: dateLabel.centerYAnchor,
            rightConstant: 20
        )
    }
}
