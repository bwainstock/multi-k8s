docker build -t bwainstock/multi-client:latest -t bwainstock/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bwainstock/multi-server:latest -t bwainstock/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bwainstock/multi-worker:latest -t bwainstock/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bwainstock/multi-client:latest
docker push bwainstock/multi-server:latest
docker push bwainstock/multi-worker:latest

docker push bwainstock/multi-client:$SHA
docker push bwainstock/multi-server:$SHA
docker push bwainstock/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bwainstock/multi-server:$SHA
kubectl set image deployments/client-deployment client=bwainstock/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bwainstock/multi-worker:$SHA