//
//  DateConverter.swift
//  Pursuitstgram
//
//  Created by Cameron Rivera on 3/9/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct DateConverter{
    static func makeMyDateIntoAString(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, YYYY h:mm a"
        return dateFormatter.string(from: date)
    }
}
