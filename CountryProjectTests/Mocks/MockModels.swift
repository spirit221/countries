//
//  MockModels.swift
//  CountryProjectTests
//
//  Created by Sergey Gusev on 13.10.2024.
//

enum MockModels {
    static let usCountryListItem = CountryListItem(
        id: "US",
        name: Name(
            common: "United States",
            official: "United States of America",
            nativeName: ["eng": Translation(official: "United States of America", common: "United States")]
        ),
        flags: Flags(
            png: "https://flagcdn.com/w320/us.png",
            svg: "https://flagcdn.com/us.svg",
            alt: "The flag of the United States of America"
        )
    )
    
    static let caCountryListItem = CountryListItem(
        id: "CA",
        name: Name(
            common: "Canada",
            official: "Canada",
            nativeName: [
                "eng": Translation(official: "Canada", common: "Canada"),
                "fra": Translation(official: "Canada", common: "Canada")
            ]
        ),
        flags: Flags(
            png: "https://flagcdn.com/w320/ca.png",
            svg: "https://flagcdn.com/ca.svg",
            alt: "The flag of Canada"
        )
    )
    
    static let jpCountryListItem = CountryListItem(
        id: "JP",
        name: Name(
            common: "Japan",
            official: "Japan",
            nativeName: ["jpn": Translation(official: "日本", common: "日本")]
        ),
        flags: Flags(
            png: "https://flagcdn.com/w320/jp.png",
            svg: "https://flagcdn.com/jp.svg",
            alt: "The flag of Japan"
        )
    )
    
    static let countryListItem = CountryListItem(
        id: "US",
        name: Name(
            common: "United States",
            official: "United States of America",
            nativeName: ["eng": Translation(official: "United States of America", common: "United States")]
        ),
        flags: Flags(
            png: "https://flagcdn.com/w320/us.png",
            svg: "https://flagcdn.com/us.svg",
            alt: "The flag of the United States of America is composed of thirteen equal horizontal stripes of red alternating with white, with a blue rectangle in the canton bearing fifty small five-pointed white stars arranged in nine offset horizontal rows where rows of six stars alternate with rows of five stars. The 50 stars represent the 50 states and the 13 stripes represent the thirteen original colonies."
        )
    )
    
    static let countryDetail = CountryDetail(
        name: Name(
            common: "United States",
            official: "United States of America",
            nativeName: ["eng": Translation(official: "United States of America", common: "United States")]
        ),
        tld: [".us"],
        cca2: "US",
        ccn3: "840",
        cca3: "USA",
        independent: true,
        status: .officiallyAssigned,
        unMember: true,
        currencies: ["USD": Currency(name: "United States dollar", symbol: "$")],
        idd: Idd(root: "+1", suffixes: ["201"]),
        capital: ["Washington, D.C."],
        altSpellings: ["US", "USA", "United States of America"],
        region: .americas,
        languages: ["eng": "English"],
        translations: ["ara": Translation(official: "الولايات المتحدة الامريكية", common: "الولايات المتحدة")],
        latlng: [38.0, -97.0],
        landlocked: false,
        area: 9372610.0,
        demonyms: Demonyms(
            eng: Eng(f: "American", m: "American"),
            fra: Eng(f: "Américaine", m: "Américain")
        ),
        flag: "🇺🇸",
        maps: Maps(
            googleMaps: "https://goo.gl/maps/e8M246zY4BSjkjAv6",
            openStreetMaps: "https://www.openstreetmap.org/relation/148838#map=2/20.6/-85.8"
        ),
        population: 329484123,
        car: Car(signs: ["USA"], side: .sideRight),
        timezones: ["UTC-12:00", "UTC-11:00", "UTC-10:00", "UTC-09:00", "UTC-08:00", "UTC-07:00", "UTC-06:00", "UTC-05:00", "UTC-04:00", "UTC+10:00", "UTC+12:00"],
        continents: [.northAmerica],
        flags: Flags(
            png: "https://flagcdn.com/w320/us.png",
            svg: "https://flagcdn.com/us.svg",
            alt: "The flag of the United States of America is composed of thirteen equal horizontal stripes of red alternating with white, with a blue rectangle in the canton bearing fifty small five-pointed white stars arranged in nine offset horizontal rows where rows of six stars alternate with rows of five stars. The 50 stars represent the 50 states and the 13 stripes represent the thirteen original colonies."
        ),
        coatOfArms: CoatOfArms(
            png: "https://mainfacts.com/media/images/coats_of_arms/us.png",
            svg: "https://mainfacts.com/media/images/coats_of_arms/us.svg"
        ),
        startOfWeek: .sunday,
        capitalInfo: CapitalInfo(latlng: [38.89, -77.05]),
        cioc: "USA",
        subregion: "North America",
        fifa: "USA",
        borders: ["CAN", "MEX"],
        gini: ["2018": 41.4],
        postalCode: PostalCode(format: "#####-####", regex: "^\\d{5}(-\\d{4})?$")
    )
}

