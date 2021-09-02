//
//  SceneDelegate.swift
//  RentaTeamTest_Colchugina
//
//  Created by Ирина Кольчугина on 28.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = PhotoViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
    }

}

