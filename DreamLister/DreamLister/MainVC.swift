//
//  ViewController.swift
//  DreamLister
//
//  Created by Will Carpenter on 8/26/16.
//  Copyright © 2016 SwiftyHacker. All rights reserved.
//

import UIKit
import CoreData


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
	
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var segment: UISegmentedControl!
	
	// help us fetch data rom CoreData
	var controller: NSFetchedResultsController<Item>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		generateTestData()
		attemptFetch()
		
	}

	
	// boilerplate code for the table view
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
		
		configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
		
		return cell
	}
	
	func configureCell(cell: ItemCell, indexPath: NSIndexPath){
		
		let item = controller.object(at: indexPath as IndexPath)
		cell.configureCell(item: item)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		
		if let sections = controller.sections{
			
			let sectionInfo = sections[section]
			return sectionInfo.numberOfObjects
		}
		
		return 0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		if let sections = controller.sections {
			
			return sections.count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return 150
	}
	////////////////////////////////////////////////////////////
	
	func attemptFetch() {
		
		let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
		let dateSort = NSSortDescriptor(key: "created", ascending: false)
		fetchRequest.sortDescriptors = [dateSort]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
		
		self.controller = controller
		
		// Since Fetched Controller can fail, need to have this 'do'
		do {
			
			try controller.performFetch()
			
		}	catch {
			
			let error = error as NSError
			
			print("\(error)")
			
		}
		
	}
	
	// boilerplate code for Core Data  // put in different extension, or parent class so don't have to write this out for every ViewController
	
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.beginUpdates()
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.endUpdates()
	}
	
	// listening for anytime we make a change // insert, delete, move, update
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		
		// switching on type defined ^^^^^ in controller function (for type: NSFetchedResultsChangeType)
		switch type {
		case.insert:
			if let indexPath = newIndexPath{
				tableView.insertRows(at: [indexPath], with: .fade)
			}
			break
			
		case.delete:
			// this is the existing indexPath  since we are deleting the existing one
			if let indexPath = indexPath{
				tableView.deleteRows(at: [indexPath], with: .fade)
			}
		break
			
		case.update:
			if let indexPath = indexPath{
				let cell = tableView.cellForRow(at: indexPath) as! ItemCell
				configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
			}
			break
			
		case.move:
			if let indexPath = indexPath {
				tableView.deleteRows(at: [indexPath], with: .fade)
			}
			if let indexPath = newIndexPath{
				tableView.insertRows(at: [indexPath], with: .fade)
			}
			break
		}
	}
	
	func generateTestData() {
		
		let item = Item(context: context)
		item.title = "Audemars Piguet - ROYAL OAK OFFSHORE TOURBILLON CHRONOGRAPH"
		item.price = 262000
		item.details = "A watch with two “faces”, watchmaking union of opposites - Limited Edition of 50"
		
		let item2 = Item(context: context)
		item2.title = "Killadelph Custom Triple Coil Beaker w/ Pyramid Perc and Showerhead Ash Catcher"
		item2.price = 6800.95
		item2.details = "It is known as the Unicorn because of the uniqueness of the black glass throughout, instead of clear"
		
		let item3 = Item(context: context)
		item3.title = "2017 Rolls Royce Phantom Drophead Coupe"
		item3.price = 492000
		item3.details = " 110-year-old marque makes no secret of the fact that its clients may have their cars customized any way they choose"
		
		let item4 = Item(context: context)
		item4.title = "GulfStream G-650 Jet"
		item4.price = 62000000
		item4.details = "Carries eight passengers and a crew of four on nonstop legs of 7,000 nautical miles. That means it will link Dubai with New York and London with Buenos Aires"
		
		ad.saveContext()
	}
	
	
}

