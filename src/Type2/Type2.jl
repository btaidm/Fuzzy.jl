
abstract Type2FuzzySet <: AbstractFuzzySet

#####################
abstract IntervalType2FuzzySet <: Type2FuzzySet
import Base: getindex

function getindex(mf::IntervalType2FuzzySet, range)
	out = hcat([[mf[value]::Tuple{Float64,Float64}...] for value in range]...)
	(out[1,:],out[2,:])
end

getindex(mf::IntervalType2FuzzySet, values...) = getindex(mf,[values...])

export getindex

#####################
# Interval 2 Membership Functions
immutable GaussType2 <: IntervalType2FuzzySet
	upper::GaussMF
	lower::GaussMF
	GaussType2(muU,muL,sigmaU,sigmaL) = new(GaussMF(muU,sigmaU),GaussMF(muL,sigmaL))
	GaussType2(upper,lower) = new(upper,lower)

end
export GaussType2

import Base: getindex
function getindex(mf::GaussType2, value::Real)
	m1 = (mf.lower.mu <= mf.upper.mu) ? mf.lower : mf.upper
	m2 = (mf.lower.mu > mf.upper.mu) ? mf.lower : mf.upper
	if m1.mu <= value <= (m1.mu+m2.mu)/2
		mu1 = 1
		mu2 = m2[value]
	elseif (m1.mu+m2.mu)/2 < value <= m2.mu
		mu1 = 1
		mu2 = m1[value]
	else
		mu1 = m1[value]
		mu2 = m2[value]
	end
	return (max(mu1,mu2),min(mu1,mu2))
end
export getindex

immutable TriangleType2 <: IntervalType2FuzzySet
	lower::TriangleMF
	upper::TriangleMF
	# TriangleType2(muU,muL,sigmaU,sigmaL) = new(GaussMF(muU,sigmaU),GaussMF(muL,sigmaL),muU,muL)
end
export TriangleType2

import Base: getindex
function getindex(mf::TriangleType2, value::Real)
	m1 = (mf.lower.b <= mf.upper.b) ? mf.lower : mf.upper
	m2 = (mf.lower.b > mf.upper.b) ? mf.lower : mf.upper
	if m1.b <= value <= (m1.b+m2.b)/2
		mu1 = 1
		mu2 = m2[value]
	elseif (m1.b+m2.b)/2 < value <= m2.b
		mu1 = 1
		mu2 = m1[value]
	else
		mu1 = m1[value]
		mu2 = m2[value]
	end
	return (max(mu1,mu2),min(mu1,mu2))
end
export getindex

#####################