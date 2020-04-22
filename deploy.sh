docker build -t xhlasn/multi-client:latest -t xhlasn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xhlasn/multi-server:latest -t xhlasn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xhlasn/multi-worker:latest -t xhlasn/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xhlasn/multi-client:latest
docker push xhlasn/multi-client:$SHA
docker push xhlasn/multi-server:latest
docker push xhlasn/multi-server:$SHA
docker push xhlasn/multi-worker:latest
docker push xhlasn/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xhlasn/multi-server:$SHA
kubectl set image deployments/client-deployment client=xhlasn/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xhlasn/multi-worker:$SHA

