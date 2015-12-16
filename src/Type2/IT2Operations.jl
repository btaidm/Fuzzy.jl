
abstract IT2Operation <: IntervalType2FuzzySet


#############################
# Interection of 2 Membership Functions
immutable IT2IntersectOP <: IT2Operation
    t1::IntervalType2FuzzySet
    t2::IntervalType2FuzzySet
end
# export IT2IntersectOP

import Base: getindex
function getindex(op::IT2IntersectOP, value::Real)
	o1 = op.t1[value]
	o2 = op.t2[value]
	(tnorm(o1[1], o2[1]),tnorm(o1[2], o2[2]))
end
export getindex

# Union of 2 Membership Functions
immutable IT2UnionOP <: IT2Operation
    t1::IntervalType2FuzzySet
    t2::IntervalType2FuzzySet
end
# export IT2UnionOP

import Base: getindex
function getindex(op::IT2UnionOP, value::Real)
	o1 = op.t1[value]
	o2 = op.t2[value]
	(tconorm(o1[1], o2[1]),tconorm(o1[2], o2[2]))
end
export getindex

# Complement of 
immutable IT2ComplementOP <: IT2Operation
    t1::IntervalType2FuzzySet
end
import Base: getindex
function getindex(op::IT2ComplementOP, value::Real)
	o = op.t1[value]
	(1.0 - o[2],1.0 - o[1])
end
export getindex
# export IT2ComplementOP

Base.complement(mf::IntervalType2FuzzySet) = IT2ComplementOP(mf)
export complement

Base.intersect(mf::IntervalType2FuzzySet, mfs::IntervalType2FuzzySet...) = intersect(IT2IntersectOP(mf,mfs[1]),mfs[2:end]...)
Base.intersect(mf::IntervalType2FuzzySet, mf1::IntervalType2FuzzySet) = IT2IntersectOP(mf,mf1)
export intersect

Base.union(mf::IntervalType2FuzzySet, mfs::IntervalType2FuzzySet...) = union(IT2UnionOP(mf,mfs[1]),mfs[2:end]...)
Base.union(mf::IntervalType2FuzzySet, mf1::IntervalType2FuzzySet) = IT2UnionOP(mf,mf1)
export union

