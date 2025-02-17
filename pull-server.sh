#!/bin/bash

npm run build
git add .

read -p "Digite a mensagem do commit: " message
git commit -am "$message"

# Envia as mudanças para o servidor
git push origin main
git push server main

# Atualiza o repositório no servidor e a API
ssh lucas@35.198.22.191 << EOF
# Atualiza o repo-api primeiro
cd /home/lucas/repo-api
git pull origin main

# Atualiza o api
cd /home/lucas/api
git pull origin main
pm2 restart api
sudo systemctl restart nginx
EOF
