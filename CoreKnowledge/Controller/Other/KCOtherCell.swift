//
//  KCOtherCell.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/4/3.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class KCOtherCell: UICollectionViewCell {
  
  var titleLabel: UILabel!
  var image: UIImageView!
  var otherModel: KCOtherModel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.backgroundColor = UIColor.white
    titleLabel = UILabel(frame: CGRect.zero)
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    self.contentView.addSubview(titleLabel)
    
    image = UIImageView(frame: CGRect.zero)
    image.contentMode = .scaleAspectFit
    self.contentView.addSubview(image)
  }
  
  func setOtherModel(model: KCOtherModel) {
    self.otherModel = model
    titleLabel.text = model.title
    guard let imageName = model.imageName else {
      image.isHidden = true
      return
    }
    image.image = UIImage(named: imageName)
  }
  
  override func layoutSubviews() {
    guard let _ = otherModel.imageName else {
      titleLabel.frame = CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height - 20)
      return
    }
    
    titleLabel.frame = CGRect(x: 10, y: frame.height / 2, width: frame.width - 20, height: frame.height / 2 - 10)
    image.frame = CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height / 2 - 10)
  }
  
  override func draw(_ rect: CGRect) {
    let shapeLayer = CAShapeLayer()
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = UIColor.darkGray.cgColor
    shapeLayer.lineWidth = 0.5
    
    let bezPath = UIBezierPath(roundedRect: CGRect.init(x: 5, y: 5, width: rect.width - 10, height: rect.height - 10), cornerRadius: 10)
    shapeLayer.path = bezPath.cgPath
    self.contentView.layer.insertSublayer(shapeLayer, at: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
