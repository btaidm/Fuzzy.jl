
abstract MFOperation <: Membershipfunction


#############################
# Interection of 2 Membership Functions
immutable T1IntersectOP <: MFOperation
    t1::Membershipfunction
    t2::Membershipfunction
end
# export T1IntersectOP

import Base: getindex
getindex(op::T1IntersectOP, value::Real) = tnorm(op.t1[value], op.t2[value])
export getindex

# Union of 2 Membership Functions
immutable T1UnionOP <: MFOperation
    t1::Membershipfunction
    t2::Membershipfunction
end
# export T1UnionOP

import Base: getindex
getindex(op::T1UnionOP, value::Real) = tconorm(op.t1[value], op.t2[value])
export getindex

# Complement of 
immutable T1ComplementOP <: MFOperation
    t1::Membershipfunction
end
import Base: getindex
getindex(op::T1ComplementOP, value::Real) = 1.0 - op.t1[value]
export getindex
# export T1ComplementOP

Base.complement(mf::Membershipfunction) = T1ComplementOP(mf)
export complement

Base.intersect(mf::Membershipfunction, mfs::Membershipfunction...) = intersect(T1IntersectOP(mf,mfs[1]),mfs[2:end]...)
Base.intersect(mf::Membershipfunction, mf1::Membershipfunction) = T1IntersectOP(mf,mf1)
export intersect

Base.union(mf::Membershipfunction, mfs::Membershipfunction...) = union(T1UnionOP(mf,mfs[1]),mfs[2:end]...)
Base.union(mf::Membershipfunction, mf1::Membershipfunction) = T1UnionOP(mf,mf1)
export union

