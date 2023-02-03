//
//  ContentView.swift
//  DungeonDice
//
//  Created by Students on 03.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...rawValue)
        }
        func message() -> String {
            return "You rolled a \(roll()) on a \(rawValue)-sided dice"
        }
    }
    
    @State private var dice: Dice = .four
    @State private var mainTitle = "Dungeon Dice"
    @State private var resultMessage = ""
    
    var body: some View {
        VStack {
            Text(mainTitle)
                .font(.largeTitle)
                .fontWeight(.black)
            
            Spacer()
            
            Text(resultMessage)
                .font(.title)
            
            Spacer()
            
            
            VStack{
                ForEach(Dice.allCases, id: \.self) { number in
                    Button {
                        resultMessage = number.message()
                    } label: {
                        Text("\(number.rawValue)-sided")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
