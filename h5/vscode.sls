'wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg':
  cmd.run

'sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/':
  cmd.run

'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list':
  cmd.run

'rm -f packages.microsoft.gpg':
  cmd.run

'sudo apt-get install apt-transport-https':
  cmd.run

'sudo apt-get update':
  cmd.run

# Visual Studio Code
code:
  pkg.installed: []
