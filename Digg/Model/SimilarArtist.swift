//
//  SimilarArtist.swift
//  Digg
//
//  Created by Hanawa Takuro on 2016/05/09.
//  Copyright © 2016年 Hanawa Takuro. All rights reserved.
//

import Foundation
import Himotoki

struct SimilarArtist: Decodable {

    let similarartists: [Artist]

    static func decode(e: Extractor) throws -> SimilarArtist {

        return try SimilarArtist(similarartists: e.array(["similarartists", "artist"]))
    }

    struct Artist: Decodable {

        let name: String
        let match: String
        let url: NSURL
        let image: [Image]

        static func decode(e: Extractor) throws -> Artist {

            let urlString = try e.value("url") as String

            guard let url = NSURL(string: urlString) else {
                throw typeMismatch("NSURL", actual: urlString)
            }

            return try Artist(
                name: e.value("name"),
                match: e.value("match"),
                url: url,
                image: e.array("image")
            )
        }
    }

    struct Image: Decodable {
        
        let url: NSURL
        let size: String

        static func decode(e: Extractor) throws -> Image {

            let urlString = try e.value("#text") as String

            guard let url = NSURL(string: urlString) else {
                throw typeMismatch("NSURL", actual: urlString)
            }

            return try Image(
                url: url,
                size: e.value("size")
            )
        }
    }
}