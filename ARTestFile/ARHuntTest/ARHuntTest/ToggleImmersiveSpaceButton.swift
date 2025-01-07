import SwiftUI

struct ToggleImmersiveSpaceButton: View {
    
    @EnvironmentObject var appModel: AppModel
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    var body: some View {
        Button {
            Task { @MainActor in
                switch appModel.immersiveSpaceState {
                case .open:
                    appModel.immersiveSpaceState = .inTransition
                    await dismissImmersiveSpace()
                    // Do not set immersiveSpaceState to .closed here; handle it in ImmersiveView.onDisappear()
                    
                case .closed:
                    appModel.immersiveSpaceState = .inTransition
                    let result = await openImmersiveSpace(id: appModel.immersiveSpaceID)
                    switch result {
                    case .opened:
                        // Do not set immersiveSpaceState to .open here; handle it in ImmersiveView.onAppear()
                        break
                    case .userCancelled, .error:
                        fallthrough
                    @unknown default:
                        appModel.immersiveSpaceState = .closed
                    }

                case .inTransition:
                    // This case should not happen because the button is disabled during transition.
                    break
                }
            }
        } label: {
            Text(appModel.immersiveSpaceState == .open ? "Hide Immersive Space" : "Show Immersive Space")
        }
        .disabled(appModel.immersiveSpaceState == .inTransition)
        .animation(.none, value: 0)
        .fontWeight(.semibold)
    }
}
