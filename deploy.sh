docker build -t aartibhagtani/multi-client:latest -t aartibhagtani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aartibhagtani/multi-server:latest -t aartibhagtani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aartibhagtani/multi-worker:latest -t aartibhagtani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aartibhagtani/multi-client:latest
docker push aartibhagtani/multi-server:latest
docker push aartibhagtani/multi-worker:latest

docker push aartibhagtani/multi-client:$SHA
docker push aartibhagtani/multi-server:$SHA
docker push aartibhagtani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aartibhagtani/multi-server:$SHA
kubectl set image deployments/client-deployment client=aartibhagtani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aartibhagtani/multi-worker:$SHA
