//
//  ProfileEditViewModel.swift
//  FoodGo
//
//  Created by Alex.personal on 9/9/24.
//

import Foundation
import SwiftData

public final class ProfileEditViewModel: ObservableObject {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: false, allowsSave: true)
    let container: ModelContainer?

    init() {
        self.container = try? ModelContainer(
            for: UserPreferences.self,
            configurations: configuration
        )
    }
    
    @MainActor func save(model: any PersistentModel)  {
        container?.mainContext.insert(model)
    }
    
    @MainActor func retrieve<T: PersistentModel>(type: T.Type) -> T? {
        let fetchDescriptor = FetchDescriptor<T>()
        let result = try? container?.mainContext.fetch(fetchDescriptor)
        return result?.first
    }
}
