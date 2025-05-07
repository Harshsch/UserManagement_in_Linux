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

group_management() {
  echo "------ Group Management ------"
  echo "1. Create a new group"
  echo "2. Add a user to a group"
  echo "3. Delete a group"
  echo "4. List all groups"
  echo "5. Go back"
  read -rp "Choose an option [1-5]: " gchoice

  case "$gchoice" in
    1)
      read -rp "Enter new group name: " groupname
      if getent group "$groupname" > /dev/null; then
        echo "❌ Group '$groupname' already exists."
      else
        groupadd "$groupname" && echo "✅ Group '$groupname' created."
      fi
      ;;
    2)
      read -rp "Enter username: " username
      read -rp "Enter group name: " groupname
      if id "$username" &>/dev/null && getent group "$groupname" > /dev/null; then
        usermod -aG "$groupname" "$username" && echo "✅ Added '$username' to group '$groupname'."
      else
        echo "❌ Either user or group does not exist."
      fi
      ;;
    3)
      read -rp "Enter group name to delete: " groupname
      if getent group "$groupname" > /dev/null; then
        groupdel "$groupname" && echo "✅ Group '$groupname' deleted."
      else
        echo "❌ Group '$groupname' does not exist."
      fi
      ;;
    4)
      echo "📜 List of groups:"
      cut -d: -f1 /etc/group
      ;;
    5)
      echo "Returning to main menu..."
      ;;
    *)
      echo "❌ Invalid option."
      ;;
  esac
}

backup_directory() {
  read -rp "Enter the full path of the directory to back up: " dirpath

  if [ ! -d "$dirpath" ]; then
    echo "❌ Directory '$dirpath' does not exist."
    return
  fi

  backup_dir="$HOME/backups"
  mkdir -p "$backup_dir"

  timestamp=$(date +%Y%m%d_%H%M%S)
  backup_file="$backup_dir/backup_$(basename "$dirpath")_$timestamp.tar.gz"

  tar -czf "$backup_file" "$dirpath" && \
    echo "✅ Backup completed: $backup_file" || \
    echo "❌ Backup failed."
}


while true; do
  show_menu
  read -rp "Choose an option [1-6]: " choice
  case "$choice" in
    1) add_user ;;
    2) delete_user ;;
    3) modify_user ;;
    4) group_management ;;
    5) backup_directory ;;
    6) echo "✅ Exiting. Goodbye!"; break ;;
    *) echo "❌ Invalid option. Try again." ;;
  esac
done

