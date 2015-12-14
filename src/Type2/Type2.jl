
abstract Type2FuzzySet <: FuzzySet

type IntervalType2FuzzySet <: Type2FuzzySet
	lowerBound::Membershipfunction
	upperBound::Membershipfunction
end
