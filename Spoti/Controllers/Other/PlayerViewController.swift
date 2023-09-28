//
//  PlayerViewController.swift
//  Spoti
//
//  Created by Anıl Bürcü on 11.09.2023.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate:AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource:PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
        
    }()
    
    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        configureBarButtons()
        controlsView.delegate = self
        configure()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top+10, width: view.width, height: view.width)
        
        controlsView.frame = CGRect(x: 10, y: imageView.bottom+10, width: view.width-20, height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
        
        
    }
    private func configure(){
        imageView.sd_setImage(with: dataSource?.imageURL)
        controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songname, subtitle: dataSource?.subtitle))
    }
    
    private func configureBarButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
        
        
        
    }
    
    @objc private func didTapClose(){
        dismiss(animated: true)
    }
    
    @objc private func didTapAction(){
        dismiss(animated: true)
        //Action
    }
    
    func refreshUI() {

            configure()
        }
    
    
    
}

extension PlayerViewController:PlayerControlsViewDelegate{
    
    func playerControlsViewDidSlideVolume(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        
        delegate?.didSlideSlider(value)
    }
    
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
            }
    
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapForward()
    }
    
    func playerControlsViewDidTapBackwardButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBackward()
    }
    
    
}
