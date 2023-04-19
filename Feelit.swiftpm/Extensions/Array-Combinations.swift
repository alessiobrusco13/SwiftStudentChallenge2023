import Foundation

extension Array {
    private func combinations(elements: ArraySlice<Element>, ofCount k: Int) -> [Self] {
        guard k != 0 else { return [[]] }
        guard let first = elements.first else { return [] }
        
        let head = [first]
        let subcombos = combinations(elements: elements, ofCount: k - 1)
        var output = subcombos.map { head + $0 }
        
        output += combinations(elements: elements.dropFirst(), ofCount: k)
        return output
    }
    
    func combinations(ofCount k: Int) -> [Self] {
        combinations(elements: ArraySlice(self), ofCount: k)
    }
}
