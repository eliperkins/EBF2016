import Mapper
import Foundation

struct Beer {
    let name: String
    let style: String
    let ABV: String
    let reviews: String
    let hads: String
    let avg: String
    let userScore: String
    let brosScore: String
    let brewery: String
    let URL: NSURL
}

extension Beer: Mappable {
    init(map: Mapper) throws {
        let nameAndBrewery: String = try map.from("name")
        name = nameAndBrewery.characters.split("-").first.flatMap(String.init) ?? ""
        try style = map.from("style")
        try ABV = map.from("abv")
        try reviews = map.from("reviews")
        try hads = map.from("hads")
        try avg = map.from("avg")
        try userScore = map.from("ba_score")
        try brosScore = map.from("bro_score")
        try brewery = map.from("brewery")
        try URL = map.from("url")
    }
}