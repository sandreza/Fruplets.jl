abstract type AbstractFruit{𝒯} end
abstract type AbstractFruitCombo end

import Base: +, *, /, -
import LinearAlgebra: ⋅

# A tuple of fruits (fruitbowl)
struct Fruple{N, 𝒯} <: AbstractFruitCombo
    fruits::NTuple{N, AbstractFruit{𝒯}}
end

struct Smoothie{𝒯, N} <: AbstractFruit{𝒯}
    fruits::NTuple{N, AbstractFruit{𝒯}}
end

function *(🍎::AbstractFruit{𝒯}, 🍌::AbstractFruit{𝒯}) where 𝒯
    return Smoothie{𝒯, 2}((🍎, 🍌))
end

function +(🍎::AbstractFruit{𝒯}, 🍌::AbstractFruit{𝒯}) where 𝒯
    return Fruple{2, 𝒯}((🍎,🍌))
end

function +(🍎🍎::Fruple{N, 𝒯}, 🍌🍌::Fruple{M, 𝒯}) where {N, M, 𝒯}
    return Fruple{N + M, 𝒯}((🍎🍎.fruits..., 🍌🍌.fruits...))
end

function +(🍎::AbstractFruit{𝒯}, 🍎🍌::Fruple{M, 𝒯}) where {M, 𝒯}
    return Fruple{1 + M, 𝒯}((🍎🍌.fruits..., 🍎))
end

function +(🍎🍌::Fruple{M, 𝒯}, 🍎::AbstractFruit{𝒯}) where {M, 𝒯}
    return Fruple{1 + M , 𝒯}((🍎🍌.fruits..., 🍎))
end
