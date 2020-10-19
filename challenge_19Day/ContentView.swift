//
//  ContentView.swift
//  challenge_19Day
//
//  Created by Pavel Sakhanko on 19.10.20.
//

import SwiftUI

enum TimeParams: String {
    case seconds
    case minutes
    case hours
    case days
}

struct ContentView: View {
    
    @State private var inputTimeValue = ""
    @State private var inPickerSelectedParam = 0
    @State private var toPickerSelectedParam = 0
    
    let inoutTimeParams: [TimeParams] = [.seconds, .minutes, .hours, .days]
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Text("Time Converter")
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Image(systemName: "timer")
                        .foregroundColor(.red)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
               
                HStack(spacing: 20) {
                    Spacer()
                    TextField("Enter some number", text: $inputTimeValue)
                        .padding(15)
                        .font(Font.system(size: 15, weight: .medium, design: .default))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .keyboardType(.decimalPad)
                    Spacer()
                }
                
                VStack {
                    Text("FROM:")
                        .foregroundColor(.gray)
                    
                    Picker(selection: $inPickerSelectedParam, label: Text("")) {
                        ForEach(0 ..< inoutTimeParams.count) { index in
                            Text(self.inoutTimeParams[index].rawValue).tag(index)
                        }
                     }.pickerStyle(SegmentedPickerStyle())
                }
                
                VStack {
                    Text("TO:")
                        .foregroundColor(.gray)
                    
                    Picker(selection: $toPickerSelectedParam, label: Text("")) {
                        ForEach(0 ..< inoutTimeParams.count) { index in
                            Text(self.inoutTimeParams[index].rawValue).tag(index)
                        }
                     }.pickerStyle(SegmentedPickerStyle())
                }
                Spacer()
                
                HStack {
                    Text("\(convert(inputTimeValue))")
                        .fontWeight(.bold)
                        .font(.system(size: 70))
                        .foregroundColor(.red)
                }
               
                Spacer()
            }
        }
    }

    // need to check math
    private func convert(_ inputTimeValue: String) -> String {
        guard let inoutTime = Int(inputTimeValue) else { return ""}
        
        var result = ""
        
        switch (inoutTimeParams[inPickerSelectedParam], inoutTimeParams[toPickerSelectedParam]) {
        case (.seconds, .seconds):
            result = "\(inoutTime)"
        case (.seconds, .minutes):
            result = "\(inoutTime / 60)"
        case (.seconds, .hours):
            result = "\(inoutTime / 3_600)"
        case (.seconds, .days):
            result = "\(inoutTime / 43_200)"
            
            
        case (.minutes, .seconds):
            result = "\(inoutTime * 60)"
        case (.minutes, .minutes):
            result = "\(inoutTime)"
        case (.minutes, .hours):
            result = "\(inoutTime / 60)"
        case (.minutes, .days):
            result = "\(inoutTime / 1_440)"
            
            
        case (.hours, .seconds):
            result = "\(inoutTime * 3600)"
        case (.hours, .minutes):
            result = "\(inoutTime * 60)"
        case (.hours, .hours):
            result = "\(inoutTime)"
        case (.hours, .days):
            result = "\(inoutTime / 24)"
            
         
        case (.days, .seconds):
            result = "\(inoutTime * 43_200)"
        case (.days, .minutes):
            result = "\(inoutTime * 1_440)"
        case (.days, .hours):
            result = "\(inoutTime * 24)"
        case (.days, .days):
            result = "\(inoutTime)"
        }
        
        return result
    }
}
