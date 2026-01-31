#!/bin/bash

# Function to show usage
show_usage() {
    echo "Usage: $0 [-d|-p|-D|-P]"
    echo "  -d, -D  Development environment"
    echo "  -p, -P  Production environment"
    echo ""
    echo "Or run interactively without flags:"
    echo "  $0"
    exit 1
}

# Parse command line arguments
ENV_TYPE=""

while getopts ":dDpPh" opt; do
    case $opt in
        d|D)
            ENV_TYPE="dev"
            ;;
        p|P)
            ENV_TYPE="prod"
            ;;
        h)
            show_usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            show_usage
            ;;
    esac
done

# Install uv if not already installed
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Create virtual environment
uv venv venv

# Activate virtual environment
source venv/bin/activate

# If no flag provided, ask interactively
if [ -z "$ENV_TYPE" ]; then
    echo "Development / Production [D/d/P/p]?"
    read VAR
    
    case "$VAR" in
        [Dd])
            ENV_TYPE="dev"
            ;;
        [Pp])
            ENV_TYPE="prod"
            ;;
        *)
            echo "Please choose from [D/d/P/p]"
            exit 1
            ;;
    esac
fi

# Install dependencies based on environment
if [[ "$ENV_TYPE" == "dev" ]]; then
    echo "Setting up Development environment..."
    uv pip install -r pyproject.toml --extra dev
elif [[ "$ENV_TYPE" == "prod" ]]; then
    echo "Setting up Production environment..."
    uv pip install -r pyproject.toml --extra prod
fi

echo ""
echo "Setup complete! To activate the environment, run:"
echo "source venv/bin/activate"
