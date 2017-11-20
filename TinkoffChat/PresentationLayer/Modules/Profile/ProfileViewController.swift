//
//  ViewController.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 20.09.17.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var pictureView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var dataIndicator: UIActivityIndicatorView!
    @IBOutlet weak var gcdBtn: UIButton!
    @IBOutlet weak var operationBtn: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    let profileService = ProfileService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        bioTextField.delegate = self
        imagePicker.delegate = self
        
        GCDDataManager.readFromFile(completion: {
            name, bio, photo in
            self.nameTextField.text = name
            self.bioTextField.text = bio
            self.userImgView.image = photo
        })
        
        profileService.getProfile(completion: {
            profile in
            
            if let name = profile.name {
                self.nameTextField.text = name
            }
            
            if let descr = profile.description {
                self.bioTextField.text = descr
            }
            
            if let photo = profile.photo {
                self.userImgView.image = photo
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        cameraAlert.addAction(UIAlertAction(title: "Загрузить из сети", style: .default) { (action:UIAlertAction!) in
            self.loadFromWeb()
        })
        cameraAlert.addAction(UIAlertAction(title: "Отменить", style: .cancel) { (action:UIAlertAction!) in
        })
        
        self.present(cameraAlert, animated: true)
    }
    
    func loadFromWeb() {
        self.performSegue(withIdentifier: "webImages", sender: nil)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pictureView.isHidden = false
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pictureView.isHidden = true
    }
    
    @IBAction func gcdPressed(_ sender: Any) {
        dataIndicator.startAnimating()
        gcdBtn.isEnabled = false
        operationBtn.isEnabled = false
        
        if let name = nameTextField.text, let bio = bioTextField.text, let photo = userImgView.image {
            GCDDataManager.saveToFile(name: name, bio: bio, photo: photo, completion: {
                self.gcdBtn.isEnabled = true
                self.operationBtn.isEnabled = true
                self.dataIndicator.stopAnimating()
            })
        }
    }
    
    @IBAction func nameTFChanged(_ sender: Any) {
        profileService.saveProfile(name: nameTextField.text, description: bioTextField.text, photo: userImgView.image)
    }
    
    @IBAction func descrTFChanged(_ sender: Any) {
        profileService.saveProfile(name: nameTextField.text, description: bioTextField.text, photo: userImgView.image)
    }
    
    @IBAction func operationPressed(_ sender: Any) {
        dataIndicator.startAnimating()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        userImgView.image = chosenImage
        profileService.saveProfile(name: nameTextField.text, description: bioTextField.text, photo: chosenImage)
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftNavBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

