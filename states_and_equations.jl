include("fruples.jl")
# Behold the power of fruples

# Abstract Types
abstract type TimeScale end
abstract type AbstractPlanet end
abstract type AbstractBoundaryCondition end
abstract type AbstractBoundary end
abstract type AbstractOperator end

# Boundaries
struct OceanFloor   <: AbstractFruit{AbstractBoundary} end
struct CoastLine    <: AbstractFruit{AbstractBoundary} end
struct OceanSurface <: AbstractFruit{AbstractBoundary} end

# Type of Ocean
struct AbstractOcean <: AbstractPlanet
struct AquaOcean <: AbstractOcean end

# Timescales
struct Slow{𝒮} <: TimeScale
    rate::𝒮
end

struct Fast{𝒮} <: TimeScale
    rate::𝒮
end

# Boundary Conditions
struct NoSlip <: AbstractFruit{AbstractBoundaryCondition} end
struct FreeSlip <: AbstractFruit{AbstractBoundaryCondition} end
struct Wave <: AbstractFruit{AbstractBoundaryCondition} end

# Field Signature
struct Signature{𝒮, 𝒯, 𝒰, 𝒱} <: AbstractFruitSignature
    time_scale::𝒮
    domain_space::𝒯
    range_space::𝒰
    model::𝒱
end

# Field Definition
struct Field{𝒯, 𝒮, 𝒰} <: AbstractFruit{𝒯}
    signature::𝒯
    state::𝒮
    boundary_condition::𝒰
end

# Boundary Struct
struct Boundary{𝒯} <: AbstractFruit{𝒯}
    bc::𝒯
end

# Operators
struct AbstractGradient <: AbstractFruit{AbstractOperator}
struct AbstractIntegral <: AbstractFruit{AbstractOperator}

struct Gradient{𝒯} <: AbstractGradient
    label::𝒯
end

struct Integral{𝒯} <: AbstractIntegral
    label::𝒯
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
