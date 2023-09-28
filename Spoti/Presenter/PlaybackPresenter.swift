//
//  PlaybackPresenter.swift
//  Spoti
//
//  Created by Anıl Bürcü on 25.09.2023.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource:AnyObject {
    var songname:String? {get}
    var subtitle:String? {get}
    var imageURL:URL? {get}
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    
    var playerVC: PlayerViewController?
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
            if let track = track, tracks.isEmpty {
                return track
            }
            else if let player = self.playerQueue, !tracks.isEmpty {
                return tracks[index]
            }

            return nil
        }
    
    var player:AVPlayer?
    var playerQueue:AVQueuePlayer?
    
    
    func startPlayback(from viewController: UIViewController,
                              track: AudioTrack) {
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        viewController.present(
            UINavigationController(rootViewController: vc), animated: true) {
                [weak self] in
                self?.player?.play()
            }
        vc.delegate = self
        vc.dataSource = self
        self.playerVC = vc
        
    }
    func startPlayback(from viewController: UIViewController,
                       tracks: [AudioTrack]){
        
        self.tracks = tracks
        self.track = nil
        
        let items: [AVPlayerItem] = tracks.compactMap ({
            guard let url = URL(string: $0.preview_url ?? "") else {
                return nil
            }
                return    AVPlayerItem(url: url)
            
        })
        
        self.playerQueue?.volume = 0
        self.playerQueue?.play()
        
        self.playerQueue = AVQueuePlayer(items: items)
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
        self.playerVC = vc
        
        
    }
    
    func startPlaylist(from viewController: UIViewController,
                       playlist: Playlist){
        
        
    }
}
extension PlaybackPresenter: PlayerViewControllerDelegate {
    
    
    func didSlideSlider(_ value: Float) {
        
        player?.volume = value
    }
    
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
            if tracks.isEmpty {
                // Not playlist or album
                player?.pause()
            }
            else if let player = playerQueue {
                player.advanceToNextItem()
                index += 1
                print(index)
                playerVC?.refreshUI()
            }
        }

        func didTapBackward() {
            
            if tracks.isEmpty {
                // Not playlist or album
                player?.pause()
                player?.play()
            }
            else if let firstItem = playerQueue?.items().first {
                playerQueue?.pause()
                playerQueue?.removeAllItems()
                playerQueue = AVQueuePlayer(items: [firstItem])
                playerQueue?.play()
                playerQueue?.volume = 0.5
            }
        }
    
    
}

extension PlaybackPresenter:PlayerDataSource {
    var songname: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    
}
