//
//  AVPlayerView.swift
//  ARHuntTest
//
//  Created by Informatica Emmen on 07/01/2025.
//

import SwiftUI
import AVKit

struct AVPlayerView: UIViewControllerRepresentable {
    let viewModel: AVPlayerViewModel

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        return viewModel.makePlayerViewController()
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update the AVPlayerViewController if needed
    }
}
