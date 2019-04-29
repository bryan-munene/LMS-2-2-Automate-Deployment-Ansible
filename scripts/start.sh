#!/usr/bin/env bash

# SET SUPERVISORD TO RUN THE APP IN THE BACKGROUND
function configureSupervisord {
    export DATABASE_URL="postgres://wiczscmcoywrfo:38a69f136463d5be96a7a7e4c4f83b7515e288ae04553224426be21ffa4b87a9@ec2-184-73-153-64.compute-1.amazonaws.com:5432/d6r00h5tof1r6l"
    export SECRET_KEY='7pgozr2jn7zs_o%i8id6=rddie!*0f0qy3$oy$(8231i^4*@u3'
    export FACEBOOK_KEY="247837426149873"
    export FACEBOOK_SECRET="2e84a49d93c22149d8fc0a9ca4b637e8"
    export GOOGLE_OAUTH2_KEY="1002458434953-pacsegk23bhcmuqso0obfk6h0g72ma76.apps.googleusercontent.com"
    export GOOGLE_OAUTH2_SECRET="UHFx0lVYiHWAEz-Rm0aU_DpN"
    export OAUTH2_ACCESS_TOKEN="EAADhaCWZCafEBAFUJbrqpS3BqZAVah0YZCNGi7GXdzEPLdkhT7yYfx32Ayt0NTPbhQ3ykTUhGCtAw1pNIPsKLBgvlj1N3KyhElXZByP0jntknsVmMHWdCdXzFTAFtGeUtMSCVVKEBVLU1DrXZBzNTYWeGQ8idofwZD"
    export EMAIL_SENDER="ahbirdbox03@gmail.com"
    export EMAIL_HOST="smtp.gmail.com"
    export EMAIL_HOST_USER="ahbirdbox03@gmail.com"
    export EMAIL_HOST_PASSWORD="@Birdbox2019"
    export EMAIL_PORT=587
    export CLOUDINARY_NAME="muthuri"
    export CLOUDINARY_KEY="873127371616125"
    export CLOUDINARY_SECRET="XjqUIFkfYmu2GBjgY041EZcg_-8"
    export APP_BASE_URL="http://127.0.0.1:8000"
    cd ah-bird-box
    python3 -m venv venv
    source venv/bin/activate
    sudo cat > /etc/supervisor/conf.d/gunicorn.conf <<EOF
        [program:gunicorn]
        command=/home/ubuntu/ah-bird-box/venv/bin/gunicorn authors.wsgi:application -c /home/ubuntu/ah-bird-box/authors/gunicorn_conf
        directory=/home/ubuntu/ah-bird-box/authors
        user=ubuntu
        autostart=true
        autorestart=true
        redirect_stderr=true          
EOF

    sudo supervisorctl reread
    sudo supervisorctl update
    sudo supervisorctl restart gunicorn

}

configureSupervisord
# INSTALL DEPENDENCIES AND ADD ENV VARIABLES

  - name: Change ownership of project directory
    file: 
      path: /home/ubuntu/ah-bird-box
      owner: ubuntu
      recurse: yes

  - name: Install dependancies and run database migrations
    shell:
      cmd: |
        pip3 install supervisor
        cd /home/ubuntu/ah-bird-box
        sudo virtualenv -p python3 venv
        source venv/bin/activate
        pip3 install -r requirements.txt
        python3 manage.py migrate
        python3 manage.py collectstatic
        
  - name: Change ownership of project directory
    file: 
      path: /home/ubuntu/ah-bird-box
      owner: ubuntu
      recurse: yes
  
  
sudo apt-get -y update
sudo apt-get -y upgrade python3
sudo add-apt-repository ppa:deadsnakes/ppa


/home/ubuntu/venv/bin/gunicorn authors.wsgi:application -c authors/gunicorn_conf


[program:gunicorn]
directory=/home/ubuntu/ah-bird-box/authors
enviroment=DATABASE_URL="postgres://wiczscmcoywrfo:38a69f136463d5be96a7a7e4c4f83b7515e288ae04553224426be21ffa4b87a9@ec2-184-73-153-64.compute-1.amazonaws.com:5432/d6r00h5tof1r6l",SECRET_KEY='7pgozr2jn7zs_o%i8id6=rddie!*0f0qy3$oy$(8231i^4*@u3',FACEBOOK_KEY="247837426149873",FACEBOOK_SECRET="2e84a49d93c22149d8fc0a9ca4b637e8",GOOGLE_OAUTH2_KEY="1002458434953-pacsegk23bhcmuqso0obfk6h0g72ma76.apps.googleusercontent.com",GOOGLE_OAUTH2_SECRET="UHFx0lVYiHWAEz-Rm0aU_DpN",OAUTH2_ACCESS_TOKEN="EAADhaCWZCafEBAFUJbrqpS3BqZAVah0YZCNGi7GXdzEPLdkhT7yYfx32Ayt0NTPbhQ3ykTUhGCtAw1pNIPsKLBgvlj1N3KyhElXZByP0jntknsVmMHWdCdXzFTAFtGeUtMSCVVKEBVLU1DrXZBzNTYWeGQ8idofwZD",EMAIL_SENDER="ahbirdbox03@gmail.com",EMAIL_HOST="smtp.gmail.com",EMAIL_HOST_USER="ahbirdbox03@gmail.com",EMAIL_HOST_PASSWORD="@Birdbox2019",EMAIL_PORT=587,CLOUDINARY_NAME="muthuri",CLOUDINARY_KEY="873127371616125",CLOUDINARY_SECRET="XjqUIFkfYmu2GBjgY041EZcg_-8",APP_BASE_URL="http://127.0.0.1:8000"
command=/home/ubuntu/venv/bin/gunicorn authors.wsgi -c authors/gunicorn_conf
user=ubuntu
autostart=true
autorestart=true
redirect_stderr=true
stderr_logfile=/var/log/supervisor/test.err.log
stdout_logfile=/var/log/supervisor/test.out.log




- name: Create start script
  shell:
  chdir: /var/www/project/RecipeAPI/
  creates: startenv.sh
  cmd: |
    cat > startappenv.sh <<EOF
    #!/bin/bash
    
    EOF
- name: Create start service
  shell:
  chdir: /etc/systemd/system/
  creates: recipe.service
  cmd: |
    cat > recipe.service <<EOF
    [Unit]
    Description=recipe startup service
    After=network.target
    [Service]
    User=ubuntu
    ExecStart=/bin/bash /var/www/project/RecipeAPI/startenv.sh
    Restart=always
    [Install]
    WantedBy=multi-user.target
    EOF
- name: Change the files permission
  shell: |
  sudo chmod 744 /var/www/project/RecipeAPI/startenv.sh
  sudo chmod 664 /etc/systemd/system/recipe.service