//
//  ViewController.swift
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
}

class ViewController: UIViewController {

    private let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.setTitle("→", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        return nextButton
    }()
    
    private let plusButton: UIButton = {
        let plusButton = UIButton()
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        return plusButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = UIColor(red: 252/255, green: 229/255, blue: 205/255, alpha: 1.0)
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-CGFloat.buttonsRightInset)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(CGFloat.buttonsHeight)
            make.width.equalTo(CGFloat.buttonsWidth)
        }
        
        let nextButtonAction = UIAction { _ in
            self.nextButtonPressed()
        }
        nextButton.addAction(nextButtonAction, for: .touchUpInside)
        
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.buttonsLeftOffset)
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(CGFloat.buttonsHeight)
            make.width.equalTo(CGFloat.buttonsWidth)
        }
        
        let plusButtonAction = UIAction { _ in
            self.plusButtonPressed()
        }
        plusButton.addAction(plusButtonAction, for: .touchUpInside)
    }
    
    
    private func nextButtonPressed() {
        let controller = ScrollingImagesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func plusButtonPressed() {
        let controller = AddingImagesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

}

