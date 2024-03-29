# Clean, simple, compatible and meaningful.
# It is recommended to use with a dark background.
#
# This theme is a purple variant of the popular `ys` theme.
# The color scheme is (partly) inspired by Spacemacs.
# Enjoy!

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$reset_color%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}v"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# Local color vars
eval median_purple='$terminfo[bold]$FG[098]'
eval corn_flower_blue='$FG[069]'
eval orchid_bold='$terminfo[bold]$FG[170]'

# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % ys @ ys-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $
PROMPT="
%{$terminfo[bold]$fg[blue]%}>%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},$orchid_bold%n%{$reset_color%}) \
@ $median_purple%m%{$reset_color%} in \
$corn_flower_blue%~%{$reset_color%}\
${hg_info}\
${git_info}\
 \
%{$reset_color%}[%*] $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
