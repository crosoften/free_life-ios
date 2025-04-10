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
       // label.text = "Data: 00/00/00"
        label.font = .dsFonts(.subText)
        label.textColor = .black
        return label
    }()
    
    lazy var paymentLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.text = "Pagamento: R$ 00,00"
        label.font = .dsFonts(.subText)
        label.textColor = .black
        return label
    }()
    
    lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
      //  label.text = "R$ 00,00"
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
    
    func setupCell(cashback: CashbackModel){
        
        dateLabel.text = "Data: \(formatarData(cashback.date))"
        paymentLabel.text = "Pagamento: R$ \(cashback.value)"
        priceLabel.text = formatCurrency(value: cashback.cashBackValue)
    }
    func formatarData(_ dataString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // garante parsing correto
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0) // se quiser manter horário UTC

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        outputFormatter.timeZone = TimeZone.current // ou .secondsFromGMT(0) se quiser GMT

        if let date = inputFormatter.date(from: dataString) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Define o formato brasileiro
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$" // Define o símbolo da moeda
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "R$0,00"
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
