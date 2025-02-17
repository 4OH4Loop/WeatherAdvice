//
//  ContentView.swift
//  WeatherAdvice
//
//  Created by Carolyn Ballinger on 2/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var imageName = ""
    @State private var adviceMessage = ""
    @State private var temp = ""
    @FocusState private var textFieldIsFocused: Bool
    
    var body: some View {
        
        VStack {
            Text("Weather Advice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.teal)
                .animation(.default, value: temp)
            
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
            
            Text(adviceMessage)
                .font(.largeTitle)
                .frame(minHeight: 80)
                .padding()
                .minimumScaleFactor(0.5)
                .animation(.default, value: temp)
            
            HStack {
                Text("What is the temp?")
                
                TextField("", text: $temp)
                    .frame(width: 65)
                    .textFieldStyle(.roundedBorder)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 2)
                    }
                    .keyboardType(.numberPad)
                    .focused($textFieldIsFocused)
                    .onChange(of: textFieldIsFocused) {
                        if textFieldIsFocused {
                            print("TAPPED!")
                            temp = ""
                            imageName = ""
                            adviceMessage = ""
                        }
                    }
            }
            .font(.title)
            
            Spacer()
            
            Button("Get Advice") {
                giveAdvice()
                textFieldIsFocused = false
            }
            .font(.title2)
            .tint(.teal)
            .buttonStyle(.borderedProminent)
            .disabled(temp.isEmpty)
            .padding()
        }
    }
    
    
    
    func giveAdvice() {
        guard let tempInt = Int(temp) else {
            adviceMessage = "Please enter a valid temperature."
            return
        }
        switch tempInt {
        case 76...:
            adviceMessage = "It's Hot!"
            imageName = "hot"
        case 63..<76:
            adviceMessage = "Nice and mild"
            imageName = "mild"
        case 45..<63:
            adviceMessage = "You're going to need a sweater"
            imageName = "cool"
        case 33..<45:
            adviceMessage = "You're going to need a coat"
            imageName = "cold"
        default:
            adviceMessage = "Bundle up, it's freezing!"
            imageName = "freezing"
        }
    }
}

#Preview {
    ContentView()
}
