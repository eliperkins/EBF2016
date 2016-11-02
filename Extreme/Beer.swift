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
    let URL: Foundation.URL
}

extension Beer: Mappable {
    init(map: Mapper) throws {
        try style = map.from("style")
        try ABV = map.from("abv")
        try reviews = map.from("reviews")
        try hads = map.from("hads")
        try avg = map.from("avg")
        try userScore = map.from("ba_score")
        try brosScore = map.from("bro_score")
        try URL = map.from("url")

        let brewery: String = try map.from("brewery")
        self.brewery = brewery
        let nameAndBrewery: String = try map.from("name")
        let nameComponents = nameAndBrewery.characters
            .split(separator: "-")
            .flatMap(String.init)
            .filter {
                return $0 != " \(brewery)"
            }
            .joined(separator: "-")
        name = nameComponents
    }
}
