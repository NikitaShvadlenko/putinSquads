//
//  putinSquadCell.swift
//  putinSquads
//
//  Created by Nikita Shvad on 13.07.2021.
//

import UIKit

class PutinSquadCell: UITableViewCell {
    private let label = UILabel()
    private let image = UIImageView()
    
    //Инициализация класса - просто нужно запомнить этот кусок кода.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - public methods

extension PutinSquadCell{
    func configure(title: String, picture: String) {
        label.text = title
        image.image = UIImage(systemName: picture)
        image.tintColor = .black
    }
}

//MARK: - private methods
extension PutinSquadCell{
    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.lineBreakMode = .byClipping
        label.font = UIFont.boldSystemFont(ofSize: 30)
        
        let labelConstraints = [
            NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: image, attribute: .right, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: image, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: image, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        //Хочу добавить картинку слева от Label
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let imageConstratints = [
            NSLayoutConstraint(item: image, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        ]
        NSLayoutConstraint.activate(imageConstratints)
    }
}
