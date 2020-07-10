//
//  PostCell.swift
//  OmniExperience
//
//  Created by Yalan Bravo Olvera on 09/07/20.
//  Copyright © 2020 Yalan Bravo. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    var wrapperView = UIView()
    var introLabel = UILabel()
    var titleLabel = UILabel()
    var thumbnailImageView = UIImageView()
    var separatorView = UIView()
    
    var postData : Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(withPost post: Post){
        self.postData = post
        self.configureViews()
        //Set data
        self.introLabel.text = self.postData.author + " • " + "2 hours ago"
        self.titleLabel.text = self.postData.title
    }
    
    func configureViews(){
        self.selectionStyle = .none
        self.backgroundColor = Constants.colorLightGray
        
        //Wrapper
        self.addSubview(self.wrapperView)
        self.wrapperView.translatesAutoresizingMaskIntoConstraints = false
        self.wrapperView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.wrapperView.backgroundColor = UIColor.white
        
        //Author
        self.wrapperView.addSubview(self.introLabel)
        self.introLabel.translatesAutoresizingMaskIntoConstraints = false
        self.introLabel.topAnchor.constraint(equalTo: self.wrapperView.topAnchor, constant: 16).isActive = true
        self.introLabel.leadingAnchor.constraint(equalTo: self.wrapperView.leadingAnchor, constant: 16).isActive = true
        self.introLabel.trailingAnchor.constraint(equalTo: self.wrapperView.trailingAnchor, constant: -16).isActive = true
        
        self.introLabel.font = UIFont.systemFont(ofSize: 12)
        self.introLabel.textColor = Constants.colorGray
        
        //Thumbnail
        self.addSubview(self.thumbnailImageView)
        self.thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnailImageView.topAnchor.constraint(equalTo: self.introLabel.bottomAnchor, constant: 8).isActive = true
        self.thumbnailImageView.leadingAnchor.constraint(equalTo: self.wrapperView.leadingAnchor, constant: 16).isActive = true
        
        var thumbnailHeight : CGFloat = 0.0
        var thumbnailWidth : CGFloat = 0.0
        if self.postData.thumbnail != nil && self.postData.thumbnail != "default"  {
            thumbnailHeight = 60.0
            thumbnailWidth = 80.0
            self.thumbnailImageView.downloaded(from: self.postData.thumbnail!, contentMode: .scaleAspectFill)
        }
        
        self.thumbnailImageView.widthAnchor.constraint(equalToConstant: thumbnailWidth).isActive = true
        self.thumbnailImageView.heightAnchor.constraint(equalToConstant: thumbnailHeight).isActive = true
        self.thumbnailImageView.backgroundColor = Constants.colorLightGray
        self.thumbnailImageView.clipsToBounds = true
        self.thumbnailImageView.layer.cornerRadius = 5
        
        
        //Title
        self.wrapperView.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.introLabel.bottomAnchor, constant: 12).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.wrapperView.trailingAnchor, constant: -16).isActive = true
        
        var leadingThumb : CGFloat = 0
        if self.postData.thumbnail != nil && self.postData.thumbnail != "default"  {
            leadingThumb = 16
        }
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.thumbnailImageView.trailingAnchor, constant: leadingThumb).isActive = true
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        self.titleLabel.textColor = Constants.colorBlack
        
        //Separator
        self.wrapperView.addSubview(self.separatorView)
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.separatorView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 32).isActive = true
        self.separatorView.leadingAnchor.constraint(equalTo: self.wrapperView.leadingAnchor).isActive = true
        self.separatorView.trailingAnchor.constraint(equalTo: self.wrapperView.trailingAnchor).isActive = true
        self.separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.separatorView.bottomAnchor.constraint(equalTo: self.wrapperView.bottomAnchor, constant: -50).isActive = true
        
        self.separatorView.backgroundColor = Constants.colorLightGray
                
    }
    
    override func prepareForReuse() {
        self.thumbnailImageView.removeFromSuperview()
        self.wrapperView.removeFromSuperview()
        wrapperView = UIView()
        introLabel = UILabel()
        titleLabel = UILabel()
        thumbnailImageView = UIImageView()
        separatorView = UIView()
    }
    
}
