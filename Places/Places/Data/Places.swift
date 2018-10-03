//
//  Places.swift
//  Places
//
//  Created by Deekshith Bellare on 27/09/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation

struct PlacesDataSource {
    var places = { () -> [Place] in

        let udupi = Place(id: 1, name: "Udupi", imageName: "Udupi", isFeatured: false, isPilgrimage: true, details: "Krishna Temple")
        let pushpagiri = Place(id: 2, name: "Pushpagiri", imageName: "Pushpagiri", isFeatured: true, isPilgrimage: false)
        let skandagiri = Place(id: 3, name: "Skandagiri", imageName: "Skandagiri", isFeatured: false, isPilgrimage: false)
        let sringeri = Place(id: 4, name: "Sringeri", imageName: "Sringeri", isFeatured: false, isPilgrimage: false)
        let tadiyandamol = Place(id: 5, name: "Tadiyandamol", imageName: "Tadiyandamol", isFeatured: true, isPilgrimage: false)
        let yana = Place(id: 6, name: "Yana", imageName: "Yana", isFeatured: true, isPilgrimage: false)
        let zPoint = Place(id: 7, name: "Z Point", imageName: "Z-Point", isFeatured: false, isPilgrimage: false)

        let barkanaFalls = Place(id: 8, name: "Barkana Falls", imageName: "BarkanaFalls", isFeatured: false, isPilgrimage: false)
        let dandeli = Place(id: 9, name: "Dandeli", imageName: "Dandeli", isFeatured: false, isPilgrimage: false)
        let jogFalls = Place(id: 10, name: "Jog Falls", imageName: "JogFalls", isFeatured: true, isPilgrimage: false)
        let kumaraParvatha = Place(id: 11, name: "Kumara Parvatha", imageName: "KumaraParvatha", isFeatured: true, isPilgrimage: false)
        let malpeBeach = Place(id: 12, name: "Malpe Beach", imageName: "Malpe_Beach", isFeatured: false, isPilgrimage: false)

        let kukke = Place(id: 13, name: "Kukke", imageName: "Kukke", isFeatured: false, isPilgrimage: true, details: "Subramanya Temple")
        let kollur = Place(id: 13, name: "Kollur", imageName: "kollur", isFeatured: false, isPilgrimage: true, details: "Mookambika Temple")
        let dharmastala = Place(id: 13, name: "Dharamastala", imageName: "dharamastala", isFeatured: false, isPilgrimage: true, details: "Manjunatha Temple")

        let badami = Place(id: 14, name: "Badami", imageName: "badami", isFeatured: true, isPilgrimage: false)
        let kodachadri = Place(id: 15, name: "Kodachadri", imageName: "kodachadri", isFeatured: false, isPilgrimage: true)
        let mysore = Place(id: 16, name: "Mysore", imageName: "mysore", isFeatured: false, isPilgrimage: false)

        let placesArray = [udupi, pushpagiri, skandagiri, sringeri, dharmastala, tadiyandamol, yana, zPoint, barkanaFalls, dandeli, kukke, jogFalls, kumaraParvatha, malpeBeach, kollur, badami, kodachadri, mysore]

        return placesArray
    }

    func fetchAll() -> [Place]? {
        return places()
    }

    func fetchFeatured() -> [Place]? {
        return places().filter({ (place) -> Bool in
            place.isFeatured
        })
    }

    func fetchPiligrimage() -> [Place]? {
        return places().filter({ (place) -> Bool in
            place.isPilgrimage
        })
    }
}

class Place {
    var id: Int
    var name: String
    var imageName: String
    var isFeatured: Bool
    var isPilgrimage: Bool

    var details: String?

    init(id: Int, name: String, imageName: String, isFeatured: Bool, isPilgrimage: Bool) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.isFeatured = isFeatured
        self.isPilgrimage = isPilgrimage
    }

    convenience init(id: Int, name: String, imageName: String, isFeatured: Bool, isPilgrimage: Bool, details: String?) {
        self.init(id: id, name: name, imageName: imageName, isFeatured: isFeatured, isPilgrimage: isPilgrimage)
        self.details = details
    }
}
