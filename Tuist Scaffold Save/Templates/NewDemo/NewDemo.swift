//
//  NewFeature.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2023/05/25.
//

import Foundation
import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")


let template = Template(
    description: "A Template for new Demo",
    attributes: [
        nameAttribute
    ],
    items: [
        .file(path: "Projects/DemoApp/\(nameAttribute)/Project.swift", templatePath: "NewModule.stencil"),
        .file(path: "Projects/DemoApp/\(nameAttribute)/Sources/AppDelegate.swift", templatePath: "AppDelegate.stencil"),
        .file(path: "Projects/DemoApp/\(nameAttribute)/Sources/SceneDelegate.swift", templatePath: "SceneDelegate.stencil"),
        .file(path: "Projects/DemoApp/\(nameAttribute)/Resources/LaunchScreen.storyboard", templatePath: "LaunchScreen.stencil")
    ]
)
