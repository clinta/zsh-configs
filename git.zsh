gclone() {
    dir=$(echo $1 | sed 's/^http\(s*\):\/\///g' | sed 's/^git@//g' | sed 's/\.git$//g' | sed 's/:/\//g' )
    git clone $1 "$HOME/src/$dir"
    cd "$HOME/src/$dir"
}
