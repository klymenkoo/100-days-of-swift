//
//  ViewController.swift
//  ImageViewer
//
//  Created by Volodymyr Klymenko on 2019-03-03.
//  Copyright © 2019 Volodymyr Klymenko. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var images: [String] = []

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Images"
		navigationController?.navigationBar.prefersLargeTitles = true

		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)

		for item in items {
			if item.hasPrefix("img"){
				images.append(item)
			}
		}

		images.sort()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return images.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
		cell.textLabel?.text = images[indexPath.row]
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			vc.selectedImage = images[indexPath.row]
			vc.totalNumberOfImages = images.count
			vc.selectedImageIndex = indexPath.row + 1
			navigationController?.pushViewController(vc, animated: true)
		}
	}

}

