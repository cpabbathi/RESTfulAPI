//
//  SearchBarView.swift
//  CountryHolidays
//
//  Created by Chaithra Pabbathi on 10/27/20.
//

import SwiftUI
import UIKit

struct SearchBarView: UIViewRepresentable {
    @Binding var searchString: String
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(parent: self)
        
        return coordinator
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Enter the search string"
        searchBar.delegate = context.coordinator
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchString
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: SearchBarView
        
        init(parent: SearchBarView) {
            self.parent = parent
        }
                
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard let searchStringinBar = searchBar.text else { return }
            parent.searchString = searchStringinBar
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchString: Binding.constant(""))
    }
}
