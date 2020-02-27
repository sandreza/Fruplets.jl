include("fruples.jl")

struct Apple{𝒯, 𝒮, 𝒰, 𝒱} <: AbstractFruit{𝒯}
    structure::𝒯
    delicious::𝒮
    nutricious::𝒰
    eaten::𝒱
end

struct Banana{𝒯, 𝒮, 𝒰, 𝒱, 𝒲} <: AbstractFruit{𝒯}
    structure::𝒯
    delicious::𝒮
    nutricious::𝒰
    eaten::𝒱
    peeled::𝒲
end

struct Amazing end
struct NotAmazing end

🍎 = Apple(Amazing(), false, true, true)
🍌 = Banana(Amazing(),true,true,true, true)
🍎🍌 = 🍎+🍌

fruit_bowl = 🍎🍌 + 🍎🍌 + 🍎🍌

fruit_bowl = fruit_bowl + 🍎
