//
//  Workshop .swift
//  LineUpApp
//
//  Created by Apprenant151 on 21/10/2026.
//

import Foundation

struct Workshop : Identifiable {
    
    var id: UUID?
    var nameWorkshop: String
    var startTimeWorkshop: Date
    var endTimeWorkshop: Date
    var capacityMaxWorkshop: Int
    var subscribersNbWorkshop: Int
    var descriptionWorkshop: String
    var category: Category
    
    init(
        id: UUID? = nil,
        nameWorkshop: String,
        startTimeWorkshop: Date,
        endTimeWorkshop: Date,
        capacityMaxWorkshop: Int,
        subscribersNbWorkshop: Int,
        descriptionWorkshop: String,
        category: Category
    ) {
        self.id = id
        self.nameWorkshop = nameWorkshop
        self.startTimeWorkshop = startTimeWorkshop
        self.endTimeWorkshop = endTimeWorkshop
        self.capacityMaxWorkshop = capacityMaxWorkshop
        self.subscribersNbWorkshop = subscribersNbWorkshop
        self.descriptionWorkshop = descriptionWorkshop
        self.category = category
    }

}
