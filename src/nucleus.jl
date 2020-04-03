module nucleus

greet() = print("Hello World!")

const ranks = Set([:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine,
                   :ten, :jack, :queen, :king])
const suits = Set([:♣, :♦, :♥, :♠])

struct Card
    rank::Symbol
    suit::Symbol
    function Card(r::Symbol, s::Symbol)
        r in ranks || throw(ArgumentError("invalid rank: $r"))
        s in suits || throw(ArgumentError("invalid suit: $s"))
        new(r, s)
    end
end

end # module
