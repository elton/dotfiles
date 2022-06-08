export XDG_CONFIG_HOME
export XDG_CACHE_HOME
export XDG_DATA_HOME
export ZDOTDIR
export ZSH_CACHE_DIR

export DOTS="${HOME}/.dotfiles"
export DOTFILES="$DOTS"
export PRIVATES="${DOTS}/private"
export PROJECTS_DIR="${HOME}/code"
export PROJECTS="$PROJECTS_DIR"
export PERSONAL_PROJECTS_DIR="${PROJECTS_DIR}/personal"
export GIT_REPO_DIR="$PROJECTS_DIR"

# -- term
export TERM=${TERM:=xterm-kitty}
export TERM_ITALICS="TRUE"
export COLORTERM=${COLORTERM:=truecolor}
export TERMINAL="kitty"

# -- golang
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"

# -- rust/cargo
export CARGOPATH="$HOME/.cargo"
export CARGOBIN="$CARGOPATH/bin"
[ -f "$CARGOPATH/env" ] && . "$CARGOPATH/env"

# -- asdf
export ASDF_DIR="$HOME/.asdf"
export ASDF_SHIMS="$ASDF_DIR/shims"
export ASDF_BIN="$ASDF_SHIMS"
export ASDF_INSTALLS="$ASDF_DIR/installs"

# -- rg/ripgrep
# @see: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
if which rg >/dev/null; then
  export RIPGREP_CONFIG_PATH="${DOTS}/config/ripgrep/rc"
fi

case "$(uname)" in
  Darwin)
    PLATFORM="macos"
    export PLATFORM="macos"
    export ANDROID_SDK_ROOT="${HOME}/Library/Android/sdk/"
    # export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

    # Add LUA_PATH to the environment ensuring the lua version is set since
    # luarocks from homebrew uses lua 5.4 by default so would otherwise add the
    # wrong path
    if which luarocks >/dev/null; then
      eval "$(luarocks --lua-version=5.1 path)"
    fi

    export ICLOUD_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
    export DOCUMENTS_DIR="$ICLOUD_DIR/Documents"

    export BROWSER="open"
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export HOMEBREW_NO_INSTALL_CLEANUP=TRUE
    export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=FALSE
    export BREW_PATH="$HOMEBREW_PREFIX/Homebrew"
    export BREW_CASK_PATH="/opt/homebrew-cask/Caskroom"

    # FIXME:
    # THIS IS A MAJOR SLOWDOWN
    # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline)"

    export LIBARCHIVE=/usr/local/opt/libarchive/lib/libarchive.dylib
    export LIBCRYPTO=/usr/local/opt/openssl@1.1/lib/libcrypto.dylib

    # for libffi and ruby things
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/libffi/lib"
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl/lib"
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl@1.1/lib"
    export LDFLAGS="$LDFLAGS -I/usr/local/opt/openssl/include"

    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/libffi/include"
    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openssl@1.1/include"

    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /usr/local/opt/libffi/lib/pkgconfig"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH /usr/local/opt/openssl@1.1/lib/pkgconfig"

    export ERLANG_OPENSSL_PATH="/usr/local/opt/openssl@1.1"

    # REF: https://coletiv.com/blog/how-to-correctly-install-erlang-and-elixir
    if which brew >/dev/null; then
      export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac --with-ssl=$(brew --prefix openssl@1.1)"
    fi
  ;;
  Linux)
    PLATFORM="linux"
    export PLATFORM="linux"
    # Java -----------------------------------------------------------------------
    # Use Java 8 because -> https://stackoverflow.com/a/49759126
    # ------------------------------------------------------------------------
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    path+=(
      ${JAVA_HOME}/bin(N-/)
    )
    export BROWSER="xdg-open"

    if which lemonade >/dev/null; then
      export BROWSER="lemonade open"
    fi
  ;;
esac

# Set the the list of directories that cd searches.
cdpath=(
  $HOME/code
  $cdpath
)

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  ${HOMEBREW_PREFIX}/opt/*/libexec/gnuman(N-/)
  $manpath
)
for man_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$man_file))
done
unset man_file

# Set the list of directories that Zsh searches for programs.
# "${HOME}/.asdf/installs/elixir/`asdf current elixir | awk '{print $1}'`/.mix"
path=(
  ./bin
  ./.bin
  ./vendor/bundle/bin
  $HOME/bin
  $HOME/.bin
  ${HOME}/.local/bin(N-/)
  ${DOTS}/bin(N-/)
  $PRIVATES/bin
  $ASDF_DIR
  $ASDF_BIN
  $ASDF_SHIMS
  $ASDF_INSTALLS
  $ASDF_LUAROCKS
  # ${HOME}/neovim/bin(N-/)
  $GOBIN
  ${GOPATH}/bin(N-/)
  $CARGOPATH
  $CARGOBIN
  /usr/local/{bin,sbin}
  /usr/local/share/npm/bin
  /usr/local/lib/node_modules
  /usr/local/opt/libffi/lib
  /usr/local/opt/gnu-sed/libexec/gnubin
  # /usr/local/opt/imagemagick@6/bin
  # /usr/local/opt/qt@5.5/bin
  # /usr/local/opt/mysql@5.6/bin
  # /usr/local/opt/postgresql@9.5/bin
  # /Applications/Postgres.app/Contents/Versions/9.5/bin

  # /usr/local/opt/openssl@1.1/bin
  /usr/{bin,sbin}
  /{bin,sbin}

  ${HOMEBREW_PREFIX}/opt/curl/bin(N-/)
  ${HOMEBREW_PREFIX}/opt/openssl@*/bin(Nn[-1]-/)
  ${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin(N-/)
  ${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin(N-/)
  ${HOMEBREW_PREFIX}/opt/python@3.*/libexec/bin(Nn[-1]-/)
  ${HOMEBREW_CELLAR}/git/*/share/git-core/contrib/git-jump(Nn[-1]-/)

  ${CARGO_HOME}/bin(N-/)
  $HOME/.asdf/installs/rust/stable/bin

  ${GOBIN}(N-/)

  ${HOME}/Library/Python/3.*/bin(Nn[-1]-/)
  /usr/local/lib/python3.*/bin(Nn[-1]-/)
  /usr/local/lib/python3.*/site-packages(N-/)
  /usr/local/opt/python@3.*/bin(Nn[-1]-/)
  /usr/local/{bin,sbin}
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

fpath+=(
  $HOMEBREW_PREFIX/share/zsh/site-functions
  $ZDOTDIR/prompt
  $ZDOTDIR/completions
  $ZDOTDIR/plugins
  $ZDOTDIR/funcs
  ${ASDF_DIR}/completions
  $fpath
)
