
abstract Type1FuzzySet <: AbstractFuzzySet
export Type1FuzzySet

#####################
abstract Membershipfunction <: Type1FuzzySet
export Membershipfunction

import Base: getindex

getindex(mf::Membershipfunction, range::Range) = [mf[value] for value in range]

export getindex

#####################
# Membership Functions
"Triangle Membership Function"
type TriangleMF <: Membershipfunction
	a::Real
	b::Real
	c::Real
end
export TriangleMF

import Base: getindex
function getindex(trimf::TriangleMF, value::Real)
	(value <= trimf.a || trimf.c <= value) && return 0
	(value == trimf.b) && return 1

	if trimf.a < value < trimf.b
		slope = (1 - 0)/(trimf.b - trimf.a)
		return slope * (value - trimf.a)
	else
		slope = (0 - 1)/(trimf.c - trimf.b)
		return slope * (value - trimf.b) + 1
	end
end

export getindex


"Trapezoid Membership Function"
type TrapezoidMF <: Membershipfunction
	a::Real
	b::Real
	c::Real
	d::Real
end
export TrapezoidMF


import Base: getindex
function getindex(trapmf::TrapezoidMF, value::Real)
	(value <= trapmf.a || trapmf.d <= value) && return 0
	(trapmf.b < value < trapmf.c) && return 1

	if trapmf.a < value < trapmf.b
		slope = (1 - 0)/(trapmf.b - trapmf.a)
		return slope * (value - trapmf.a)
	else
		slope = (0 - 1)/(trapmf.d - trapmf.c)
		return slope * (value - trapmf.c) + 1
	end
end
export getindex
#####################