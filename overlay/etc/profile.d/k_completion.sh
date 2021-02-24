. /etc/profile.d/bash_completion.sh
# kubectl completion bash >/etc/bash_completion.d/kubectl
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k