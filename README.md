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