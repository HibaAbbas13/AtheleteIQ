#!/bin/bash

# Wrapper script to run Flutter on macOS with x86_64 architecture
# This script intercepts xcodebuild calls and modifies the destination to use x86_64

# Function to intercept xcodebuild and modify destination
xcodebuild() {
    local args=("$@")
    local modified_args=()
    local found_destination=false
    
    for arg in "${args[@]}"; do
        if [[ "$arg" == *"arch:arm64"* ]] || [[ "$arg" == *"arch=arm64"* ]]; then
            # Replace arm64 with x86_64
            modified_args+=("${arg//arm64/x86_64}")
            found_destination=true
        elif [[ "$arg" == "-destination" ]] && [[ "${args[$((i+1))]}" == *"arch:arm64"* ]]; then
            # Handle -destination flag followed by destination specifier
            modified_args+=("$arg")
            found_destination=true
        else
            modified_args+=("$arg")
        fi
    done
    
    # If we found arm64, use modified args, otherwise use original
    if [ "$found_destination" = true ]; then
        /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild "${modified_args[@]}"
    else
        /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild "$@"
    fi
}

export -f xcodebuild

# Run Flutter with the modified xcodebuild
cd "$(dirname "$0")"
flutter run -d macos "$@"

