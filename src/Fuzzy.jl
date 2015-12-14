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

######################
# Type 1
include("./Type1/Type1.jl")


######################
# Type 2
include("./Type2/Type2.jl")



end # module
