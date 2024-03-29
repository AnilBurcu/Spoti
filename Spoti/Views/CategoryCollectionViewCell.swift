//
//  GenresCollectionViewCell.swift
//  Spoti
//
//  Created by Anıl Bürcü on 20.09.2023.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GenresCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "person",withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
        
    }()
    
    private let colors:[UIColor] = [
        .systemRed,
        .systemBlue,
        .systemGreen,
        .systemCyan,
        .systemGray,
        .systemBrown,
        .systemPink,
        .systemOrange]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(systemName: "music.quarternote.3",withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width-20, height: contentView.height/2)
        
        imageView.frame = contentView.bounds
//        imageView.frame = CGRect(x: contentView.width/2, y: 10, width: contentView.width/2, height: contentView.height/2)
        
    }
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel){
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artworkURL,completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
}
