//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.delegate = self
        tableView1.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return pokemonArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeRow", for: indexPath) as! myTableViewCell
        
        if let pokeArray = pokemonArray {
            cell.name.text = pokeArray[indexPath.row].name
            cell.number.text = String(pokeArray[indexPath.row].number)
            cell.stats.text = String(pokeArray[indexPath.row].attack)
        }
        
        if let image = cachedImages[indexPath.row] {
            cell.imageOutlet2.image = image // may need to change this!
        } else {
            if let pokeArray = pokemonArray {
                let url = URL(string: (pokeArray[indexPath.row].imageUrl)!)!
                let session = URLSession(configuration: .default)
                let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            cell.imageOutlet2.image = UIImage(data: imageData) // may need to change this!
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
                }
                downloadPicTask.resume()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "segway2", sender: selectedIndexPath)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "segway2" {
                if let dest = segue.destination as? PokemonInfoViewController {
                    if let selectedIndexPath = selectedIndexPath {
                    dest.image = cachedImages[(selectedIndexPath.row)]
                        if let pokeArray = pokemonArray {
                            dest.pokemon = pokeArray[(selectedIndexPath.row)]
                        }
                    }
                }
            }
        }
        
    }


    @IBOutlet weak var tableView1: UITableView!
}
