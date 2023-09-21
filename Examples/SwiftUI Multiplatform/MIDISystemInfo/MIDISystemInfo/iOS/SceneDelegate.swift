//
//  SceneDelegate.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2021-2023 Steffan Andrews • Licensed under MIT License
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentViewForCurrentPlatform()
            .environmentObject(AppDelegate.midiManager)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // empty
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // empty
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // empty
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // empty
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // empty
    }
}
