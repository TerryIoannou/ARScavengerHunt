//
//  ARHuntTestApp.swift
//  ARHuntTest
//

import SwiftUI

@main
struct ARHuntTestApp: App {
    @StateObject private var appModel = AppModel()
    @StateObject private var gameModel = GameModel()
    private var avPlayerViewModel = AVPlayerViewModel()

    var body: some Scene {
        WindowGroup {
            if avPlayerViewModel.isPlaying {
                AVPlayerView(viewModel: avPlayerViewModel)
            } else {
                ContentView()
                    .environmentObject(appModel)
                    .environmentObject(gameModel)
            }
        }

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environmentObject(appModel)
                .environmentObject(gameModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                    avPlayerViewModel.play()
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                    avPlayerViewModel.reset()
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
