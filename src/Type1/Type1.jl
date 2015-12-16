
abstract Type1FuzzySet <: AbstractFuzzySet
export Type1FuzzySet

#####################
abstract Membershipfunction <: Type1FuzzySet
export Membershipfunction

import Base: getindex

getindex(mf::Membershipfunction, range) = [mf[value]::Float64 for value in range]
getindex(mf::Membershipfunction, values...) = [mf[value]::Float64 for value in values]

export getindex

#####################
# Membership Functions
"Triangle Membership Function"
immutable TriangleMF <: Membershipfunction
	a::Float64
	b::Float64
	c::Float64

	TriangleMF(a,b,c) = a <= b <= c ? new(a,b,c) : error("Indices out of order")
end
export TriangleMF

import Base: getindex
function getindex(trimf::TriangleMF, value::Real)
	(value <= trimf.a || trimf.c <= value) && return zero(Float64)
	(value == trimf.b) && return one(Float64)

	if trimf.a < value < trimf.b
		slope = (1.0 - 0.0)/(trimf.b - trimf.a)
		return slope * (value - trimf.a)
	else
		slope = (0.0 - 1.0)/(trimf.c - trimf.b)
		return (slope * (value - trimf.b) + 1.0)
	end
end
export getindex



"Trapezoid Membership Function"
immutable TrapezoidMF <: Membershipfunction
	a::Float64
	b::Float64
	c::Float64
	d::Float64
end
export TrapezoidMF


import Base: getindex
function getindex(trapmf::TrapezoidMF, value::Real)
	(value <= trapmf.a || trapmf.d <= value) && return zero(Float64)
	(trapmf.b <= value <= trapmf.c) && return one(Float64)

	if trapmf.a < value < trapmf.b
		slope = (1 - 0)/(trapmf.b - trapmf.a)
		return slope * (value - trapmf.a)
	else
		slope = (0 - 1)/(trapmf.d - trapmf.c)
		return slope * (value - trapmf.c) + 1
	end
end
export getindex


"Generic Membership Function"
immutable GenericMF <: Membershipfunction
	mf::Function
end
export GenericMF

import Base: getindex
function getindex(gmf::GenericMF, value::Real)
	gmf.mf(value)
end
export getindex

immutable GaussMF <: Membershipfunction
	mu::Float64
	sigma::Float64
end
export GaussMF
immutable GaussMF <: Membershipfunction
	mu::Float64
	sigma::Float64
end
export GaussMF

import Base: getindex
function getindex(gmf::GaussMF, value::Real)
	GenericMF(x -> exp(-(x-gmf.mu).^2/(2.*gmf.sigma.^2)))[value]
end
export getindex


#####################