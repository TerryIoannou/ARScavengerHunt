//
//  AVPlayerViewModel.swift
//  ARHuntTest
//
//  Created by Informatica Emmen on 07/01/2025.
//

import AVKit

@MainActor
@Observable
class AVPlayerViewModel: NSObject {
    var isPlaying: Bool = false
    private var avPlayerViewController: AVPlayerViewController?
    private var avPlayer = AVPlayer()
    private let videoURL: URL? = {
        // Replace with your video URL, e.g., Bundle.main.url(forResource: "MyVideo", withExtension: "mp4")
        return nil
    }()

    func makePlayerViewController() -> AVPlayerViewController {
        let avPlayerViewController = AVPlayerViewController()
        avPlayerViewController.player = avPlayer
        self.avPlayerViewController = avPlayerViewController
        return avPlayerViewController
    }

    func play() {
        guard !isPlaying, let videoURL else { return }
        isPlaying = true
        let item = AVPlayerItem(url: videoURL)
        avPlayer.replaceCurrentItem(with: item)
        avPlayer.play()
    }

    func reset() {
        guard isPlaying else { return }
        isPlaying = false
        avPlayer.replaceCurrentItem(with: nil)
        avPlayerViewController?.delegate = nil
    }
}
