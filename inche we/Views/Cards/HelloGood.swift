//
//  HelloGood.swift
//  inche we
//
//  Created by GuillermoChaconAlcala on 01/07/26.
// Esta vista es para saludar al usuario

import SwiftUI

struct HelloGood: View {
    @State private var timezone : Date = .now
    @State private var date  = Date()
    @State private var yourName : String = ""
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 370, height: 180)
                .foregroundStyle(.orange.gradient)
                .shadow(radius: 0.9)
            
            VStack(alignment: .leading){
                Text("Good Evening!").bold().font(.system(size: 30))
                    .shadow(radius: 0.9)
                Text("Your name")
                    .font(.system(size: 20))

                
                HStack(alignment: .center){
                    Text(date.formatted(date: .abbreviated, time: .omitted))
                    Text(timezone.formatted(date: .omitted, time: .shortened))
                }.padding()
                    .shadow(radius: 0.3)
                    
            }
            
        }
    }
}

#Preview {
    HelloGood()
}
