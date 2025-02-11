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
    
    private var buffer: Data = Data() {
        didSet {
            let percent = round((Double(self.buffer.count) / self.total) * 100)
            self.progressLabel.text = "\(percent) / 100"
            self.imageView.image = UIImage(data: self.buffer)
        }
    }
    private var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        self.configureHierarchy()
        self.configureLayout()
    }
    
    @objc private func buttonTapped() {
        let urlRequest = URLRequest(url: Nasa.photo, timeoutInterval: 7)
        
        let configure: URLSessionConfiguration = .default
        
        let request = URLSession(configuration: configure, delegate: self, delegateQueue: .main)
        
        request.dataTask(with: urlRequest).resume()
    }
    
    private func configureView() {
        self.view.backgroundColor = UIColor.white
        
        self.imageView.backgroundColor = UIColor.gray
        self.progressLabel.textAlignment = .center
        self.progressLabel.text = "진행률 표시"
        self.progressLabel.textColor = UIColor.white
        self.progressLabel.backgroundColor = UIColor.black
        self.button.setTitle("사진 불러오기", for: [])
        self.button.backgroundColor = UIColor.systemTeal
        self.button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
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
extension NasaViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        if let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode), let contentLength = response.value(forHTTPHeaderField: "Content-Length") {
            
            self.total = Double(contentLength) ?? 0
            self.buffer = Data()
            
            return .allow
        } else {
            self.imageView.image = UIImage(systemName: "star.fill")
            
            return .cancel
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.buffer.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error {
            self.imageView.image = UIImage(systemName: "star.fill")
        }
    }
}
