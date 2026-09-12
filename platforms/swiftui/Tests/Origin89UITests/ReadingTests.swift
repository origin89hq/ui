import Foundation
import Testing
@testable import Origin89UI

private struct Fixture: Decodable {
    struct Reading: Decodable { let state: String; let value: Double?; let unit: String?; let age: String? }
    let reading: Reading
    let expected: String
}
@Test func sharedReadingFixtures() throws {
    let url = try #require(Bundle.module.url(forResource: "readings", withExtension: "json", subdirectory: "Fixtures"))
    for fixture in try JSONDecoder().decode([Fixture].self, from: Data(contentsOf: url)) {
        let reading: ReadingValue
        switch fixture.reading.state {
        case "current": reading = .current(value: try #require(fixture.reading.value), unit: try #require(fixture.reading.unit))
        case "stale": reading = .stale(value: try #require(fixture.reading.value), unit: try #require(fixture.reading.unit), age: try #require(fixture.reading.age))
        default: reading = .unknown
        }
        #expect(reading.description == fixture.expected)
    }
}
@Test func nonFiniteReadingsStayUnknown() {
    for value in [Double.nan, Double.infinity, -Double.infinity] {
        #expect(ReadingValue.current(value: value, unit: "W").description == "Unknown")
        #expect(ReadingValue.stale(value: value, unit: "W", age: "12 min ago").description == "Unknown")
    }
}
