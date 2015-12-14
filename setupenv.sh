export FUZZY_LOAD_PATH=$JULIA_LOAD_PATH

[[ -n $JULIA_LOAD_PATH ]] && JULIA_LOAD_PATH="$(pwd)/..:$JULIA_LOAD_PATH" || JULIA_LOAD_PATH="$(pwd)/.."

export JULIA_LOAD_PATH

type prompt_tag > /dev/null && prompt_tag "[Fuzzy.jl]"

function resetfuzzyenv () {
	export JULIA_LOAD_PATH=$FUZZY_LOAD_PATH
	unset FUZZY_LOAD_PATH
	type prompt_tag > /dev/null && prompt_tag
	unfunction resetfuzzyenv
}