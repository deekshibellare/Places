//
//  PlacesViewModel.swift
//  Places
//
//  Created by Deekshith Bellare on 27/09/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation

enum Section {
    case allPlaces
    case featuredPlaces
    case piligrimagePlaces
}

class PlacesViewModel {
    var isPlacesViewExapanded: Bool = false

    // MARK: Section related

    var sectionsArray: [Section] = [.allPlaces, .featuredPlaces, .piligrimagePlaces]

    // MARK: Data

    var placesDataSource = PlacesDataSource()
    var allPlaces: [Place]?
    var featuredPlaces: [Place]?
    var pligrimagePlaces: [Place]?

    init() {
        fetchData()
    }

    func fetchData() {
        allPlaces = placesDataSource.fetchAll()
        featuredPlaces = placesDataSource.fetchFeatured()
        pligrimagePlaces = placesDataSource.fetchPiligrimage()
    }

    func numberOfSections() -> Int {
        return sectionsArray.count
    }

    func section(for section: Int) -> Section {
        return sectionsArray[section]
    }

    func numberOfRows(at section: Int) -> Int {
        let section = sectionsArray[section]
        return numberOfRows(for: section)
    }

    func numberOfRows(for section: Section) -> Int {
        switch section {
        case .allPlaces:

            let count = allPlaces?.count ?? 0
            // Show maximum of 3 in less state
            if !isPlacesViewExapanded {
                return count <= 3 ? count : 4
            } else {
                // add more cell to total
                return count + 1
            }
        case .featuredPlaces:
            return 1
        case .piligrimagePlaces:
            return pligrimagePlaces?.count ?? 0
        }
    }

    func item(at indexPath: IndexPath) -> Place? {
        let section = self.section(for: indexPath.section)
        switch section {
        case .allPlaces:
            return allPlaces?[indexPath.row]
        case .featuredPlaces:
            return featuredPlaces?[indexPath.row]
        case .piligrimagePlaces:
            return pligrimagePlaces?[indexPath.row]
        }
    }

    func listTtem(at indexPath: IndexPath) -> ListItem? {
        if indexPath.row == 3 {
            return ListItem.item(isExpanded: isPlacesViewExapanded)
        }
        let mappedIndex = indexPath.row < 3 ? indexPath.row : indexPath.row - 1
        guard let place = allPlaces?[mappedIndex] else {
            return nil
        }
        return ListItem.item(for: place)
    }
}

class ListItem {
    var name: String?
    var imageName: String?
    var isViewMoreToggleItem: Bool = false

    class func item(for place: Place) -> ListItem {
        let item = ListItem()
        item.name = place.name
        item.imageName = place.imageName
        item.isViewMoreToggleItem = false
        return item
    }

    class func item(isExpanded: Bool) -> ListItem {
        let item = ListItem()
        item.name = isExpanded ? "Less" : "More"
        item.imageName = isExpanded ? "uparrow" : "downarrow"
        item.isViewMoreToggleItem = true
        return item
    }
}
