//
//  ParseModel.swift
//  NoneAF
//
//  Created by root0 on 2022/05/18.
//

import Foundation

class Lodestone_ID: Decodable {
    var Achievements: String?
    var AchievementsPublic: String?
    var Character: Character_ff?
    var FreeCompany: String?
    var FreeCompanyMembers: String?
    var Friends: String?
    var FriendsPublic: String?
    var Minions: String?
    var Mounts: String?
    var PvPTeam: String?
}
class Character_ff: Decodable {
    var Avatar: String?
    var DC: String?
    var Name: String?
    var Portrait: String?
    
    
}
