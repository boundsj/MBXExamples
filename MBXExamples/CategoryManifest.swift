import Foundation

struct Example {
    let title: String
    let activity: MapboxMapActivity
}

struct Category {
    let title: String
    let description: String
    let examples: [Example]
}

let categories = [
    
    Category(title: "Annotations",
             description: "Draw markers and shapes on the map",
             examples: [Example(title: "Polygon", activity: PolygonActivity())]),
    
    Category(title: "Camera",
             description: "Draw markers and shapes on the map",
             examples: [Example(title: "Animation", activity: PolygonActivity())])
    
]
