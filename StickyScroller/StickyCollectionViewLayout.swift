//
//  StickyCollectionViewLayout.swift
//  StickyScroller
//
//  Created by stevenedds on 1/23/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit

class StickyCustomCollectionViewLayout: UICollectionViewLayout {
  
  var barHeight: CGFloat {
    return UINavigationController().navigationBar.frame.size.height + UIApplication.sharedApplication().statusBarFrame.height
  }
  
  var screenWidth: CGFloat {
    return UIScreen.mainScreen().bounds.width
  }
  
  
  let numberOfSections = 6
  let numberOfColumns = 8
  var itemAttributes : NSMutableArray!
  var itemsSize : NSMutableArray!
  var contentSize : CGSize!
  
  override func prepareLayout() {
    // checks for required data
    if collectionView?.numberOfSections() == 0 {
      return
    }
    
    // if item attributes are calculated, then just stick the columns
    
    
    // if item attributes aren't calculated, calculate them
    if itemsSize == nil || itemsSize.count != numberOfColumns {
      calculateAllItemsSize()
    }
    
    // set all values
    var column = 0
    var xOffset : CGFloat = 0
    var yOffset : CGFloat = 0
    var contentWidth : CGFloat = 0
    var contentHeight : CGFloat = 0
    var indexCount = 0
    
    // loop through every section
    for section in 0..<collectionView!.numberOfSections() {
      let sectionAttributes = NSMutableArray()
      
      var itemSize = CGSize()
      var indexPath = NSIndexPath()
      
      // while looping through every column
      for index in 0..<numberOfColumns {
        
        if section == collectionView!.numberOfSections()-1 {
          
          if index == 0 {
            itemSize = everyItemSize[numberOfColumns * (collectionView!.numberOfSections()-1)].CGSizeValue()
            ++indexCount
            indexPath = NSIndexPath(forItem: 0, inSection: section)
          } else {
            break
          }
        } else {
          
          itemSize = everyItemSize[indexCount].CGSizeValue()
          ++indexCount
          indexPath = NSIndexPath(forItem: index, inSection: section)
          
        }
        
        // We create the UICollectionViewLayoutAttributes object for each item and add it to our array.
        // We will use this later in layoutAttributesForItemAtIndexPath:
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height))
        if section == 0 && index == 0 {
          attributes.zIndex = 1024  // Set this value for the first item (Sec0Row0) in order to make it visible over first column and first row
        } else if section == 0 || index == 0 {
          attributes.zIndex = 1023  // Set this value for the first row or section in order to set visible over the rest of the items
        }
        
        
        if section == 0 {
          var frame = attributes.frame
          frame.origin.y = collectionView!.contentOffset.y + barHeight
          attributes.frame = frame  // Stick to the top
        }
        if index == 0 {
          var frame = attributes.frame
          frame.origin.x = collectionView!.contentOffset.x
          attributes.frame = frame  // Stick to the left
        }
        
        
        sectionAttributes.addObject(attributes)
        
        xOffset += itemSize.width + 2 // sets x spacer
        column++
        
        // create a new row if this is the last column
        if column == numberOfColumns {
          if xOffset > contentWidth {
            contentWidth = xOffset
          }
          
          // reset all values back to zero
          
          column = 0
          xOffset = 0
          yOffset += itemSize.height + 1 // sets y spacer
        }
      }
      if itemAttributes == nil {
        itemAttributes = NSMutableArray(capacity: collectionView!.numberOfSections())
      }
      itemAttributes .addObject(sectionAttributes)
    }
    
    
    let attributes = itemAttributes.lastObject?.lastObject as! UICollectionViewLayoutAttributes
    contentHeight = attributes.frame.origin.y + attributes.frame.size.height
    contentSize = CGSizeMake(contentWidth, contentHeight)
  }
  
  // returns the contentSize when the view layout requires it:
  override func collectionViewContentSize() -> CGSize {
    return contentSize
  }
  
  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> (UICollectionViewLayoutAttributes!) {
    return itemAttributes[indexPath.section][indexPath.row] as! UICollectionViewLayoutAttributes
  }
  
  
  // lays out visable items -- returns layout attributes
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var attributes = [UICollectionViewLayoutAttributes]()
    if itemAttributes != nil {
      for section in itemAttributes {
        let filteredArray  =  section.filteredArrayUsingPredicate(
          
          NSPredicate(block: { (evaluatedObject, bindings) -> Bool in
            return CGRectIntersectsRect(rect, evaluatedObject.frame)
          })
          ) as! [UICollectionViewLayoutAttributes]
        
        
        attributes.appendContentsOf(filteredArray)
      }
    }
    return attributes
  }
  
  
  // reloads prepare layout when scrolling -- to stick the headers
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }
  
  
  
  
  func sizeForEveryItemWithSectionIndex(sectionIndex: Int, columnIndex: Int) -> CGSize {
    
    
    var text : String = ""
    switch (columnIndex) {
    case 0:
      text = "Long Sticky Column"
    case 1:
      text = "Shorter Column"
    case 2:
      text = "Short Column"
    case 3:
      text = "0000"
    case 4:
      text = "0000"
    case 5:
      text = "0000"
    case 6:
      text = "0000"
    default:
      text = "0000"
    }
    let size : CGSize = (text as NSString).sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(17.0)])
    let width : CGFloat = size.width + 25
    
    if sectionIndex == 0 && columnIndex == 0 {
      return CGSizeMake(width, 30)
    } else if sectionIndex == numberOfSections-1 {
      return CGSizeMake(screenWidth, 30)
    } else if sectionIndex == 0 {
      return CGSizeMake(width, 30)
    } else if columnIndex == 0 {
      return CGSizeMake(width, 45)
    }else {
      return CGSizeMake(width, 45)
    }
  }
  
  var everyItemSize = NSMutableArray()
  
  func calculateAllItemsSize() {
    everyItemSize = NSMutableArray(capacity: numberOfColumns * numberOfSections)
    for section in 0..<numberOfSections {
      if section == numberOfSections-1 {
        everyItemSize.addObject(NSValue(CGSize: sizeForEveryItemWithSectionIndex(section, columnIndex: 0)))
      } else {
        for index in 0..<numberOfColumns {
          
          everyItemSize.addObject(NSValue(CGSize: sizeForEveryItemWithSectionIndex(section, columnIndex: index)))
        }
      }
    }
  }
}