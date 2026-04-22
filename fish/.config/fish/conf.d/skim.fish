set -gx SKIM_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
set -gx SKIM_CTRL_T_COMMAND $SKIM_DEFAULT_COMMAND
set -gx SKIM_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

if status is-interactive
    skim_key_bindings
end
