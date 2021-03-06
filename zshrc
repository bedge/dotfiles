[ "$DEBUG" ] && echo $0 start

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"


# Use this instead of antipattern PATH=/usr/xxx:$PATH
addPath() {
  for p in $* ; do
    if [ ! -e $p ] ; then
        echo "PATH: $1 not found" > /dev/null
    else
        if [[ $PATH = *"$p"* ]] ; then
            # [ "$DEBUG" ] && echo "PATH: replace $p"
            export PATH=$p:$(echo $PATH | sed -e "s,$p:,," | sed -e "s,:$p,,g")
            # [ "$DEBUG" ] && echo "PATH=$PATH"
        else
            # [ "$DEBUG" ] && echo "PATH: append: $p"
            export PATH=$p:$(echo $PATH | sed -e "s,:$p,,g")
        fi
    fi
  done
    # de-dup path
    typeset -aU path
}

# RipGrep History search
rgh() {
  rg $@ ~/.history
}

# OS config
[ -f ~/.zshrc_$(uname) ] && source ~/.zshrc_$(uname)

# Local config
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# aliases
[ -f ~/.aliases ] && source ~/.aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# environment
[ -f ~/.env ] && source ~/.env

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Two regular plugins loaded without tracking.
zinit light zsh-users/zsh-autosuggestions
# zinit light zdharma/fast-syntax-highlighting

# Plugin history-search-multi-word loaded with tracking.
zinit load zdharma/history-search-multi-word

# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is actually not needed, Zinit will
# grep operating system name and architecture automatically when there's no `bpick'.
zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"
zinit load docker/compose

# Vim repository on GitHub – a typical source code that needs compilation – Zinit
# can manage it for you if you like, run `./configure` and other `make`, etc. stuff.
# Ice-mod `pick` selects a binary program to add to $PATH. You could also install the
# package under the path $ZPFX, see: http://zdharma.org/zinit/wiki/Compiling-programs
zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
    atpull"%atclone" make pick"src/vim"
zinit light vim/vim

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target.
zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# Handle completions without loading any plugin, see "clist" command.
# This one is to be ran just once, in interactive session.
# zinit creinstall %HOME/my_completions

# TODO
# https://github.com/zdharma/zui/
# zinit wait lucid for zinit-zsh/zinit-console

# # terraform -install-autocomplete
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/terraform terraform

# #  Ignored
# # # https://github.com/aws/aws-cli/issues/4656
# complete -C '/usr/local/bin/aws_completer' aws
# # No brew:
# # https://github.com/drgr33n/oh-my-zsh_aws2-plugin
# # zinit load drgr33n/oh-my-zsh_aws2-plugin

# Disable hosts ssh completion
zstyle ':completion:*:ssh:*' hosts off

# Menu selection
zstyle ':completion:*' menu yes select

# fast syntax highlighting
# https://github.com/zdharma/fast-syntax-highlighting
source ~/git/oss/zsh/fast-syntax-highlighting.plugin.zsh
zinit light zdharma/fast-syntax-highlighting

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# LS_COLORS
. ~/.local/share/lscolors.sh

# https://zdharma.org/zinit/wiki/LS_COLORS-explanation/
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS


# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

eval "$(pyenv init -)"
eval "$(rbenv init -)"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# De-dupe fpath
typeset -aU fpath


[ "$DEBUG" ] && echo $0 end
