include("fruples.jl")

abstract type TimeScale end
abstract type AbstractOcean end
abstract type AbstractBoundaryCondition end
abstract type AbstractBoundary end
abstract type AbstractBoundaryPair end

struct OceanFloor   <: AbstractFruit{AbstractBoundary} end
struct CoastLine    <: AbstractFruit{AbstractBoundary} end
struct OceanSurface <: AbstractFruit{AbstractBoundary} end

struct AquaOcean <: AbstractOcean end

struct Slow{𝒮} <: TimeScale
    rate::𝒮
end

struct Fast{𝒮} <: TimeScale
    rate::𝒮
end

struct NoSlip <: AbstractFruit{AbstractBoundaryCondition} end
struct FreeSlip <: AbstractFruit{AbstractBoundaryCondition} end
struct Wave <: AbstractFruit{AbstractBoundaryCondition} end



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

struct Boundary{𝒯} <: AbstractFruit{𝒯}
    bc::𝒯
end


signature = Signature(Slow(0.1), 3, 3, AquaOcean())

data = randn((3,3)) .* 1.0
data2 = randn((3,3)) .* 1.0

pear = OceanFloor() + NoSlip()
boundary_pears = Boundary(pear)
pear = OceanSurface() + Wave()
boundary_pears += Boundary(pear)
pear = CoastLine() + FreeSlip()
boundary_pears += Boundary(pear)

field =  Field(signature, data , boundary_pears)
field2 = Field(signature, data , boundary_pears)

fields = field+field2+field

field_combos1 = field * field * field2
field_combos2 = field2 * field * field

field_combos1 + field_combos2


function Field(x::AbstractArray; timescale = Slow(1.0), planet = AquaOcean(), boundary_pear = Boundary(OceanFloor() + NoSlip()))
    signature = Signature(timescale, size(data)..., planet)
    return Field(signature, x, boundary_pear)
end

function get_data(x::Field{𝒮,𝒯,𝒱}) where {𝒮, 𝒯 <: AbstractArray, 𝒱}
    return x.state
end

tmp = Field(data)

get_data(tmp)
