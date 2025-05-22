#!/bin/bash

# Detect package manager
detect_pkg_mgr() {
    if command -v apt &> /dev/null; then
        PKG_MGR="apt"
        INSTALL_CMD="sudo apt update && sudo apt install -y"
        QUERY_CMD="apt-cache show"
    elif command -v dnf &> /dev/null; then
        PKG_MGR="dnf"
        INSTALL_CMD="sudo dnf install -y"
        QUERY_CMD="dnf info"
    elif command -v pacman &> /dev/null; then
        PKG_MGR="pacman"
        INSTALL_CMD="sudo pacman -Sy --noconfirm"
        QUERY_CMD="pacman -Si"
    else
        echo "❌ Unsupported package manager!"
        exit 1
    fi
}

# Check if a package is available in the repo
is_available() {
    $QUERY_CMD "$1" &> /dev/null
    return $?
}

# Check if a command exists (installed)
is_installed() {
    command -v "$1" &> /dev/null
}

# Check if Docker service is running
check_docker_service() {
    if systemctl is-active --quiet docker; then
        echo "✅ Docker service is running."
    else
        echo "❌ Docker service is NOT running."
    fi
}

# Install curl if not installed
install_curl_if_needed() {
    if ! is_installed curl; then
        echo "🔧 curl not installed. Installing..."
        $INSTALL_CMD curl
    else
        echo "✅ curl is already installed."
    fi
}

# Install Docker using curl
install_docker() {
    echo "📦 Installing Docker using official script..."
    curl -fsSL https://get.docker.com | sudo sh
}

# Main script
main() {
    detect_pkg_mgr

    echo "🔍 Using package manager: $PKG_MGR"

    # Check curl in repo
    if is_available curl; then
        echo "📦 curl is available in the repo."
    else
        echo "❌ curl not found in the repository."
        exit 1
    fi

    # Check docker in repo
    if is_available docker; then
        echo "📦 docker is available in the repo."
    else
        echo "⚠️ docker not found in your package repo."
    fi

    install_curl_if_needed

    if is_installed docker; then
        echo "✅ Docker is already installed."
        check_docker_service
    else
        echo "❌ Docker is not installed."
        install_docker
    fi
}

main
