import Foundation

struct Example {
    let title: String
}

struct Category {
    let title: String
    let description: String
    let examples: [Example]
}

let categories = [
    
    Category(title: "Annotations",
             description: "Draw markers and shapes on the map",
             examples: [Example(title: "Polygon")]),
    
    Category(title: "Camera",
             description: "View and move around the map",
             examples: [Example(title: "Animation")]),
    
]
