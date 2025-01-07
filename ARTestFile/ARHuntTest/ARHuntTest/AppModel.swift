import SwiftUI

/// Maintains app-wide state
@MainActor
class AppModel: ObservableObject {
    // Marking this property with @Published to ensure SwiftUI views update
    @Published var isGameStarted: Bool = false // Use a default value

    // Immersive space state management
    let immersiveSpaceID = "ARGameSpace"

    // Enum representing the state of the immersive space
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    
    // Published property for immersive space state
    @Published var immersiveSpaceState: ImmersiveSpaceState = .closed
}
