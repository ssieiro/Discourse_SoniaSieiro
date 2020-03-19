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
    let primaryGroups: [Bool]?
    let topicList: TopicList
    enum CodingKeys: String, CodingKey {
        case users
        case primaryGroups = "primary_goups"
        case topicList = "topic_list"
    }
}

struct Users: Codable {
    let id: Int
    let username: String
    let name: String?
    let avatarTemplate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case avatarTemplate = "avatar_template"
    }
}

struct TopicList: Codable {
    let canCreateTopic: Bool?
    let draft: Bool?
    let draftKey: String
    let draftSequence: Int?
    let perPage: Int?
    let topics: [Topic]
    
    enum CodingKeys: String, CodingKey {
        case canCreateTopic = "can_create_topic"
        case draft
        case draftKey = "draft_key"
        case draftSequence = "draft_sequence"
        case perPage = "per_page"
        case topics
    }
}

struct Topic: Codable {
    let id: Int
    let title: String
    let fancyTitle: String
    let slug: String
    let postCount: Int?
    let replyCount: Int?
    let highestPostNumber: Int?
    let imageUrl: String?
    let createdAt: String
    let lastPostedAt: String
    let bumped: Bool?
    let bumpedAt: String
    let unseen: Bool?
    let pinned: Bool?
    let unpinned: Bool?
    let visible: Bool?
    let closed: Bool?
    let archived: Bool?
    let bookmarked: Bool?
    let liked: Bool?
    let views: Int?
    let likeCount: Int?
    let hasSummary: Bool?
    let archetype: String
    let lastPosterUsername: String
    let categoryId: Int?
    let pinnedGlobally: Bool?
    let posters: [Poster]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case fancyTitle = "fancy_title"
        case slug
        case postCount = "post_count"
        case replyCount = "reply_count"
        case highestPostNumber = "highest_post_number"
        case imageUrl = "image_url"
        case createdAt = "created_at"
        case lastPostedAt = "last_posted_at"
        case bumped
        case bumpedAt = "bumped_at"
        case unseen
        case pinned
        case unpinned
        case visible
        case closed
        case archived
        case bookmarked
        case liked
        case views
        case likeCount = "like_count"
        case hasSummary = "has_summary"
        case archetype
        case lastPosterUsername = "last_poster_username"
        case categoryId = "category_id"
        case pinnedGlobally = "pinned_globally"
        case posters
    }
}

struct Poster: Codable {
    let extras: String?
    let description: String
    let userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case extras
        case description
        case userId = "user_id"

    }
}
