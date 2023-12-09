//
//  SessionView.swift
//  Benjamin
//
//  Created by Sangeeta Papinwar on 09/12/23.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var session: SessionModel
    
    var body: some View {
        if session.loggedIn {
            Button(action: {session.logout()}, label: {Text("Logout")})
        } else {
            Onboarding()
        }
    }
}

#Preview {
    SessionView()
}
