 aqueduct db generate
 
 pub global activate aqueduct
 
 aqueduct db upgrade —connect postgres://wishes_user:password@localhost:5432/wishes
 
 
 CREATE DATABASE wishes;
 CREATE USER wishes_user WITH createdb;
 ALTER USER wishes_user WITH password 'password';
 GRANT all ON database wishes TO wishes_user; 
 
  aqueduct serve

 export PATH="$PATH":"$HOME/.pub-cache/bin"

curl -X POST http://localhost:8888/register -H 'Content-Type: application/json' -d '{"username":"bob", "password":"password"}'

aqueduct auth add-client --id com.lardis.wish --connect postgres://wishes_user:password@localhost:5432/wishes

aqueduct document > swagger.json
aqueduct document client

$ sudo apt-get update
$ sudo apt-get install apt-transport-https
$ sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
$ sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'


export PATH="$PATH:/usr/lib/dart/bin"

echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile

sudo apt-get install postgresql postgresql-contrib


sudo -i -u postgres
psql
\q