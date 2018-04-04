//
//  KCOtherMainViewController.swift
//  CoreKnowledge
//
//  Created by haoyongxin on 2018/3/8.
//  Copyright © 2018年 xinrui. All rights reserved.
//

import UIKit

class KCOtherMainViewController: UIViewController {
  var collectionView: UICollectionView!
  var dataSource = Array<KCOtherModel>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    installOtherModel()
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.scrollDirection = .vertical
    collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.white
    collectionView.delegate = self
    collectionView.dataSource = self
    self.view.addSubview(collectionView)
    collectionView.register(KCOtherCell.self, forCellWithReuseIdentifier: "cellIdentifier")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

extension KCOtherMainViewController {
  func installOtherModel() {
    dataSource = KCModelCreator.sharedInstall.otherModels()
  }
}

extension KCOtherMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! KCOtherCell
    cell.setOtherModel(model: dataSource[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width / 2, height: (self.view.frame.width / 2) * 0.6)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let otherModel = dataSource[indexPath.item]
    switch otherModel.type {
    case .AudioPlayback:
      let audioPlaybackVC = AudioPlaybackViewController()
      self.navigationController?.pushViewController(audioPlaybackVC, animated: true)
      break
    default:
      break
    }
  }
  
}
