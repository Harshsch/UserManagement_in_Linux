
---

````markdown
# 👤 UserManagement_in_Linux

A powerful and user-friendly **Bash script** to manage Linux users, groups, and directory backups — designed for system administrators, students, and DevOps learners.

---

## 📂 Features

This interactive script provides the following options:

1. Add User
   - Creates a new user with an optional home directory path.
2. Delete User
   - Deletes a user and their associated home directory.
3. Modify User
   - Change username or default shell.
4. Manage Groups
   - Create, delete groups
   - Add users to groups
   - List all system groups
5. Backup Directory
   - Backup any directory into a `.tar.gz` archive under `~/backups/`

---

## 🔐 Prerequisites

- Must run as **root** (or use `sudo`)
- Linux-based operating system
- `bash` shell

---

## 🛠️ How to Use

1. **Clone the repository** (or copy the script locally):

```bash
git clone https://github.com/your-username/UserManagement_in_Linux.git
cd UserManagement_in_Linux
````

2. **Make the script executable**:

```bash
chmod +x user_manage.sh
```

3. **Run the script with root privileges**:

```bash
sudo ./user_manage.sh
```

---

## 📦 Backup Output

* Backups are saved in `~/backups/`
* Filename format:
  `backup_<directory_name>_<YYYYMMDD_HHMMSS>.tar.gz`

---

## 🧠 Concepts Covered

* `useradd`, `usermod`, `userdel` – for user management
* `groupadd`, `groupdel`, `usermod -aG` – for group control
* `tar`, `mkdir`, `date` – for backup handling
* Error handling and validation with conditional logic
* Interactive terminal menus with `read` and case switches

---

## 📸 Sample Screenshot

```text
=================================
User and Backup Management Script
=================================
1. Add User
2. Delete User
3. Modify User
4. Manage Groups
5. Backup Directory
6. Exit
=================================
Choose an option [1-6]:
```

## 🤝 Contribution

Feel free to fork, modify, and submit pull requests.
Bug reports and feature suggestions are welcome!

---

## 🧑‍💻 Author

**Harsh Chavan**
🔗 [GitHub Profile](https://github.com/Harshsch)

---

```
