docker build -t uzigolan/multi-client:latest -t uzigolan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t uzigolan/multi-server:latest -t uzigolan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t uzigolan/multi-worker:latest -t uzigolan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push uzigolan/multi-client:latest
docker push uzigolan/multi-server:latest
docker push uzigolan/multi-worker:latest

docker push uzigolan/multi-client:$SHA
docker push uzigolan/multi-server:$SHA
docker push uzigolan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=uzigolan/multi-server:$SHA
kubectl set image deployments/client-deployment client=uzigolan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=uzigolan/multi-worker:$SHA
