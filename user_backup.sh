#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root"
  exit 1
fi

show_menu() {
  echo "================================="
  echo "User and Backup Management Script"
  echo "================================="
  echo "1. Add User"
  echo "2. Delete User"
  echo "3. Modify User"
  echo "4. Manage Groups"
  echo "5. Backup Directory"
  echo "6. Exit"
  echo "================================="
}

while true; do
  show_menu
  read -rp "Choose an option [1-6]: " choice
  case "$choice" in
    1) echo "🔧 Add user functionality coming soon..." ;;
    2) echo "🔧 Delete user functionality coming soon..." ;;
    3) echo "🔧 Modify user functionality coming soon..." ;;
    4) echo "🔧 Group management functionality coming soon..." ;;
    5) echo "🔧 Backup functionality coming soon..." ;;
    6) echo "✅ Exiting. Goodbye!"; break ;;
    *) echo "❌ Invalid option. Try again." ;;
  esac
done

