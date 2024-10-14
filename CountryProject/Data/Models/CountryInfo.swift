//
//  CountryInfo.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

struct InfoRow {
    let title: String
    let value: String
}

enum CountryInfo: String, CaseIterable, Identifiable {
    var id: String {
        return rawValue
    }
    
    case general
    case geography
    case economy
    case more
    
    var title: String {
        return rawValue.capitalized
    }
    
    func getInfo(for countryDetail: CountryDetail?) -> [InfoRow] {
        guard let countryDetail = countryDetail else { return [] }
        
        switch self {
        case .general:
            return [
                InfoRow(title: "Capital", value: countryDetail.capital?.first ?? "N/A"),
                InfoRow(title: "Population", value: "\(countryDetail.population.formatted())"),
                InfoRow(title: "Area", value: "\(countryDetail.area.formatted()) km²"),
                InfoRow(title: "Region", value: countryDetail.region.rawValue),
                InfoRow(title: "Subregion", value: countryDetail.subregion ?? "N/A"),
                InfoRow(title: "Languages", value: countryDetail.languages?.values.joined(separator: ", ") ?? "N/A"),
                InfoRow(title: "UN Member", value: countryDetail.unMember ? "Yes" : "No"),
                InfoRow(title: "Independent", value: countryDetail.independent.map { $0 ? "Yes" : "No" } ?? "N/A"),
                InfoRow(title: "Status", value: countryDetail.status.rawValue.replacingOccurrences(of: "-", with: " "))
            ]
            
        case .geography:
            let latlng = if let capitalInfo = countryDetail.capitalInfo.latlng,
                capitalInfo.count == 2 {
                    "Lat: \(capitalInfo[0])\nLng: \(capitalInfo[1])"
                } else {
                    "N/A"
                }
                
            return [
                InfoRow(title: "Continent", value: countryDetail.continents.map { $0.rawValue }.joined(separator: ", ")),
                InfoRow(title: "Borders", value: countryDetail.borders?.joined(separator: ", ") ?? "None"),
                InfoRow(title: "Latitude", value: "\(countryDetail.latlng[0])"),
                InfoRow(title: "Longitude", value: "\(countryDetail.latlng[1])"),
                InfoRow(title: "Landlocked", value: countryDetail.landlocked ? "Yes" : "No"),
                InfoRow(title: "Timezones", value: countryDetail.timezones.joined(separator: ", ")),
                InfoRow(title: "Capital Coordinates", value: latlng)
            ]
            
        case .economy:
            let currencies = countryDetail.currencies?.values.map({ "\($0.name) (\($0.symbol))" }).joined(separator: ", ") ?? "N/A"
            return [
                InfoRow(title: "Currencies", value: currencies),
                InfoRow(title: "GINI Index", value: countryDetail.gini?.values.first.map { String(format: "%.1f", $0) } ?? "N/A"),
                InfoRow(title: "Top-level Domains", value: countryDetail.tld?.joined(separator: ", ") ?? "N/A"),
                InfoRow(title: "Start of Week", value: countryDetail.startOfWeek.rawValue.capitalized)
            ]
            
        case .more:
           return [
                InfoRow(title: "Alt Spellings", value: countryDetail.altSpellings.joined(separator: ", ")),
                InfoRow(title: "Demonym (m/f)", value: "\(countryDetail.demonyms?.eng.m ?? "N/A") / \(countryDetail.demonyms?.eng.f ?? "N/A")"),
                InfoRow(title: "FIFA Code", value: countryDetail.fifa ?? "N/A"),
                InfoRow(title: "CIOC", value: countryDetail.cioc ?? "N/A"),
                InfoRow(title: "Driving Side", value: countryDetail.car.side.rawValue.capitalized),
                InfoRow(title: "Car Signs", value: countryDetail.car.signs?.joined(separator: ", ") ?? "N/A"),
                InfoRow(title: "Postal Code Format", value: countryDetail.postalCode?.format ?? "N/A"),
            ]
        }
    }
}
