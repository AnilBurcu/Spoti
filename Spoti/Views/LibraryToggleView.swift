//
//  LibraryToggleView.swift
//  Spoti
//
//  Created by Anıl Bürcü on 26.09.2023.
//

import UIKit

protocol LibraryToggleViewDelegate:AnyObject {
    func didTapPlaylists(_ toggleView:LibraryToggleView)
    func didTapAlbums(_ toggleView:LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlist
        case album
    }
    var state: State = .playlist
    
    weak var delegate:LibraryToggleViewDelegate?
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(indicatorView)
        addSubview(playlistButton)
        addSubview(albumsButton)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
        
    }
    @objc private func didTapPlaylists(){
        
        
            state = .playlist
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.layoutIndicator()
        }
            delegate?.didTapPlaylists(self)
        
        
        
    }
    
    @objc private func didTapAlbums(){
        
        
            state = .album
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.layoutIndicator()
        }
            delegate?.didTapAlbums(self)
 
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        albumsButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 50)
        layoutIndicator()
        
    }
    
    func layoutIndicator(){
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom-5, width: 100, height: 5)
            
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playlistButton.bottom-5, width: 100, height: 5)
        }
    }
    
    func update(for state:State){
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
