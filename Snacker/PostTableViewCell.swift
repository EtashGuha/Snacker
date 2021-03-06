//
//  PostTableViewCell.swift
//  Snacker
//
//  Created by Etash Guha on 12/14/18.
//  Copyright © 2018 Etash Guha. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var foodPic: UIImage!
    var nameFood: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var messageView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 35)
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(mainImageView)
        self.addSubview(messageView)
        
        messageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.mainImageView.topAnchor).isActive = true
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = nameFood {
            messageView.text = message
        }
        
        if let image = foodPic  {
            mainImageView.image = foodPic
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init decoder has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
