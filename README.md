
```
# Nexus-Cli-Multiple-Docker Setup (Ubuntu 22)

## 1. Clone This Repository
```bash
git clone https://github.com/istekhar8966/Nexus-Cli-Multiple-Docker.git
cd Nexus-Cli-Multiple-Docker
```

## 2. Install Nexus
```bash
sed -i 's/\r$//' nexus.sh
chmod +x nexus.sh
./nexus.sh
```

> **Note:** Please read the terminal logs for instructions and status updates.

## 3. Exiting the Mining Process
- If everything is working (mining fine), press <kbd>Ctrl</kbd> + <kbd>P</kbd> then <kbd>Q</kbd> to detach and exit.
- **If you are using [Termius](https://termius.com/):**  
  The default <kbd>Ctrl</kbd> + <kbd>P</kbd> shortcut may not work. Change the shortcut key for <kbd>Ctrl</kbd> + <kbd>P</kbd> in the Termius settings.

## 4. Running Additional Instances
1. Close your terminal, then open a new one for the next instance.
2. Repeat the following commands for each new instance:
```bash
cd Nexus-Cli-Multiple-Docker
./nexus.sh
```

