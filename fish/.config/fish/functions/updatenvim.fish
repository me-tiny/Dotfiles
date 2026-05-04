function updatenvim -d "build nvim from source"
    # make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/"
    set -l repo_url "git@github.com:neovim/neovim"
    set -l install_prefix "/usr/"
    set -l build_type "Release"
    set -l extra_flags "-DCMAKE_INSTALL_PREFIX=$install_prefix"

    set -l sudo_cmd ""
    if test (id -u) -ne 0
        if command -v sudo >/dev/null
            set sudo_cmd "sudo"
            echo "sudo privileges needed for $install_prefix"
            $sudo_cmd -v
        else
            echo "error: sudo required but not found"
            return 1
        end
    end

    set -l tmp_dir (mktemp -d -t nvim_build_XXXXXX)

    function _cleanup_nvim_build --on-variable PWD --inherit-variable tmp_dir
        if not string match -q "$tmp_dir*" "$PWD"
            test -d "$tmp_dir"; and rm -rf "$tmp_dir"
            functions -e _cleanup_nvim_build
        end
    end

    echo "cloning nvim into $tmp_dir"
    if not git clone --depth 1 $repo_url $tmp_dir
        echo "error: failed to clone repo"
        return 1
    end

    pushd $tmp_dir

    echo "building nvim ($build_type)"
    if not make CMAKE_BUILD_TYPE=$build_type CMAKE_EXTRA_FLAGS=$extra_flags
        echo "error: build failed"
        popd
        return 1
    end

    echo "installing to $install_prefix"
    if not $sudo_cmd make install
        echo "error: install failed"
        popd
        return 1
    end
    popd
    echo "done! nvim built from source into $install_prefix"
end
