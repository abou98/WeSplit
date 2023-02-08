//
//  ContentView.swift
//  WeSplit
//
//  Created by Abou DIOP on 06/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var totalAmount = 0.0
    @FocusState private var amountIsFocus: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPercent: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipVAlue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipVAlue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var total : Double {
        let tipSelection = Double(tipPercentage)
        let tipVAlue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipVAlue
        return grandTotal
    }
    
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2 ..< 50){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                    
                } header: {
                    Text("How much tip do you want to leave")
                }
                
                Section {
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total Amount")
                }
                
                Section{
                    Text(totalPercent, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }header: {
                    Text("Amount per person")
                }
                
          
            }
            .navigationTitle("WeSplit").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocus = false
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
