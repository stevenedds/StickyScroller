//
//  StickyCollectionViewController.swift
//  StickyScroller
//
//  Created by stevenedds on 1/23/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit

class StickyCollectionViewController: UICollectionViewController {

  let nameCellID = "NameCellIdentifier"
  
  let darkGray = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
  let lightGray = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1)
  let backgroundColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView! .registerNib(UINib(nibName: "NameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: nameCellID)
    collectionView!.backgroundColor = backgroundColor

  }
  
  // MARK: UICollectionViewDataSource
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 6
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    
      // Sticker Headers in First Row
    case 0:
      
      switch indexPath.row {
    case 0:
      let nameCell = collectionView .dequeueReusableCellWithReuseIdentifier(nameCellID, forIndexPath: indexPath) as! NameCollectionViewCell
      nameCell.backgroundColor = darkGray
      nameCell.nameLabel.font = UIFont.systemFontOfSize(16)
      nameCell.nameLabel.textColor = lightGray
      nameCell.nameLabel.text = "Long Sticky Column"
      
      return nameCell
    case 1:
      let nameCell = collectionView .dequeueReusableCellWithReuseIdentifier(nameCellID, forIndexPath: indexPath) as! NameCollectionViewCell
      nameCell.backgroundColor = darkGray
      nameCell.nameLabel.font = UIFont.systemFontOfSize(16)
      nameCell.nameLabel.textColor = lightGray
      nameCell.nameLabel.text = "Shorter Column"
      
      return nameCell

    case 2:
      let nameCell = collectionView .dequeueReusableCellWithReuseIdentifier(nameCellID, forIndexPath: indexPath) as! NameCollectionViewCell
      nameCell.backgroundColor = darkGray
      nameCell.nameLabel.font = UIFont.systemFontOfSize(16)
      nameCell.nameLabel.textColor = lightGray
      nameCell.nameLabel.text = "Short Column"
      
      return nameCell

    default:
      let nameCell = collectionView .dequeueReusableCellWithReuseIdentifier(nameCellID, forIndexPath: indexPath) as! NameCollectionViewCell
      nameCell.backgroundColor = darkGray
      nameCell.nameLabel.font = UIFont.systemFontOfSize(16)
      nameCell.nameLabel.textColor = lightGray
      nameCell.nameLabel.text = "Test"
      
      return nameCell
      }
      
    case 0:
      let nameCell = collectionView .dequeueReusableCellWithReuseIdentifier(nameCellID, forIndexPath: indexPath) as! NameCollectionViewCell
      nameCell.backgroundColor = darkGray
      nameCell.nameLabel.font = UIFont.systemFontOfSize(16)
      nameCell.nameLabel.textColor = lightGray
      nameCell.nameLabel.text = "Sticky"
      
      return nameCell

    case 5:
      let nameCell = collectionView .dequeueReusableCellWithReuseIdentifier(nameCellID, forIndexPath: indexPath) as! NameCollectionViewCell
      nameCell.backgroundColor = darkGray
      nameCell.nameLabel.font = UIFont.systemFontOfSize(16)
      nameCell.nameLabel.textColor = lightGray
      nameCell.nameLabel.text = "Stuck"
      
      return nameCell
    default:
      let nameCell = collectionView .dequeueReusableCellWithReuseIdentifier(nameCellID, forIndexPath: indexPath) as! NameCollectionViewCell
      nameCell.backgroundColor = darkGray
      nameCell.nameLabel.font = UIFont.systemFontOfSize(16)
      nameCell.nameLabel.textColor = lightGray
      nameCell.nameLabel.text = "000"
      
      return nameCell
    }
  }
}
