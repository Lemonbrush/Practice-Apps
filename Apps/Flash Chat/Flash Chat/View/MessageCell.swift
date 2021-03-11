//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Александр on 01.03.2021.
//

import UIKit

enum MessageStyle {
    case userMessage
    case interlocatorMessage
}

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftFillerView: UIView!
    @IBOutlet weak var rightFillerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 2.7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setMessageStyle(with style: MessageStyle) {
        
        switch style {
        case .userMessage:
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            label.textColor = UIColor(named: K.BrandColors.purple)
            leftFillerView.isHidden = false
            rightFillerView.isHidden = true
            
        case .interlocatorMessage:
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            label.textColor = UIColor(named: K.BrandColors.lightPurple)
            leftFillerView.isHidden = true
            rightFillerView.isHidden = false
        }
    }
    
}
