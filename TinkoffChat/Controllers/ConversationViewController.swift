//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 06.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var conversationTableView: UITableView!
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMessages()
        
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
        
        conversationTableView.rowHeight = UITableViewAutomaticDimension
        conversationTableView.estimatedRowHeight = 44
    }
    
    func setUpMessages() {
        messages.append(Message(text: "Hi!", incoming: true))
        messages.append(Message(text: "As a side note, it would APPEAR that they are using at least revision 35.  After some sleuthing, it responds correctly to the “r” formatter, which did not appear until revision 35.  I don’t think there is much different for the Gregorian calendar though, so for now, I will write this assuming they are still using revision 31 at tr35-31.", incoming: true))
        messages.append(Message(text: "The character patterns used in these format strings are based on the Unicode Technical Standard #35.  Apple’s documentation for date formatting strings (available at Data Formatting Guide: Date Formatters) lists off which revision of the standard is used for each iOS and OS X version up to OS X 10.9 and iOS 7.  As of the original publishing date of this article, it does not seem to be updated for Yosemite and iOS 8 yet, but iOS 7 used revision 31.   The Unicode Technical Standard #35 at this time is in revision 37, released on September 17, 2014.  As of April 26, 2016, the list here still does not include Yosemite, iOS8, El Capitan, or iOS9.  I’m going to assume for now that it still is working with tr35-31. To be honest, I’ve pretty much only used the built-in NSDateFormatterStyles in what I’ve worked on, they did what I needed.  However, if you do want to do something different, you can write your own custom format string.  ", incoming: true))
        
        messages.append(Message(text: "Hi!", incoming: false))
        messages.append(Message(text: "Now, there is one issue with using the fixed format style of custom formats.  The reason they are called “fixed formats”, is because they print out exactly what you say, in the same order.  That’s all well and good in your locale and calendar system, but (especially with the short date style) 06/02/2014 and 02/06/2014 are very different dates.  One is the day Swift was released, the other is Rick Astley’s 48th birthday.", incoming: false))
        messages.append(Message(text: "Much like how NSDateComponents made it a lot easier to work with NSDates in your Swift code, with setting the individual components directly, NSDateFormatter gives you a lot of power in how you want an NSDate to appear to your Swift app’s users.  There is even more power than what I showed here, but I felt that the chart would be big enough without including less used components like the quarter or theISO Week Date style of years.  Nonetheless though, you can check those out at the Unicode Standard to get the rest of the values if you need them for your instance of NSDateFormatter. I hope you found this article helpful.  If you did, please don’t hesitate to share this post on Twitter or your social media of choice, every share helps.  Of course, if you have any questions, don’t hesitate to contact me on the Contact Page, or on Twitter @CodingExplorer, and I’ll see what I can do.  Thanks!", incoming: false))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MessageTableViewCell
        let indentifier = "MessageCell"
        
        if let messageCell = tableView.dequeueReusableCell(withIdentifier: indentifier) as? MessageTableViewCell {
            cell = messageCell
        } else {
            cell = MessageTableViewCell(style: .default, reuseIdentifier: indentifier)
        }
        
        cell.configure(message: messages[indexPath.row])
        
        return cell
    }
}
