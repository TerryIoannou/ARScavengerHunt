//
//  ContentView.swift
//  ARHuntTest
//
//  Created by Informatica Emmen on 07/01/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appModel: AppModel
    @EnvironmentObject var gameModel: GameModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @State private var currentSlide = 0
    @State private var showCountdown = false
    @State private var countdownValue: Int = 3

    let slides = [
        ("Welcome to NHL STENDEN OPEN DAY", "The game is a Scavenger Hunt in AR! Explore and find hidden items around you."),
        ("How It Works", "You will receive clues in the form of AR objects. Find them in the real world and interact with them to progress."),
        ("Ready to Start?", "Press the 'Start Game' button when you're ready to begin your scavenger hunt adventure!")    ]

    var body: some View {
        ZStack {
            if !gameModel.isGameStarted {
                // Show slides if the game hasn't started
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white, Color.yellow, Color.red]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    Text(slides[currentSlide].0)  // Slide Title
                        .font(.custom("AvenirNext-Bold", size: 40))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)

                    Text(slides[currentSlide].1)  // Slide Description
                        .font(.custom("AvenirNext-Regular", size: 20))
                        .foregroundColor(.black)
                        .padding()
                        .multilineTextAlignment(.center)

                    // Display random 2D objects on "How It Works" slide
                    if currentSlide == 1 {
                        HStack {
                            ForEach(0..<5, id: \.self) { index in
                                shape(for: index)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.black)
                                    .overlay(
                                        Text("?")
                                            .font(.title)
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    }

                    HStack {
                        // 'Previous' button
                        if currentSlide > 0 {
                            Button(action: {
                                withAnimation {
                                    currentSlide -= 1
                                }
                            }) {
                                Text("Previous")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }

                        Spacer()

                        // 'Next' button
                        Button(action: {
                            withAnimation {
                                if currentSlide < slides.count - 1 {
                                    currentSlide += 1
                                }
                            }
                        }) {
                            Text(currentSlide == slides.count - 1 ? "End of Slides" : "Next")
                                .font(.headline)
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)

                    Spacer()

                    if currentSlide == slides.count - 1 {
                        // Countdown timer and Start Game button
                        VStack {
                            if showCountdown {
                                Text("Starting in \(countdownValue)...")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }

                            Button(action: {
                                startCountdown()  // Start countdown on button press
                            }) {
                                Text("Start Game")
                                    .font(.title)
                                    .padding()
                                    .background(Color.yellow)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                }
            } else {
                // Show immersive AR experience when the game starts
                ARGameView()  // Transition to immersive space
            }
        }
        
        
    }
    // Function to start the countdown only when the user presses 'Start Game'
    func startCountdown() {
        showCountdown = true
        if countdownValue > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                countdownValue -= 1
                startCountdown()  // Recursively call until countdown reaches 0
            }
        } else {
            activateImmersiveExperience()
        }
    }
    private func activateImmersiveExperience() {
        Task {
            await openImmersiveSpace(id: appModel.immersiveSpaceID) // Corrected: Added 'id:' label
        }
        gameModel.isGameStarted = true
    }

}
// Function to choose a random shape for the 2D objects
func shape(for index: Int) -> some View {
    switch index {
    case 0:
        return AnyView(Circle())  // Circle shape
    case 1:
        return AnyView(Rectangle())  // Rectangle shape
    case 2:
        return AnyView(Capsule())  // Capsule shape
    case 3:
        return AnyView(Ellipse())  // Ellipse shape
    case 4:
        return AnyView(Triangle())  // Triangle shape
    default:
        return AnyView(Circle())  // Default to Circle
    }
}




// Define the custom triangle shape
struct Triangle: Shape {
func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Top point
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Bottom left
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom right
    path.closeSubpath()
    return path
}
}
