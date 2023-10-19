//
//  IntroductionCell.swift
//  Project-Test
//
//  Created by MNC Insurance 1 on 18/10/23.
//

import UIKit

class IntroductionCell: UITableViewCell {
  
  @IBOutlet weak var greetingLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setupGreetingLabel(){
    let currentTime = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH.mm"
    let currentTimeString = dateFormatter.string(from: currentTime)
    let currentTimeDouble = Double(currentTimeString) ?? 0.0
    
    let morningStart = 5.00
    let morningEnd = 12.00
    let afternoonStart = 12.01
    let afternoonEnd = 18.00
    let nightStart = 18.01
    let nightEnd = 4.99
    
    var greeting = ""
    if currentTimeDouble >= morningStart && currentTimeDouble <= morningEnd {
      greeting = "Good Morning"
    } else if currentTimeDouble > afternoonStart && currentTimeDouble <= afternoonEnd {
      greeting = "Good Afternoon"
    } else if (currentTimeDouble >= nightStart && currentTimeDouble <= 24.0) || (currentTimeDouble >= 0.0 && currentTimeDouble < nightEnd) {
      greeting = "Good Evening"
    }
    
    greetingLabel.text = "\(greeting),\nDionisius Ario Nugroho"
  }
  
}
