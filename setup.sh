# This script combines several commands that you'll likely run together anyway

docker build -t school_db .
docker run --name pg_school --rm -e POSTGRES_PASSWORD=password -d school_db
sleep 3 # give postgres time to get ready
docker exec -it pg_school psql -h localhost -p 5432 -U postgres -d school
