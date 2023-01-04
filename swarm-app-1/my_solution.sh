# creating networks

docker network create --driver overlay backend
docker network create --driver overlay frontend

# creating volume for db

docker volume create db-data

# initialize services

docker service create --name vote --network frontend -p 80:80 --replicas 3 bretfisher/examplevotingapp_vote
docker service create --name redis --network frontend redis:3.2
docker service create --name worker --network frontend --network backend bretfisher/examplevotingapp_worker
docker service create --name db --network backend --mount type=volume,source=db-data,target=/var/lib/postgresql/data -e POSTGRES_HOST_AUTH_METHOD=trust postgres:9.4
docker service create --name result --network backend -p 5001:80 bretfisher/examplevotingapp_result
