//
//  ImmersiveView.swift
//  ARHuntTest
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @EnvironmentObject var appModel: AppModel

    var body: some View {
        RealityView { content in
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
            }
        }
    }
}
