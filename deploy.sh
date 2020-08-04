docker build -t s9ke/multi-client:latest -t s9ke/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t s9ke/multi-server:latest -t s9ke/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t s9ke/multi-worker:latest -t s9ke/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push s9ke/multi-client:latest
docker push s9ke/multi-server:latest
docker push s9ke/multi-worker:latest

docker push s9ke/multi-client:$SHA
docker push s9ke/multi-server:$SHA
docker push s9ke/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=s9ke/multi-server:$SHA
kubectl set image deployments/client-deployment client=s9ke/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=s9ke/multi-worker:$SHA
