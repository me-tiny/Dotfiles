# Rosé Pine theme for Tide prompt
# https://github.com/rose-pine/fish
#
# Automatically applies Rosé Pine colors to Tide prompt
# when a Rosé Pine fish theme is active.

type -q tide; or return 0

function _rose_pine_tide_pine --on-variable fish_color_pine
    set -q fish_color_pine[1]; or return 0
    set -l pine $fish_color_pine[1]
    set -gx tide_character_color $pine
    set -gx tide_status_color $pine
    set -gx tide_vi_mode_color_default $pine
    set -gx tide_git_color_branch $pine
    set -gx tide_git_color_staged $pine
    set -gx tide_go_color $pine
    set -gx tide_rustc_color $pine
    set -gx tide_distrobox_color $pine
    set -gx tide_toolbox_color $pine
end

function _rose_pine_tide_love --on-variable fish_color_love
    set -q fish_color_love[1]; or return 0
    set -l love $fish_color_love[1]
    set -gx tide_character_color_failure $love
    set -gx tide_status_color_failure $love
    set -gx tide_git_color_conflicted $love
    set -gx tide_context_color_root $love
    set -gx tide_direnv_color_denied $love
    set -gx tide_private_mode_color $love
end

function _rose_pine_tide_gold --on-variable fish_color_gold
    set -q fish_color_gold[1]; or return 0
    set -l gold $fish_color_gold[1]
    set -gx tide_cmd_duration_color $gold
    set -gx tide_jobs_color $gold
    set -gx tide_shlvl_color $gold
    set -gx tide_git_color_dirty $gold
    set -gx tide_git_color_operation $gold
    set -gx tide_aws_color $gold
    set -gx tide_ruby_color $gold
end

function _rose_pine_tide_foam --on-variable fish_color_foam
    set -q fish_color_foam[1]; or return 0
    set -l foam $fish_color_foam[1]
    set -gx tide_vi_mode_color_insert $foam
    set -gx tide_git_color_untracked $foam
    set -gx tide_nix_shell_color $foam
    set -gx tide_direnv_color $foam
    set -gx tide_node_color $foam
    set -gx tide_python_color $foam
    set -gx tide_bun_color $foam
    set -gx tide_gcloud_color $foam
    set -gx tide_docker_color $foam
end

function _rose_pine_tide_iris --on-variable fish_color_iris
    set -q fish_color_iris[1]; or return 0
    set -l iris $fish_color_iris[1]
    set -gx tide_os_color $iris
    set -gx tide_context_color_default $iris
    set -gx tide_context_color_ssh $iris
    set -gx tide_time_color $iris
    set -gx tide_vi_mode_color_visual $iris
    set -gx tide_pwd_color_dirs $iris
    set -gx tide_git_color_upstream $iris
    set -gx tide_git_color_stash $iris
    set -gx tide_kubectl_color $iris
    set -gx tide_terraform_color $iris
    set -gx tide_java_color $iris
    set -gx tide_elixir_color $iris
end

function _rose_pine_tide_rose --on-variable fish_color_rose
    set -q fish_color_rose[1]; or return 0
    set -l rose $fish_color_rose[1]
    set -gx tide_vi_mode_color_replace $rose
    set -gx tide_pwd_color_anchors $rose
    set -gx tide_php_color $rose
    set -gx tide_crystal_color $rose
    set -gx tide_zig_color $rose
    set -gx tide_pulumi_color $rose
end

function _rose_pine_tide_subtle --on-variable fish_color_subtle
    set -q fish_color_subtle[1]; or return 0
    set -l subtle $fish_color_subtle[1]
    set -gx tide_pwd_color_truncated_dirs $subtle
    set -gx tide_prompt_color_frame_and_connection $subtle
    set -gx tide_prompt_color_separator_same_color $subtle
end

_rose_pine_tide_pine
_rose_pine_tide_love
_rose_pine_tide_gold
_rose_pine_tide_foam
_rose_pine_tide_iris
_rose_pine_tide_rose
_rose_pine_tide_subtle
