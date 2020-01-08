//
//  EffectViewController.swift
//  Fotos
//
//  Created by Catia Miranda de Souza on 07/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viLoading: UIView!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    var image: UIImage!
    
    
    lazy var filterManager: FilterManager = {
        let filterManage = FilterManager(image: image)
        return filterManage
    }()
    
    let filterImageNames = [
        "comic",
        "sepia",
        "halftone",
        "crystallize",
        "vignette",
        "noir"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivPhoto.image = image
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FinalViewController
        vc.image = ivPhoto.image
    }
    func showLoading(_ show: Bool){
        viLoading.isHidden = !show
    }
    
}
extension EffectViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView)->Int{
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterManager.filterNames.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EffectCollectionViewCell
        
        cell.ivEffect.image = UIImage(named: filterImageNames[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let type = FilterType(rawValue: indexPath.row){
            showLoading(true)
            DispatchQueue.global(qos: .userInitiated).async {
                let filteredImage = self.filterManager.appyFilter(type: type)
                DispatchQueue.main.async {
                    self.ivPhoto.image = filteredImage
                    self.showLoading(false)
                }
                
            }
           
            
        }
    }
}
