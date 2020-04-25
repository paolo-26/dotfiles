#!/usr/bin/env bash
# Created by camfowler
# Create new folder in ~/.vim/pack that contains a start folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group syntax-highlighting
#
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group/start"
  mkdir -p "$path"
  cd "$path" || exit
}

# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url=$1
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
}

(
set_group plugins
package https://github.com/tpope/vim-fugitive &
package https://github.com/ervandew/supertab &
package https://github.com/tmhedberg/SimpylFold &
package https://github.com/nvie/vim-flake8.git & 
package https://github.com/nelstrom/vim-markdown-preview.git &
package https://github.com/suan/vim-instant-markdown.git &
package https://github.com/jtratner/vim-flavored-markdown.git &
package https://github.com/vim-scripts/indentpython.vim.git &
package https://github.com/ap/vim-css-color &

package https://github.com/preservim/nerdtree &
package https://github.com/Xuyuanp/nerdtree-git-plugin.git &
#package https://github.com/jistr/vim-nerdtree-tabs.git &

package https://github.com/itchyny/lightline.vim &
package https://github.com/severin-lemaignan/vim-minimap &

wait
) &

(
set_group plugins
package https://github.com/vim-syntastic/syntastic &
wait
) &

(
set_group plugins
package https://github.com/jnurmine/Zenburn &
wait
) &

wait
