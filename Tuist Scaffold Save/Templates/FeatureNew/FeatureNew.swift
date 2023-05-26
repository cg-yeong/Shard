//
//  NewFeature.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2023/05/25.
//

import Foundation
import ProjectDescription

let featureNameAttribute: Template.Attribute = .required("name")


let template = Template(
    description: "A Template for new Feature",
    attributes: [
        featureNameAttribute
    ],
    items: [
        .file(path: "Projects/Feature/Sources/Feature\(featureNameAttribute)/View/\(featureNameAttribute)ViewController.swift", templatePath: "View/NewViewController.stencil"),
        .file(path: "Projects/Feature/Sources/Feature\(featureNameAttribute)/ViewModel/\(featureNameAttribute)ViewModel.swift", templatePath: "ViewModel/NewViewModel.stencil")
    ]
)
