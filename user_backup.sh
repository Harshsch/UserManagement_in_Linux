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
add_user() {
  read -rp "Enter username to add: " username
  if id "$username" &>/dev/null; then
    echo "❌ User '$username' already exists."
  else
    read -rp "Enter home directory [/home/$username]: " homedir
    homedir=${homedir:-/home/$username}
    useradd -m -d "$homedir" "$username" && echo "✅ User '$username' added."
  fi
}
delete_user() {
  read -rp "Enter username to delete: " username
  if id "$username" &>/dev/null; then
    userdel -r "$username" && echo "✅ User '$username' deleted."
  else
    echo "❌ User '$username' does not exist."
  fi
}
modify_user() {
  read -rp "Enter existing username: " oldname
  if ! id "$oldname" &>/dev/null; then
    echo "❌ User '$oldname' does not exist."
    return
  fi

  read -rp "Enter new username (leave blank to skip): " newname
  read -rp "Enter new shell (e.g., /bin/bash, leave blank to skip): " newshell

  [ -n "$newname" ] && usermod -l "$newname" "$oldname" && echo "✅ Username changed to '$newname'"
  [ -n "$newshell" ] && chsh -s "$newshell" "${newname:-$oldname}" && echo "✅ Shell changed to '$newshell'"
}

while true; do
  show_menu
  read -rp "Choose an option [1-6]: " choice
  case "$choice" in
    1) add_user ;;
    2) delete_user ;;
    3) modify_user ;;
    4) echo "🔧 Group management functionality coming soon..." ;;
    5) echo "🔧 Backup functionality coming soon..." ;;
    6) echo "✅ Exiting. Goodbye!"; break ;;
    *) echo "❌ Invalid option. Try again." ;;
  esac
done

