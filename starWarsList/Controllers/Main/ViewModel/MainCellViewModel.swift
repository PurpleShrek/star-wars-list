//
//  MainCellViewModel.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 16/12/2022.
//

import Foundation
import Combine

final class MainCellViewModel {
    @Published var filmData: Film?
        
    private let film: Film
    
    init(film: Film) {
        self.film = film
        
        setUpBindings()
    }
    
    private func setUpBindings() {
        filmData = film
    }
}
