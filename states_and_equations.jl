include("fruples.jl")

abstract type TimeScale end
abstract type AbstractOcean end
abstract type AbstractBoundaryCondition end
abstract type AbstractBoundary end

struct OceanFloor <: AbstractBoundary
struct CoastLine <: AbstractBoundary
struct OceanSurface <: AbstractBoundary

struct AquaOcean <: AbstractOcean end

struct Slow{𝒮} <: TimeScale
    rate::𝒮
end

struct Fast{𝒮} <: TimeScale
    rate::𝒮
end

struct Diriclet{𝒮} <: AbstractBoundaryCondition

end

struct Signature{𝒮, 𝒯, 𝒰, 𝒱} <: AbstractFruitSignature
    time_scale::𝒮
    domain_space::𝒯
    range_space::𝒰
    model::𝒱
end

struct Field{𝒯, 𝒮, 𝒰} <: AbstractFruit{𝒯}
    signature::𝒯
    state::𝒮
    boundary_condition::𝒰
end

signature = Signature(Slow(0.1), 3, 3, AquaOcean())


field_type = Field(signature, randn((3,3)) .* 1.0, )
