#!/bin/bash

# Reemplaza este enlace con tu repositorio real que contiene PDirect.py
REPO_URL="https://raw.githubusercontent.com/eze1087/python80/refs/heads/main/PDirect.py"

# Actualiza los paquetes y dependencias
apt update && apt upgrade -y

# Clona tu repositorio completo
git clone $REPO_URL /tmp/mi-proxy

# Mueve PDirect.py a la ubicación deseada
sudo mv /tmp/mi-proxy/PDirect.py /etc/SSHPlus/

# Da permisos de ejecución
sudo chmod +x /etc/SSHPlus/PDirect.py

# Crea el servicio systemd
sudo tee /etc/systemd/system/pdirect.service > /dev/null << EOL
[Unit]
Description=Ejecutar PDirect en una sesión de screen
After=network.target

[Service]
ExecStart=/usr/bin/screen -DmS PDirect /usr/bin/python3 /etc/SSHPlus/PDirect.py
WorkingDirectory=/etc/SSHPlus
User=root
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOL

# Recarga systemd y activa el servicio
sudo systemctl daemon-reload
sudo systemctl start pdirect.service
sudo systemctl enable pdirect.service

# Estado del servicio
sudo systemctl status pdirect.service
