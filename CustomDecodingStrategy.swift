// MARK: - StringCodingKey
struct StringCodingKey: CodingKey {
    
    var stringValue: String
    var intValue: Int? {
        return nil
    }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
    }
}

// MARK: - Links
struct Links: Decodable {
    let links: [PhotoFeed]
}

// MARK: - StringCodingKey
struct PhotoFeed: Codable {
    let feedKey: String
    let feedUrl: String
}

let json =
"""
{"links":[{"youtube_feedKey" : "16869828","youtube_feedUrl" : "there is no url"},{"youtube_feedKey" : "16869828","youtube_feedUrl" : "there is no url"}]}
""".data(using: .utf8)

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .custom({ (keyArray) -> CodingKey in
    let key = keyArray.last!.stringValue.components(separatedBy: "_").last!
    return StringCodingKey(stringValue: key)!
})

let links = try! decoder.decode(Links.self, from: json!)
