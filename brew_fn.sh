#!/bin/bash


brew_cask_install_ignoring_sha256() {
    local TOOL_NAME=$1

    CASK_DIR="$(brew --repo homebrew/cask)/Casks"
    chmod a+w "$CASK_DIR/$TOOL_NAME.rb"
    SHA=$(grep "sha256" "$CASK_DIR/$TOOL_NAME.rb" | awk '{print $2}')
    sed -i '' "s/$SHA/:no_check/" "$CASK_DIR/$TOOL_NAME.rb"
    brew install --cask $TOOL_NAME
    pushd $CASK_DIR
    git checkout HEAD -- "$TOOL_NAME.rb"
    popd
}

get_brew_os_keyword() {
    if is_Catalina; then
        echo "catalina"
    elif is_BigSur; then
        echo "big_sur"
    elif is_Monterey; then
        echo "monterey"
    else
        echo "null"
    fi
}

should_build_from_source() {
    local tool_name=$1
    local os_name=$2
    local tool_info=$(brew info --json=v1 $tool_name)
    local bottle_disabled=$(echo "$tool_info" | jq ".[0].bottle_disabled")

    # No need to build from source if a bottle is disabled
    # Use the simple 'brew install' command to download a package
    if $bottle_disabled; then
        echo "false"
        return
    fi

    local tool_bottle=$(echo "$tool_info" | jq ".[0].bottle.stable.files.$os_name")
    if [[ "$tool_bottle" == "null" ]]; then
        echo "true"
        return
    else
        echo "false"
        return
    fi
}

# brew provides package bottles for different macOS versions
# The 'brew install' command will fail if a package bottle does not exist
# Use the '--build-from-source' option to build from source in this case
brew_smart_install() {
    local tool_name=$1
    
    local os_name=$(get_brew_os_keyword)
    if [[ "$os_name" == "null" ]]; then
        echo "$OSTYPE is unknown operating system"
        exit 1
    fi

    local build_from_source=$(should_build_from_source "$tool_name" "$os_name")
    if $build_from_source; then
        echo "Bottle of the $tool_name for the $os_name was not found. Building $tool_name from source..."
        brew install --build-from-source $tool_name
    else
        echo "Downloading $tool_name..."
        brew install $tool_name
    fi
}