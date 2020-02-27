include("fruples.jl")

struct Apple{𝒯, 𝒮, 𝒰, 𝒱} <: AbstractFruit{𝒯}
    nutritional_information::𝒯
    delicious::𝒮
    nutricious::𝒰
    eaten::𝒱
end

struct Banana{𝒯, 𝒮, 𝒰, 𝒱, 𝒲} <: AbstractFruit{𝒯}
    nutritional_information::𝒯
    delicious::𝒮
    nutricious::𝒰
    eaten::𝒱
    peeled::𝒲
end

struct Amazing end    # Yes this is nutritional information
struct NotAmazing end # Yes this is nutritional information

# Test 1: Fruitbowls
🍏 = Apple(Amazing(), true, true, true)
🍌 = Banana(Amazing(), true, true, true, true)
🍏🍌 = 🍏+🍌
🍌🍏 = 🍌+🍏
fruit_bowl = 🍏🍌 + 🍌🍏 + 🍏🍌
fruit_bowl = fruit_bowl + 🍏
fruit_bowl = 🍌 + fruit_bowl

# Test 2: Irreconcilable Differences
🍎 = Apple(NotAmazing(), false, true, false)
🍌 = Banana(Amazing(), true, true, true, true)
# 🍎🍌 = 🍎+🍌

# Test 3:
🍎 = Apple(NotAmazing(), false, true, false)
🍌 = Banana(Amazing(), true, true, true, true)
🍏 = Apple(Amazing(), true, true, true)

🍌🍌 = 🍌+🍌
🍏🍌 = 🍏+🍌
🍎🍎 = 🍎+🍎

# Should work
good_fruit_bowl = 🍏🍌 + 🍏🍌
not_good_fruit_bowl = 🍎🍎 + 🍎🍎
good_fruit_bowl += good_fruit_bowl

# Should not work
# not_good_fruit_bowl + good_fruit_bowl

# Test 4: Smoothies
🍌 = Banana(Amazing(), true, true, true, true)
🍹 = 🍌*🍌
