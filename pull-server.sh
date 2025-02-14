#!/bin/bash

npm run build
git add .

read message
echo "Mensagem do commit: "
git commit -am "$message"
git push server main
git push origin main

ssh lucas@http://35.198.22.191/ \
  'git -C /home/lucas/api/ ' \
  'pull origin main && ' \
  'pm2 restart api && sudo systemctl restart nginx'
