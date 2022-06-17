//
//  ContentView.swift
//  Landmarks
//
//  Created by root0 on 2022/06/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
