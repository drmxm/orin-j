docker compose down
docker compose down --rmi all -v
#docker system prune -a --volumes
docker compose up --build --remove-orphans