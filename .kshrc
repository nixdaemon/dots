# test for an interactive shell.  there is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# shell is non-interactive.  be done now!
	return
fi


# enable prompt history
HISTFILE="$HOME/.ksh_history"
HISTSIZE="500"

# set up the prompt to print CWD
PS1="\u@\H \W "

# aliases
alias rsfetch="rsfetch -B -b -c -l -N -P -r -k -s -t -e -p portage"
alias ls="ls -l"
