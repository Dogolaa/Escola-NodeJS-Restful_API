#!/bin/bash

npm run build
git add .

read -p "Digite a mensagem do commit: " message
git commit -am "$message"

git push origin main
git push server main  # Se der erro, tente manualmente para ver o problema

ssh lucas@35.198.22.191 << EOF
cd /home/lucas/api
git reset --hard origin/main  # Evita conflitos no pull
git pull origin main
pm2 restart api
sudo systemctl restart nginx
EOF
