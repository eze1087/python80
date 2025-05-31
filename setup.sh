#!/bin/bash

# Reemplaza este link con tu repositorio de GitHub
REPO_URL="https://raw.githubusercontent.com/eze1087/python80/refs/heads/main/PDirect.py"

# Clonar tu repositorio
git clone $REPO_URL /tmp/mi-proxy

# Mover el script PDirect.py a la ubicación deseada
sudo mv /tmp/mi-proxy/PDirect.py /etc/SSHPlus/

# Dar permisos de ejecución
sudo chmod +x /etc/SSHPlus/PDirect.py

# Crear el archivo del servicio systemd con tu contenido
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

# Recargar systemd y arrancar el servicio
sudo systemctl daemon-reload
sudo systemctl start pdirect.service
sudo systemctl enable pdirect.service

# Mostrar estado
sudo systemctl status pdirect.service
