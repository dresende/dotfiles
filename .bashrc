alias ls="ls -G"

# autho: Tiago Batista
function __shortpath3 {
	local pathName=${1%?}

	if [[ 3 -gt $2 ]]; then
		#the caller screwed up, do not modify anything!
		echo  $1
	else
		if [[ ${#pathName} -gt $2 ]]; then
			len=$2-1
			echo ${pathName:0:$len}"…/"
		else
			echo $1
		fi
	fi
}

# autho: Tiago Batista
function _dir_chomp () {
	local p=${1/#$HOME/\~} b s

	s=${#p}
	while [[ $p != ${p//\/} ]]&&(($s>$2))
	do
		[[ $p =~  [^/]*/ ]]
		short=$(__shortpath3 "${BASH_REMATCH[0]}" 4)
		b=$b$short
		p=${p#*/}
		((s=${#b}+${#p}))

	done

	echo ${b/\/~/\~}${b+}$p

}

function build_my_bash_prompt() {
	local success_command="\`if [ \$? = 0 ]; then echo \e[32m✓\e[0m; else echo \e[31m✖\e[0m; fi\`"
	local command_id="\e[1;36m\!\e[33m:\e[36m\j\e[0m"
	local path="\e[33m$(_dir_chomp "${PWD}" 30)\e[0m"
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

	shopt -s checkwinsize
}

PROMPT_COMMAND=build_my_bash_prompt
