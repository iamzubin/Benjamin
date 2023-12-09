//
//  ContentView.swift
//  Benjamin
//
//  Created by Sangeeta Papinwar on 09/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var session = SessionModel()
    
    var body: some View {
        Onboarding()
            .environmentObject(session)
    }
}

#Preview {
    ContentView()
}
