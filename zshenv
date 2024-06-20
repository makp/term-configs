# -*-conf-*-
# This file is sourced in all ZSH instances, including every
# interactive and non-interactive shells.

# Load .zsh_private if it exists
if [[ -f ~/.zsh_private ]]; then
	source ~/.zsh_private
fi

# Set PATH
# `/usr/bin/vendor_perl`: biber
PATH="$PATH:/usr/bin/vendor_perl:$HOME/scripts/myscripts:$HOME/config-files/general/term-configs/scripts:"
if [ -d /opt/cuda/bin ]; then
	PATH="$PATH:/opt/cuda/bin"
fi
export PATH

# Set default editors for ZSH
# EDITOR is for programs that expect a line editor. VISUAL is for
# screen-oriented programs.
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export ALTERNATE_EDITOR=vim

# Set CDPATH for completion
# The nullstring "::" forces cd to search in the working directory
# This is important because, without it, cd will only search the working
# directory after the other directories in CDPATH fails.
# export CDPATH=$HOME
export CDPATH=::$HOME/Documents/mydocs/:

# Git
export GIT_AUTHOR_NAME="mak-$(hostname)"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"

# AI models
export OPENAI_BASIC='gpt-3.5-turbo'
export OPENAI_ADVANCED='gpt-4o'

# CUDA vars
if command -v nvcc >/dev/null 2>&1; then
	export NVCC_PREPEND_FLAGS='-ccbin /opt/cuda/bin'
	export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
	export CUDA_VISIBLE_DEVICES=0
fi

# ssh-agent socket
# The ssh-agent should have been started as a systemd user unit
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
