//
//  ViewController.swift
//  DreamLister
//
//  Created by Will Carpenter on 8/26/16.
//  Copyright © 2016 SwiftyHacker. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var segment: UISegmentedControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
	}

	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		
		return 0
		
	}
	
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
		
		return UITableViewCell()
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 0
		
	}
	

	

}

