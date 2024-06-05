//
//  AddingImagesViewController.swift
//  Secret_Album
//
//  Created by Maryia Dziarkach on 5.06.24.
//

import UIKit
import SnapKit

class AddingImagesViewController: UIViewController {
    
    let screenHeight = UIScreen.main.bounds.height
    private var keyboardHeight: CGFloat = 0
    
    private let mainContainer: UIView = {
        let mainContainer = UIView()
        mainContainer.backgroundColor = .green
        return mainContainer
    }()
    
    private let zeroContainer: UIView = {
        let zeroContainer = UIView()
        zeroContainer.backgroundColor = UIColor.clear
        return zeroContainer
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("< Back", for: .normal)
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
        imageView.backgroundColor = .systemGray
        return imageView
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
        view.backgroundColor = .lightGray
        setMainContainer()
        setZeroUIView()
        addBackButton()
        setThirdUIView()
        setFirstImage()
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
            make.height.equalTo(screenHeight) // Задаем высоту containerView такой же, как высота экрана
            make.bottom.equalToSuperview()
        }
    }
    
    func setZeroUIView() {
        view.addSubview(zeroContainer)
        
        mainContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().offset(0)
            make.height.equalTo(100)
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
            self.backButtonPressed()
        }
        backButton.addAction(backButtonAction, for: .touchUpInside)
    }
    
    func setThirdUIView() {
        mainContainer.addSubview(thirdContainer)
        
        thirdContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
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
    
    
    func setSecondUIView() {
        mainContainer.addSubview(secondContainer)
        
        secondContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(650)
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
            make.top.equalToSuperview().offset(750)
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
    
    
    private func backButtonPressed() {
        let controller = ViewController()
        
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
}

extension Notification.Name { // имя - то, что кричим
    static let changeText = Notification.Name("change Text")
    
    
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

