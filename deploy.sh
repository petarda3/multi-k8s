docker build -t petarda/multi-client:latest -t petarda/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t petarda/multi-server:latest -t petarda/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t petarda/multi-worker:latest -t petarda/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push petarda/multi-client:latest
docker push petarda/multi-server:latest
docker push petarda/multi-worker:latest

docker push petarda/multi-client:$SHA
docker push petarda/multi-server:$SHA
docker push petarda/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=petarda/multi-server:$SHA
kubectl set image deployments/client-deployment client=petarda/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=petarda/multi-worker:$SHA


