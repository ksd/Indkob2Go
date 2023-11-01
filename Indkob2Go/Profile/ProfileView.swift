//
//  ProfileView.swift
//  Indkob2Go
//
//  Created by ksd on 31/10/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("PP")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Peter Parker")
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text("test@gmail.com")
                            .font(.footnote)
                            .tint(.gray)
                    }
                }
            }
            
            Section("Generelt") {
                HStack {
                    SettingsRowView(imageName: "gear",
                                    title: "Version",
                                    tintColor: Color(.systemGray))
                    Spacer()
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            
            Section("Konto") {
                Button {
                    print("Sign out")
                } label: {
                    SettingsRowView(imageName: "arrow.left.circle.fill",
                                    title: "Sign out",
                                    tintColor: .red)
                }
                
                Button {
                    print("Slet konto")
                } label: {
                    SettingsRowView(imageName: "xmark.circle.fill",
                                    title: "Slet konto",
                                    tintColor: .red)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
