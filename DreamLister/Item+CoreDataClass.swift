//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Will Carpenter on 8/26/16.
//  Copyright © 2016 SwiftyHacker. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
	
	public override func awakeFromInsert() {
		
		super.awakeFromInsert()
		
		// Easy way to create time stamp
		self.created = NSDate()
	}

}
