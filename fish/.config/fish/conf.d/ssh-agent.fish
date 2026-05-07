if not set -q SSH_CONNECTION
    set -gx SSH_AUTH_SOCK $HOME/.1password/agent.sock
end
