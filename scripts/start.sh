#!/usr/bin/env bash

# SET PM2 TO RUN THE APP IN THE BACKGROUND
function configurePM2 {
    export REACT_APP_API_URL="https://cors-anywhere.herokuapp.com/https://ah-bird-box-staging.herokuapp.com"
    export REACT_APP_API_KEY="AIzaSyBNe0bx4gYG6OaVIUHkDPy_ej0DidTl4lU"
    export REACT_APP_AUTH_DOMAIN="ah-bird-box.firebaseapp.com"
    export REACT_APP_IMGUR_CLIENT_ID="Client-ID e97f36417525559"
    export REACT_APP_IMGUR_URL="https://api.imgur.com/3/image"
    cd ah-bird-box-frontend
    npm install
    pm2 start npm --name "AH-Birdbox" -- start
    pm2 startup
    sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
    pm2 save
}

configurePM2
