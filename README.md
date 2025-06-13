# SSH Manager TUI  
*A terminal-based SSH connection manager with a modern color interface, designed to simplify managing multiple SSH profiles*  
![tuisshman](https://github.com/user-attachments/assets/e49d3a47-6f8d-4c2a-b45f-b4d05f599296)

---

## 🔧 Features  
- Save and organize SSH profiles with custom settings  
- Color-coded interface for enhanced readability  
- Support for custom SSH keys, ports, and user credentials  
- Simple menu-driven navigation (similar to PuTTY)  
- Lightweight and easy to use  

---

## 📦 Requirements  
- SSH client installed (`openssh-client` or equivalent)  
- Bash shell  
- Basic terminal capabilities for ANSI color codes  

---

## 🛠️ Installation  
### 1. Clone the repository:  
```bash  
git clone https://github.com/zsh-ncursed/ssh_manager_tui.git

**### 2. Make the script executable:**
```bash 
chmod +x ssh_manager_tui.sh

### 3. Run the manager:
```bash
./ssh_manager_tui.sh

---

## 🧪 Usage 
### 1. Add a profile : 

    Provide a profile name, username, host/IP, port (default: 22), and SSH key path (default: ~/.ssh/id_rsa).  
    Profiles are saved to ~/.ssh_manager.conf.
### 2. Connect to a server : 

    Select a saved profile from the menu to establish an SSH connection.
     

### 3. Delete a profile : 

    Remove unwanted profiles by their numeric index.   
