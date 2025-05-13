#!/bin/bash
#TUI ssh_manager like Putty by zsh_ncursed

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

CONFIG_FILE="$HOME/.ssh_manager.conf"

# Check SSH availability
if ! command -v ssh &> /dev/null; then
    echo -e "${RED}Error: SSH client is not installed${NC}"
    exit 1
fi

# Create config if it doesn't exist
initialize_config() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        touch "$CONFIG_FILE"
        echo -e "${GREEN}New configuration file created${NC}"
    fi
}

# Display menu
show_menu() {
    clear
    echo -e "${BLUE}┌──────────────────────────────────────┐${NC}"
    echo -e "${BLUE}│       ${YELLOW}TUI SSH Manager         ${BLUE}       │${NC}"
    echo -e "${BLUE}└──────────────────────────────────────┘${NC}"
    echo -e "${YELLOW}1)${NC} Connect to server"
    echo -e "${YELLOW}2)${NC} Add profile"
    echo -e "${YELLOW}3)${NC} Delete profile"
    echo -e "${YELLOW}4)${NC} Exit"
    echo -e "${BLUE}────────────────────────────────────────${NC}"
}

# List profiles
list_profiles() {
    echo -e "${GREEN}Saved profiles:${NC}"
    awk -F'|' '{printf "%s) %s (%s@%s:%s)\n", NR, $1, $2, $3, $4}' "$CONFIG_FILE"
    echo
}

# Connect via profile
connect_profile() {
    list_profiles
    read -p "Enter profile number to connect: " profile_num

    if [[ "$profile_num" =~ ^[0-9]+$ ]]; then
        IFS='|' read -r name user host port key <<< "$(sed -n "${profile_num}p" "$CONFIG_FILE")"

        if [[ -n "$name" ]]; then
            echo -e "${YELLOW}Connecting to $name...${NC}"
            ssh -i "$key" -p "$port" "$user@$host"
        else
            echo -e "${RED}Invalid profile number${NC}"
        fi
    else
        echo -e "${RED}Invalid input${NC}"
    fi
    read -p "Press Enter to continue..."
}

# Add profile
add_profile() {
    echo -e "${GREEN}Add new profile${NC}"
    read -p "Profile name: " name
    read -p "Username: " user
    read -p "Host/IP: " host
    read -p "Port (default 22): " port
    port=${port:-22}

    read -p "SSH key path (default ~/.ssh/id_rsa): " key
    key=${key:-~/.ssh/id_rsa}

    echo "$name|$user|$host|$port|$key" >> "$CONFIG_FILE"
    echo -e "${GREEN}Profile '$name' added${NC}"
    read -p "Press Enter to continue..."
}

# Delete profile
delete_profile() {
    list_profiles
    read -p "Profile number to delete: " profile_num

    if [[ "$profile_num" =~ ^[0-9]+$ ]]; then
        sed -i "${profile_num}d" "$CONFIG_FILE"
        echo -e "${GREEN}Profile deleted${NC}"
    else
        echo -e "${RED}Invalid input${NC}"
    fi
    read -p "Press Enter to continue..."
}

# Main loop
initialize_config

while true; do
    show_menu
    list_profiles
    read -p "Select option (1-4): " choice

    case $choice in
        1) connect_profile ;;
        2) add_profile ;;
        3) delete_profile ;;
        4) echo -e "${GREEN}Goodbye!${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid choice${NC}" ;;
    esac
done
