//
//  ToolBarCollectionViewCell.swift
//  Drawer
//
//  Created by Alexander Rubtsov on 24.07.2021.
//

import UIKit

class ToolBarCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
