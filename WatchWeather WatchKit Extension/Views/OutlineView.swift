//
//  OutlineView.swift
//  WatchWeather WatchKit Extension
//
//  Created by benjamiin on 30/03/2021.
//

import SwiftUI

struct OutlineView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
            .padding()
    }
}

struct OutlineView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineView()
    }
}
