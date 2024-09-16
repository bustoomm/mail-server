# mail-server
mail server dengan docker dengan user host

# install docker dan docker compose

# buat user di mesin dan kasih permission, contoh dibawah ini
sudo adduser --system --home /var/mail/usermail --no-create-home --disabled-login --disabled-password --group usermail
sudo mkdir -p /var/mail/usermail/Maildir
sudo chown -R usermail:usermail /var/mail/usermail
sudo chmod -R 700 /var/mail/usermail

# perbarui repo dan install certbot untuk dapetin sertifikat dari domain
sudo apt-get update
sudo apt-get install certbot
sudo certbot certonly --standalone -d domainmu

# Sertifikat biasanya disimpan di direktori /etc/letsencrypt/live/folder domain/
sudo ls /etc/letsencrypt/live/mail.upsense.site/

# copy paste ke folder proyek
sudo cp /etc/letsencrypt/live/folder domain/fullchain.pem /path/to/your/docker/ssl/server.crt
sudo cp /etc/letsencrypt/live/folder domain/privkey.pem /path/to/your/docker/ssl/server.key

# bikin scheduler buat ambil sertifikat ketika sesi habis
sudo crontab -e

# tambahin ini
0 0 * * * /usr/bin/certbot renew --quiet

# running
docker-compose build up -d
