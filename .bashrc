alias ls="ls -G"

function build_my_bash_prompt() {
	local success_command="\`if [ \$? = 0 ]; then echo \e[32m✓\e[0m; else echo \e[31m✖\e[0m; fi\`"
	local command_id="\e[1;36m\!\e[33m:\e[36m\j\e[0m"
	local path="\e[33m$(shortpath -l 30 $PWD)\e[0m"
	local screensession=""

	if [ "$USER" = "root" ]; then
		local prompt="\e[31mroot›\e[0m"
		local prompt2="\e[31m›\e[0m"
	else
		local prompt="\e[32m›\e[0m"
		local prompt2="\e[32m›\e[0m"
	fi

	[[ $TERM =~ screen ]] && screensession="\e[31m(in screen)\e[0m "

	echo -ne "\033]0;${HOSTNAME}: ${PWD}\007"
	PS1="${success_command} ${command_id} ${path} ${screensession}${prompt} "
	PS2="${prompt2} "
}

PROMPT_COMMAND=build_my_bash_prompt
