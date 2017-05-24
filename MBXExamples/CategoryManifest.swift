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
    
    Category(title: "Getting started",
             description: "The basics of Mapbox maps",
             examples: [Example(title: "A simple map view", activity: SimpleMapActivity()),
                        Example(title: "Change a map's style", activity: SetStyleActivity())]),
    
    Category(title: "Annotations",
             description: "Draw markers and shapes on the map",
             examples: [Example(title: "Polygon", activity: PolygonActivity()),
                        Example(title: "Heat map", activity: HeatMapActivity()),
                        Example(title: "Draggable annotation", activity: DraggableCustomAnnotationActivity())]),

    Category(title: "Runtime Styling",
             description: "Runtime Styling & DDS",
             examples: [Example(title: "Query custom shapes", activity: QueryShapesActivity()),
                        Example(title: "Embed shape in style", activity: EmbeddedShapesActivity())]),
    
    Category(title: "Experimental",
             description: "Here be dragons",
             examples: [Example(title: "Style vector source layer", activity: StyleVectorSourceLayer())]),
    
]
