//
//  MainTableViewCell.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/26/22.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let reuseID = "MainTableViewCell"
    
    private let myLabel = UILabel()

    // MARK: - Initializer -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Metods -

    private func configure() {
        myLabel.font = .systemFont(ofSize: 26, weight: .regular)
        backgroundColor = UIColor.white
        myLabel.textAlignment = .center

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOffset = CGSize(width: 0.9, height: 0.9)
        contentView.layer.shadowOpacity = 0.9
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = UIColor.white
        selectionStyle = .none
    }

    private func configureConstraints() {
        contentView.addSubview(myLabel)

        myLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalToSuperview().multipliedBy(1)
        }
    }

    override func prepareForReuse() {
        self.myLabel.text = nil
        self.accessoryType = .none
    }

    func setText(with text: String) {
        myLabel.text = text
    }
}
