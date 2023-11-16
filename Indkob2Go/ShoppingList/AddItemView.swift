//
//  AddItemView.swift
//  Indkob2Go
//
//  Created by ksd on 07/11/2023.
//

import SwiftUI
import PhotosUI

struct AddItemView: View {
    
    @State private var isEditing = false
    @State private var name = ""
    @State private var description = ""
    @State private var amount = 1
    @State private var isBought = false
    @State private var imageData: Data?
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    @Environment(\.dismiss) var dismiss
    
    
    
    @EnvironmentObject var listController: ShoppingListsController
    
    var body: some View {
        Form {
            Section {
                TextField("Varenavn", text: $name)
                    .font(.system(size: 14))
                Stepper {
                    Text("Antal: \(amount)")
                } onIncrement: {
                    amount+=1
                } onDecrement: {
                    amount-=1
                    if amount < 1 {
                        amount = 1
                    }
                }
                TextField("Beskrivelse", text: $description)
                Toggle("Er købt", isOn: $isBought)
            }
            
            // Select Photo
            Section {
                PhotosPicker(selection: $selectedItem) {
                    Label("Vælg et billede", systemImage: "photo")
                }
                selectedImage?
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                   // .containerRelativeFrame(.horizontal)
            }
            .onChange(of: selectedItem) {oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data){
                            selectedImage = Image(uiImage: image)
                            imageData =  image.pngData()
                        }
                        
                    }
                }
            }
        }
        
        // Opret knap
        Button {
            Task(priority: .high) {
                listController.addShoppingItem(name: name, amount: amount, description: description, isBought: isBought, imageData: imageData)
                dismiss()
            }
        } label: {
            HStack {
                Text(isEditing ? "Ret" : "Opret")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color(.systemBlue))
        .cornerRadius(10)
        .padding(.top, 24)
        .disabled(!formIsValid)
        .opacity(formIsValid ? 1.0 : 0.5)
    }
}

extension AddItemView: AuthenticationProtocol {
    
    var formIsValid: Bool {
        return !name.isEmpty &&
        !listController.items.contains(where: { item in
            item.name == self.name
        })
    }
}

#Preview {
    AddItemView().environmentObject(ShoppingListsController())
}
