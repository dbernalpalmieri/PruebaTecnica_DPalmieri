import Foundation

struct Element{
    let id : Int
    let title : String
    var market : Bool
    var cells : [Cell]
}

struct Cell{
    let id: Int
    let title :String
}
