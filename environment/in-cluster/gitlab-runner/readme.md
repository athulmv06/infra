helm repo add gitlab https://charts.gitlab.io

helm repo update gitlab

helm install --namespace kube-system gitlab-runner -f values.yaml gitlab/gitlab-runner
