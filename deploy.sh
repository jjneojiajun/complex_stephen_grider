docker build -t jjneojiajun/multi-client:latest -t jjneojiajun/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jjneojiajun/multi-server:latest -t jjneojiajun/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jjneojiajun/multi-worker:latest -t jjneojiajun/mutli-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jjneojiajun/multi-client:latest
docker push jjneojiajun/multi-server:latest
docker push jjneojiajun/multi-worker:latest

docker push jjneojiajun/multi-client:$SHA
docker push jjneojiajun/multi-server:$SHA
docker push jjneojiajun/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jjneojiajun/multi-server:$SHA
kubectl set image deployments/client-deployment client=jjneojiajun/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jjneojiajun/multi-worker:$SHA