//
//  FinalViewController.swift
//  Fotos
//
//  Created by Catia Miranda de Souza on 07/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit
import  Photos

class FinalViewController: UIViewController {

    @IBOutlet weak var ivPhoto: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivPhoto.image = image
        ivPhoto.layer.borderWidth = 10
        ivPhoto.layer.borderColor = UIColor.white.cgColor
  
    }
    func saveToAlbum(){
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([creationRequest.placeholderForCreatedAsset] as! NSArray)
            
        }) { (success, error) in
            if !success{
                print(error!.localizedDescription)
            }else{
                let alert = UIAlertController(title: "Imagem Salva", message: "Sua imagem foi salva com sucesso!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil )
                alert.addAction(okAction)
                self.present(alert, animated:  true, completion: nil)
            }
        }
    }
    @IBAction func save(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.saveToAlbum()
            default:
                let alert = UIAlertController(title: "Erro", message: "Precisa de autorizacao", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil )
                alert.addAction(okAction)
                self.present(alert, animated:  true, completion: nil)
                
            }
            
        }
    }
    // voltar 1 tela
    @IBAction func restart(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
