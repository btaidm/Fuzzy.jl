# Fuzzy.jl
#

"""
Module for Fuzzy Sets and Logic
"""
module Fuzzy

doc"""
Defines the Abstract Type for Fuzzy Sets
"""
abstract AbstractFuzzySet
export AbstractFuzzySet


const global tnorm = min
const global tconorm = max

######################
# Type 1
include("./Type1/Type1.jl")
include("./Type1/Operations.jl")

######################
# Type 2
include("./Type2/Type2.jl")



end # module
