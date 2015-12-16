
abstract T1Operation <: Membershipfunction


#############################
# Interection of 2 Membership Functions
immutable IntersectOP <: T1Operation
    t1::Membershipfunction
    t2::Membershipfunction
end
# export IntersectOP

import Base: getindex
getindex(op::IntersectOP, value::Real) = tnorm(op.t1[value], op.t2[value])
export getindex

# Union of 2 Membership Functions
immutable UnionOP <: T1Operation
    t1::Membershipfunction
    t2::Membershipfunction
end
# export UnionOP

import Base: getindex
getindex(op::UnionOP, value::Real) = tconorm(op.t1[value], op.t2[value])
export getindex

# Complement of 
immutable ComplementOP <: T1Operation
    t1::Membershipfunction
end
import Base: getindex
getindex(op::ComplementOP, value::Real) = 1.0 - op.t1[value]
export getindex
# export ComplementOP

Base.complement(mf::Membershipfunction) = ComplementOP(mf)
export complement

Base.intersect(mf::Membershipfunction, mfs::Membershipfunction...) = intersect(IntersectOP(mf,mfs[1]),mfs[2:end]...)
Base.intersect(mf::Membershipfunction, mf1::Membershipfunction) = IntersectOP(mf,mf1)
export intersect

Base.union(mf::Membershipfunction, mfs::Membershipfunction...) = union(UnionOP(mf,mfs[1]),mfs[2:end]...)
Base.union(mf::Membershipfunction, mf1::Membershipfunction) = UnionOP(mf,mf1)
export union

