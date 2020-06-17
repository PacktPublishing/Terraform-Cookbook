curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/$(curl -s https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest | grep tag_name | cut -d '"' -f 4)/terraformer-azure-linux-amd64
chmod +x terraformer-azure-linux-amd64
sudo mv terraformer-azure-linux-amd64 /usr/local/bin/terraformer