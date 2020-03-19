//
//  Topics.swift
//  Discourse_SoniaSieiro
//
//  Created by Sonia Sieiro on 19/03/2020.
//  Copyright © 2020 Sonia Sieiro. All rights reserved.
//

import Foundation

struct LatestTopicsResponse: Codable {
    let users: [Users]
    let primary_goups: [Bool]?
    let topic_list: TopicList
//    enum CodingKeys: String, CodingKey {
//        case canCreateCategory = "can_create_category"
//        case canCreateTopic = "can_create_topic"
//        case draft
//        case draftKey = "draft_key"
//        case draftSequence = "draft_sequence"
//        case categories
//    }
}

struct Users: Codable {
    let id: Int
    let username: String
    let name: String?
    let avatar_template: String
}

struct TopicList: Codable {
    let can_create_topic: Bool?
    let draft: Bool?
    let draft_key: String
    let draft_sequence: Bool?
    let per_page: Int?
    let topics: [TopicsArray]
}

struct TopicsArray: Codable {
    let id: Int
    let title: String
    let fancy_title: String
    let slug: String
    let post_count: Int?
    let reply_count: Int?
    let highest_post_number: Int?
    let image_url: String?
    let created_at: String
    let last_posted_at: String
    let bumped: Bool?
    let bumped_at: String
    let unseen: Bool?
    let pinned: Bool?
    let unpinned: Bool?
    let visible: Bool?
    let closed: Bool?
    let archived: Bool?
    let bookmarked: Bool?
    let liked: Bool?
    let views: Int?
    let like_count: Int?
    let has_summary: Bool?
    let archetype: String
    let last_poster_username: String
    let category_id: Int?
    let pinned_globally: Bool?
    let posters: [Posters]
}

struct Posters: Codable {
    let extras: String
    let description: String
    let user_id: Int?
}
