//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Brandon Johns on 4/2/24.
//

import SwiftUI

struct ResortView: View {
    @Environment(Favorites.self) var favorites
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    let resort: Resort
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) { ResortsDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortsDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    
                    Text(resort.facilities.joined(separator: ", "))
                        .padding(.vertical)
                    
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
           
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
