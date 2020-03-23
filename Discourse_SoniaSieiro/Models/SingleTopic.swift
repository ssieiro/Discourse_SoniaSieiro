//
//  SingleTopic.swift
//  Discourse_SoniaSieiro
//
//  Created by Sonia Sieiro on 23/03/2020.
//  Copyright © 2020 Sonia Sieiro. All rights reserved.
//

import Foundation


struct SingleTopicResponse: Codable {
    let id: Int
    let title: String
    let posts_count: Int
    let details: Detail
//    enum CodingKeys: String, CodingKey {
//        case topicList = "topic_list"
//    }
}


struct Detail: Codable {
    let can_delete: Bool?
}

