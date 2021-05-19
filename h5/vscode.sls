/etc/apt/trusted.gpg.d/packages.microsoft.gpg:
  file.managed:
    - source: salt://vscode/packages.microsoft.gpg

/etc/apt/sources.list.d/vscode.list:
  file.managed:
    - source: salt://vscode/vscode.list

code:
  pkg.installed