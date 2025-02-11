//
//  NasaViewController.swift
//  URLSessionDelegate
//
//  Created by 박준우 on 2/12/25.
//

import UIKit

import SnapKit

final class NasaViewController: UIViewController {

    private let imageView = UIImageView()
    private let progressLabel = UILabel()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        self.configureHierarchy()
        self.configureLayout()
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor.white
        
        self.imageView.backgroundColor = UIColor.gray
        self.progressLabel.textAlignment = .center
        self.progressLabel.text = "진행률 표시"
        self.progressLabel.textColor = UIColor.white
        self.progressLabel.backgroundColor = UIColor.black
        self.button.backgroundColor = UIColor.systemTeal
    }
    
    private func configureHierarchy() {
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.progressLabel)
        self.view.addSubview(self.button)
    }
    
    private func configureLayout() {
        self.imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(300)
        }
        self.progressLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(32)
            make.height.equalTo(44)
        }
        self.button.snp.makeConstraints { make in
            make.top.equalTo(self.progressLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(32)
            make.height.equalTo(44)
        }
    }
}

