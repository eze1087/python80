#!/bin/bash

# Reemplaza este link con tu repositorio de GitHub
REPO_URL="https://github.com/tuusuario/tu-repo.git"

# Clonar tu repositorio
git clone $REPO_URL /tmp/mi-proxy

# Mover el script a la ubicación deseada
sudo mv /tmp/mi-proxy/proxy.py /etc/SSHPlus/

# Dar permisos de ejecución
sudo chmod +x /etc/SSHPlus/proxy.py

# Crear el archivo del servicio systemd
echo -e "[Unit]\nDescription=Ejecutar proxy en una sesión de screen\nAfter=network.target\n\n[Service]\nExecStart=/usr/bin/screen -DmS PDirect /usr/bin/python3 /etc/SSHPlus/proxy.py\nWorkingDirectory=/etc/SSHPlus\nUser=root\nRestart=on-failure\nRestartSec=5\n\n[Install]\nWantedBy=multi-user.target" | sudo tee /etc/systemd/system/pdirect.service

# Recargar systemd y arrancar el servicio
sudo systemctl daemon-reload
sudo systemctl start pdirect.service
sudo systemctl enable pdirect.service

# Mostrar estado
sudo systemctl status pdirect.service
