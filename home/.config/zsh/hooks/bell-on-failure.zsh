# Print BEL when the previous command exits non-zero.
# Used with kitty custom_shaders that animate on visual bell.

autoload -Uz add-zsh-hook

_bell_on_failure_preexec() {
  _bell_ran=1
}

_bell_on_failure_precmd() {
  local exit_code=$?
  if [[ -n ${_bell_ran-} && $exit_code -ne 0 ]]; then
    printf '\a'
  fi
  unset _bell_ran
}

add-zsh-hook preexec _bell_on_failure_preexec
add-zsh-hook precmd _bell_on_failure_precmd
