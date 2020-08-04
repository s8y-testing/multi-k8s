docker build -t s8y-testing/multi-client:latest -t s8y-testing/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t s8y-testing/multi-server:latest -t s8y-testing/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t s8y-testing/multi-worker:latest -t s8y-testing/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push s8y-testing/multi-client:latest
docker push s8y-testing/multi-server:latest
docker push s8y-testing/multi-worker:latest

docker push s8y-testing/multi-client:$SHA
docker push s8y-testing/multi-server:$SHA
docker push s8y-testing/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=s8y-testing/multi-server:$SHA
kubectl set image deployments/client-deployment client=s8y-testing/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=s8y-testing/multi-worker:$SHA
