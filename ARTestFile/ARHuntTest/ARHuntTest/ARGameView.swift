//
//  ARGameView.swift
//  ARHuntTest
//
import RealityKitContent
import SwiftUI
import RealityKit

struct ARGameView: View {
    @EnvironmentObject var appModel: AppModel
    @EnvironmentObject var gameModel: GameModel

    var body: some View {
        ZStack {
            RealityViewContainer()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct RealityViewContainer: View {
    var body: some View {
        RealityView { content in
            // Add your RealityKit content setup here
            if let gameEntity = try? await Entity(named: "Game", in: realityKitContentBundle) {
                content.add(gameEntity)
            }
        }
    }
}
