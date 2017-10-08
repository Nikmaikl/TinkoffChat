//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 20.09.17.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editBtnView: UIView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func editAction(_ sender: Any) {
    }
    
    @IBAction func tappedOnCameraIcon(_ sender: Any) {
        print("Выбери изображение профиля")
        
        let cameraAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        cameraAlert.addAction(UIAlertAction(title: "Установить из галереи", style: .default) { (action:UIAlertAction!) in
            self.setUpFromGallery()
        })
        cameraAlert.addAction(UIAlertAction(title: "Сделать фото", style: .default) { (action:UIAlertAction!) in
            self.takeAPhoto()
        })
        cameraAlert.addAction(UIAlertAction(title: "Отменить", style: .cancel) { (action:UIAlertAction!) in
        })
        
        self.present(cameraAlert, animated: true)
    }
    
    func takeAPhoto()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Ошибка", message: "У вас нет камеры", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setUpFromGallery()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        userImgView.image = chosenImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftNavBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

