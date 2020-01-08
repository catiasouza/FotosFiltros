//
//  ViewController.swift
//  Fotos
//
//  Created by Catia Miranda de Souza on 07/01/20.
//  Copyright © 2020 Catia Miranda de Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //ESCONDER a navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func selectSource(_ sender: Any) {
        // ALERT CONTROLER
        let alert = UIAlertController(title: "Selecionar foto", message: "De onde voce quer escolher a sua foto", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler:  { (action) in
                self.selectPicture(sourceType: .camera)
                
            })
            alert.addAction(cameraAction)
        }
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photoAction = UIAlertAction(title: "Album de fotos", style: .default) { (action) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photoAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EffectViewController
        vc.image = sender as? UIImage
    }
    func selectPicture(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker,animated: true, completion: nil)
    }
    
}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if  let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let originalWidh = image.size.width
            let aspectRatio = originalWidh / image.size.height
            var smallSize: CGSize
            if aspectRatio > 1{
                smallSize = CGSize(width: 100, height: 1000/aspectRatio)
                
            }else{
                smallSize = CGSize(width: 1000*aspectRatio,height: 1000)
                
            }
            
            UIGraphicsBeginImageContext(smallSize)
            image.draw(in: CGRect(x: 0, y: 0, width: smallSize.width, height: smallSize.height))
            let smallImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dismiss(animated: true, completion: {
                self.performSegue(withIdentifier: "effectsSegue", sender: smallImage)
            })
        }
    }
}
