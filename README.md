chmod +x scripts/setup-kind.sh
./scripts/setup-kind.sh

kind version
kind get clusters
kubectl cluster-info

#kind delete clusters --all

Run the setup-kind.sh script to provision the KinD cluster.
Run the deploy.sh script to deploy all resources.
Use curl or a browser to verify the endpoints:

curl -H "Host: foo.localhost" http://localhost
curl -H "Host: bar.localhost" http://localhost
You should see responses foo and bar, respectively.

kubectl get svc -n ingress-nginx
kubectl get ingress
kubectl get svc

kubectl port-forward svc/foo-service 8080:80 &
curl http://localhost:8080

kubectl port-forward svc/bar-service 8081:80 &
curl http://localhost:8081
