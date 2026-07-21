//
//  NewNote.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 30/06/26.
//

import SwiftUI
struct NewCard: View {
    let note : String
    let img: String
    let overlay : String
    let action : () -> Void
    var body: some View {
        Button(){
            action()
        }label:{
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [.teal, .cyan],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 150)
                VStack(alignment: .leading){
                    Label(note, systemImage: img) //pencil.and.scribble
// MARK: -  se comenta para utilizar todo el card como un boton
//     Button("New Note",systemImage: "pencil.and.scribble"){}
                    .foregroundStyle(.black)
                    .font(.system(size: 16))
                    .padding()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 150, alignment: .topLeading)
            }
            .overlay(alignment:.bottomTrailing){
                Image(systemName: img)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.black.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 100)
                //     .offset(x: 50, y: 20)
                
                    .padding()
            }
            
        }
    }
}

//#Preview {
//    NewNote()
//}
