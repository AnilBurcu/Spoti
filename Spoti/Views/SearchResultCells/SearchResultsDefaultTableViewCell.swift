//
//  SearchResultsDefaultTableViewCell.swift
//  Spoti
//
//  Created by Anıl Bürcü on 21.09.2023.
//

import UIKit
import SDWebImage



class SearchResultsDefaultTableViewCell: UITableViewCell {

    static let identifier = "SearchResultsDefaultTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private let image: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(image)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize:CGFloat = contentView.height-10
        image.frame = CGRect(x: 10, y: contentView.height/2-imageSize/2, width: imageSize, height: imageSize)
        image.layer.cornerRadius = imageSize/2
        image.layer.masksToBounds = true
        label.frame = CGRect(x: image.right+10, y: 0, width: contentView.width-image.right-15, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        label.text = nil
    }
    
    func configure(with viewModel:SearchResultsDefaultTableViewCellViewModel){
        label.text = viewModel.title
        image.sd_setImage(with: viewModel.imageURL)
    }
    
    
}
