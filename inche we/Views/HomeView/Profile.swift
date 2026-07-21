//
//  Profile.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 01/07/26.
// Settings: nombre, dark mode, clean all data, delete account

import SwiftUI

struct Profile: View {
    var body: some View {
        NavigationStack{
            Text("Profile")
                .navigationTitle("Settings")
                .navigationSubtitle("Profile")
        }
    }
}

#Preview {
    Profile()
}
