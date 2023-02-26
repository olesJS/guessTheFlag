//
//  ContentView.swift
//  flagGuesser
//
//  Created by Олексій Якимчук on 10.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var europe = ["croatia", "england", "estonia", "finland", "france", "germany", "italy", "latvia", "lithuania", "norway", "portugal", "scotland", "spain", "sweden", "ukraine", "wales"].shuffled()
    @State private var asia = ["azerbaijan", "china", "georgia", "india", "japan", "kazakhstan", "kyrgyzstan", "mongolia", "pakistan", "philippines", "taiwan", "turkey", "vietnam"].shuffled()
    let continents = ["europe", "asia"]
    
    var currentArray: [String] {
        continent == "asia" ? asia : europe
    }
    
    @State private var continent = "europe"
    @State private var index = Int.random(in: 0...2)
    @State private var count = 0
    
    @State private var showWrongAlert = false
    @State private var showRightAlert = false
    @State private var showFinalAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.mint, .cyan, .yellow, .orange]), center: .topLeading, startRadius: 35, endRadius: 750)
                
                VStack {
                    Spacer()
                    Spacer()
                    
                    Text("Guess:")
                        .font(.subheadline.bold())
                    Text(currentArray[index].capitalized)
                        .font(.title.bold())
                    
                    VStack {
                        ForEach(0..<3) { number in
                            Button {
                                if number == index {
                                    tappedRight()
                                } else {
                                    showWrongAlert = true
                                    tappedWrong()
                                }
                            } label: {
                                Image(currentArray[number])
                                    .shadow(radius: 50)
                                    .frame(width: 200, height: 100)
                            }
                            .alert("Wrong answer", isPresented: $showWrongAlert) {}
                            .alert("Right answers", isPresented: $showRightAlert) {
                                Button("Next", role: .cancel) {}
                                Button("Finish", role: .destructive) {
                                    tappedWrong()
                                }
                            }
                            .alert("You won!", isPresented: $showFinalAlert) {}
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .buttonStyle(.bordered)
                        }
                    }
                    
                    Text("Count: \(count)")
                        .frame(width: 125, height: 35)
                        .background(.ultraThinMaterial)
                        .padding(.vertical, 10)
                    
                    VStack {
                        Section {
                            Picker("Pick continent", selection: $continent) {
                                ForEach(continents, id: \.self) {
                                    Text($0.capitalized)
                                }
                            }
                        } header: {
                            Text("Pick a continent:")
                                .font(.footnote)
                        }
                        .frame(maxWidth: 250)
                        .pickerStyle(.segmented)
                    }
                    
                    Spacer()
                }
                .navigationTitle("FlagGuesser")
            }
            .ignoresSafeArea()
        }
    }
    
    func tappedRight() {
        if count == 10 {
            showRightAlert = true
            continent = (continent == "europe" ? "asia" : "europe")
        } else if count == 20 {
            showFinalAlert = true
            count = 0
            europe = ["croatia", "england", "estonia", "finland", "france", "germany", "italy", "latvia", "lithuania", "norway", "portugal", "scotland", "spain", "sweden", "ukraine", "wales"].shuffled()
            asia = ["azerbaijan", "china", "georgia", "india", "japan", "kazakhstan", "kyrgyzstan", "mongolia", "pakistan", "philippines", "taiwan", "turkey", "vietnam"].shuffled()
            continent = "europe"
        }
        count += 1
        continent == "europe" ? europe.remove(at: index) : asia.remove(at: index)
        continent == "europe" ? europe.shuffle() : asia.shuffle()
        index = Int.random(in: 0...2)
    }
    
    func tappedWrong() {
        count = 0
        europe = ["croatia", "england", "estonia", "finland", "france", "germany", "italy", "latvia", "lithuania", "norway", "portugal", "scotland", "spain", "sweden", "ukraine", "wales"].shuffled()
        asia = ["azerbaijan", "china", "georgia", "india", "japan", "kazakhstan", "kyrgyzstan", "mongolia", "pakistan", "philippines", "taiwan", "turkey", "vietnam"].shuffled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
