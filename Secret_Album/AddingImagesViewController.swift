//
//  AddingImagesViewController.swift
//  Secret_Album
//
//  Created by Maryia Dziarkach on 5.06.24.
//

import UIKit
import SnapKit

class AddingImagesViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let screenHeight = UIScreen.main.bounds.height
    private var keyboardHeight: CGFloat = 0
    
    private let mainContainer: UIView = {
        let mainContainer = UIView()
        mainContainer.backgroundColor = .clear
        return mainContainer
    }()
    
    private let zeroContainer: UIView = {
        let zeroContainer = UIView()
        zeroContainer.backgroundColor = UIColor.clear
        return zeroContainer
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        return backButton
    }()
    
    private let thirdContainer: UIView = {
        let thirdContainer = UIView()
        thirdContainer.backgroundColor = UIColor.clear
        return thirdContainer
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 255/255, green: 242/255, blue: 204/255, alpha: 1.0)
        return imageView
    }()
    
    private let plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.lightGray, for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 150, weight: .medium)
        return plusButton
    }()
    
    private let secondContainer: UIView = {
        let secondContainer = UIView()
        secondContainer.backgroundColor = UIColor.clear
        return secondContainer
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        textField.textColor = .black
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.placeholder = "Enter text here"
        return textField
    }()
    
    
    
    private let firstContainer: UIView = {
        let firstContainer = UIView()
        firstContainer.backgroundColor = UIColor.clear
        return firstContainer
    }()
    
    private let likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.setTitle("♥", for: .normal)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        likeButton.setTitleColor(.red, for: .normal)
        return likeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 229/255, blue: 153/255, alpha: 1.0)
        setMainContainer()
        setZeroUIView()
        addBackButton()
        setThirdUIView()
        
        setFirstImage()
        addPlusButton()
        setSecondUIView()
        setTextLabel()
        setFirstUIView()
        addLikeButton()
        configureNotifications()
    }
    
    private func configureNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo, // словарь с дополнительной информацией об уведомлении.
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue, // извлечение продолжительности анимации для появления или исчезновения клавиатуры и преобразование значения в Double.
              let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return } // извлечение конечного фрейма (размер и положение) клавиатуры и преобразование значения в CGRect.
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            
            mainContainer.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-keyboardFrame.height)
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        if notification.name == UIResponder.keyboardWillHideNotification { // Проверка, что текущее уведомление — это UIResponder.keyboardWillHideNotification (клавиатура исчезает). Обновление констрейнтов для scrollView, чтобы нижний край вернулся к нулевому отступу.
            mainContainer.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(0)
            }
        }
        
        UIView.animate(withDuration: duration) {
            
            self.view.layoutIfNeeded() // self.view.layoutIfNeeded() — обновление лейаутов для текущего состояния констрейнтов.
        }
    }
    
    func setMainContainer() {
        view.addSubview(mainContainer)
        
        mainContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setZeroUIView() {
        mainContainer.addSubview(zeroContainer)
        
        zeroContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().offset(0)
            make.height.equalTo(80)
        }
    }
    
    func addBackButton() {
        zeroContainer.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(zeroContainer).offset(40)
            make.left.equalTo(zeroContainer).offset(25)
            make.height.equalTo(50)
        }
        let backButtonAction = UIAction { _ in
            self.exitAlert()
            self.backButtonPressed()
        }
        backButton.addAction(backButtonAction, for: .touchUpInside)
    }
    
    func setThirdUIView() {
        mainContainer.addSubview(thirdContainer)
        
        thirdContainer.snp.makeConstraints { make in
            make.top.equalTo(zeroContainer.snp.bottom).offset(0)
            make.left.right.equalToSuperview().offset(0)
            make.height.equalTo(550)
        }
    }
    
    func setFirstImage() {
        thirdContainer.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.left.equalTo(thirdContainer).offset(25)
            make.right.equalTo(thirdContainer).offset(-25)
            make.height.equalTo(500)
        }
    }
    
    func addPlusButton() {
        thirdContainer.addSubview(plusButton)
        
        plusButton.snp.makeConstraints { make in
            make.centerX.equalTo(thirdContainer)
            make.centerY.equalTo(thirdContainer)
            make.width.height.equalTo(100)
        }
        
        let plusButtonAction = UIAction { _ in
            self.uploadImageAlert()
        }
        plusButton.addAction(plusButtonAction, for: .touchUpInside)
        
    }
    
    
    func setSecondUIView() {
        mainContainer.addSubview(secondContainer)
        
        secondContainer.snp.makeConstraints { make in
            make.top.equalTo(thirdContainer.snp.bottom).offset(0)
            make.left.right.equalToSuperview().offset(0)
            make.height.equalTo(100)
        }
    }
    
    func setTextLabel() {
        secondContainer.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(secondContainer).offset(25)
            make.left.equalTo(secondContainer).offset(25)
            make.right.equalTo(secondContainer).offset(-25)
            make.height.equalTo(50)
        }
        textField.delegate = self
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        
    }
    
    
    func setFirstUIView() {
        mainContainer.addSubview(firstContainer)
        
        firstContainer.snp.makeConstraints { make in
            make.top.equalTo(secondContainer.snp.bottom).offset(0)
            make.left.right.equalToSuperview().offset(0)
            make.bottom.equalTo(mainContainer.snp.bottom).offset(-5)
        }
    }
    
    func addLikeButton() {
        firstContainer.addSubview(likeButton)
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(firstContainer).offset(25)
            make.centerX.equalTo(firstContainer)
            make.height.equalTo(50)
        }
    }
    
    private func uploadImageAlert() {
        let alert = UIAlertController(title: "Choose the image", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Take a photo", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.showImagePicker(sourceType: .camera)
            }
            
        }
        alert.addAction(camera)
       
        let photoLibrary = UIAlertAction(title: "Upload from Photos", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.showImagePicker(sourceType: .photoLibrary)
            }
        }
        alert.addAction(photoLibrary)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    private func makePlusButtonClear() {
        plusButton.setTitleColor(.clear, for: .normal)
    }
    
    
    private func backButtonPressed() {
        let controller = ViewController()
        
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    private func exitAlert() {
        let alert = UIAlertController(title: "WARNING", message: "Would you like to save or upload files?", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
        }
        alert.addAction(saveAction)
        
        let loadAction = UIAlertAction(title: "Load", style: .default) { _ in
            
        }
        alert.addAction(loadAction)
        
        self.present(alert, animated: true)
    }
    
}

extension Notification.Name { // имя - то, что кричим
    static let changeText = Notification.Name("change Text")
    
    
}

extension AddingImagesViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage = UIImage()
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            chosenImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            chosenImage = image
        }
        
        imageView.image = chosenImage
        makePlusButtonClear()
        picker.dismiss(animated: true)
    }
}

extension AddingImagesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}


