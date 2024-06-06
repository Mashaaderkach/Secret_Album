//
//  ScrollingImagesViewController.swift
//  Secret_Album
//
//  Created by Maryia Dziarkach on 5.06.24.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let buttonsLeftOffset: CGFloat = 20
    static let buttonsRightInset: CGFloat = 20
    static let buttonsHeight: CGFloat = 40
    static let buttonsWidth: CGFloat = 40
    static let datePickerHeight: CGFloat = 100
    static let datePickerWidth: CGFloat = 160
    static let textLabelHeight: CGFloat = 100
    static let textLabelWidth: CGFloat = 170
}

class ScrollingImagesViewController: UIViewController {
    
    
    private let imagesArray = ["Mountains_1", "Mountains_2", "Mountains_3", "Mountains_4", "Mountains_5", "Mountains_6"]
    
    private var currentImageIndex = 1
    
    
    
    
    let zeroContainer: UIView = {
        let zeroContainer = UIView()
        zeroContainer.backgroundColor = UIColor.clear
        return zeroContainer
    }()
    
    let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("< Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        return backButton
    }()
    
    let thirdContainer: UIView = {
        let thirdContainer = UIView()
        thirdContainer.backgroundColor = UIColor.clear
        return thirdContainer
    }()
    
    let selectedImage: UIImageView = {
        let selectedImage = UIImageView()
        selectedImage.image = UIImage(named: "Mountains_1")
        return selectedImage
    }()
    
    let secondContainer: UIView = {
        let secondContainer = UIView()
        secondContainer.backgroundColor = UIColor.clear
        return secondContainer
    }()
    
    let descriptionTextLabel: UILabel = {
        let descriptionTextLabel = UILabel()
        descriptionTextLabel.textColor = UIColor.black
        descriptionTextLabel.text = "Some text about mountains"
        descriptionTextLabel.textAlignment = .center
        descriptionTextLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return descriptionTextLabel
    }()
    
    let firstContainer: UIView = {
        let firstContainer = UIView()
        firstContainer.backgroundColor = UIColor.clear
        return firstContainer
    }()
    
    let leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.setTitle("←", for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        leftButton.setTitleColor(.black, for: .normal)
        return leftButton
    }()
    
    let rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.setTitle("→", for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        rightButton.setTitleColor(.black, for: .normal)
        return rightButton
    }()
    
    let likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.setTitle("♥", for: .normal)
        likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        likeButton.setTitleColor(.red, for: .normal)
        return likeButton
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    private var dateTextLabel: UILabel = {
        let dateTextLabel = UILabel()
        dateTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        dateTextLabel.textColor = .lightGray
        dateTextLabel.textAlignment = .center
        return dateTextLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        setZeroUIView()
        addBackButton()
        
        setThirdUIView()
        setFirstImage()
        
        
        setSecondUIView()
        setDescriptionTextLabel()
        setFirstUIView()
        addLeftButton()
        addRightButton()
        addLikeButton()
        
        addDateTextLabel()
        addDatePicker()
    }
    
    
    
    func setZeroUIView() {
        view.addSubview(zeroContainer)
        
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
            self.backButtonPressed()
        }
        backButton.addAction(backButtonAction, for: .touchUpInside)
    }
    
    func setThirdUIView() {
        view.addSubview(thirdContainer)
        
        thirdContainer.snp.makeConstraints { make in
            make.top.equalTo(zeroContainer.snp.bottom).offset(0)
            make.left.right.equalToSuperview().offset(0)
            make.height.equalTo(550)
        }
    }
    
    func setFirstImage() {
        thirdContainer.addSubview(selectedImage)
        
        selectedImage.snp.makeConstraints { make in
            make.top.left.equalTo(thirdContainer).offset(25)
            make.right.equalTo(thirdContainer).offset(-25)
            make.height.equalTo(500)
        }
    }
    
    
    func setSecondUIView() {
        view.addSubview(secondContainer)
        
        secondContainer.snp.makeConstraints { make in
            make.top.equalTo(thirdContainer.snp.bottom).offset(0)
            make.left.right.equalToSuperview().offset(0)
            make.height.equalTo(135)
        }
    }
    
    func setDescriptionTextLabel() {
        secondContainer.addSubview(descriptionTextLabel)
        
        descriptionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(secondContainer).offset(10)
            make.left.equalTo(secondContainer).offset(25)
            make.right.equalTo(secondContainer).offset(-25)
            make.height.equalTo(30)
        }
        
    }
    
    private func addDateTextLabel() {
        secondContainer.addSubview(dateTextLabel)
        dateTextLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondContainer)
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloat.textLabelWidth)
            make.height.equalTo(CGFloat.textLabelHeight)
        }
    }
    
    private func addDatePicker() {
        secondContainer.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(secondContainer).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloat.datePickerWidth)
            make.height.equalTo(CGFloat.datePickerHeight)
        }
        let action = UIAction { _ in
            
        }
        datePicker.addAction(action, for: .touchUpInside)
    }
    
    
    func setFirstUIView() {
        view.addSubview(firstContainer)
        
        firstContainer.snp.makeConstraints { make in
            make.top.equalTo(secondContainer.snp.bottom).offset(0)
            make.left.right.bottom.equalToSuperview().offset(0)
//            make.height.equalTo(102)
        }
    }
    
    
    func addLeftButton() {
        firstContainer.addSubview(leftButton)
        
        leftButton.snp.makeConstraints { make in
            make.centerY.equalTo(firstContainer)
            make.left.equalTo(firstContainer).offset(25)
            make.height.equalTo(50)
        }
        let action = UIAction { _ in
            self.switchToPreviousImage()
        }
        leftButton.addAction(action, for: .touchUpInside)
    }
    
    
    func addRightButton() {
        firstContainer.addSubview(rightButton)
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalTo(firstContainer)
            make.left.equalTo(leftButton).offset(300)
            make.right.equalTo(firstContainer).offset(-25)
            make.height.equalTo(50)
        }
        let action = UIAction { _ in
            self.switchToNextImage()
        }
        rightButton.addAction(action, for: .touchUpInside)
        
    }
    
    func addLikeButton() {
        firstContainer.addSubview(likeButton)
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(firstContainer)
            make.centerX.equalTo(firstContainer)
            make.height.equalTo(50)
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MMM / yyyy HH:mm"
        let dateString = formatter.string(from: sender.date)
        dateTextLabel.text = dateString
    }
    
   
    
    private func switchToNextImage() {
        let nextImageIndex = (currentImageIndex + 1) % imagesArray.count
        let nextImageView = UIImageView(image: UIImage(named: imagesArray[nextImageIndex]))
        
        nextImageView.frame = selectedImage.frame
        nextImageView.frame.origin.x = -view.frame.width
        
        view.addSubview(nextImageView)
        
        UIView.animate(withDuration: 0.01, animations: {
            nextImageView.frame.origin.x = self.selectedImage.frame.origin.x
        }, completion: { _ in
            self.selectedImage.image = nextImageView.image
            nextImageView.removeFromSuperview()
        })
        
        currentImageIndex = nextImageIndex
    }
    
    
    private func switchToPreviousImage() {
        let previousImageIndex = (currentImageIndex - 1 + imagesArray.count) % imagesArray.count
        let previousImageView = UIImageView(image: UIImage(named: imagesArray[previousImageIndex]))
        
        previousImageView.frame = selectedImage.frame
        previousImageView.frame.origin.x = view.frame.width
        
        view.addSubview(previousImageView)
        
        UIView.animate(withDuration: 0.01, animations: {
            previousImageView.frame.origin.x = self.selectedImage.frame.origin.x
        }, completion: { _ in
            self.selectedImage.image = previousImageView.image
            previousImageView.removeFromSuperview()
        })
        
        currentImageIndex = previousImageIndex
        
    }
    
    
    private func backButtonPressed() {
        let controller = ViewController()
        
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
