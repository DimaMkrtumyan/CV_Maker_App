//
//  CreateCvModel.swift
//  CV_Maker_App
//
//  Created by Dmitriy Mkrtumyan on 26.07.23.
//

import Foundation

struct PersonsCv: Codable {
    var name: String?
    var surname: String?
    var birthDate: String?
    var education: [String]? = [String(), String(), String()]
    var experience: [String]? = [String(), String(), String()]
    var skills: [String]? = [String(), String()]

    enum CodingKeys: String, CodingKey {
        case name
        case surname
        case birthDate
        case education
        case experience
        case skills
    }
}
