//
//  SceneDelegate.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 04.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var services = ServiceHolder()

    var isTesting: Bool {
        NSClassFromString("XCTestCase") != nil
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        guard !isTesting else {
            return
        }

        self.window = UIWindow(windowScene: windowScene)

        let builder = ModuleBuilder()
        let router = Router(services: services, builder: builder)
        self.window?.rootViewController = router.rootViewConroller
        self.window?.makeKeyAndVisible()
    }
}

