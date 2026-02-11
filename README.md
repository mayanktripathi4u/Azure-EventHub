# Azure Event Hub
Hands-on Learning for Azure Event Hub Resource

# Project Idea: Real-Time application log and Analytics Pipeline
Use Case:
```txt
Multiple apps send logs / events --> Event Hub --> Process --> Store --> Analyze --> Dashboard
```

How I am seeing it (Architecture)
```yaml
Python Apps (Producers)
        |
        v
Azure Event Hub
        |
        v
Python Consumer

```

# Run 

## Infra Setup
```sh
az login

az account show

python3 -m venv .azure_venv
source .azure_venv/bin/activate

cd infra

terraform init

terraform fmt

terraform validate

terraform plan -var-file=dev.tfvars

terraform apply -var-file=dev.tfvars
```

## Producer Setup
```sh
python3 -m venv .azure_venv
source .azure_venv/bin/activate

cd producer

pip install azure-eventhub

python send_events.py 

```

To get the Connection String, best Way (Since we're Using Terraform).
We already set this up in `outputs.tf`, so Terraform is literally storing it for us.
```sh
cd infra

terraform output connection_string

# or
terraform output -raw connection_string
```
Output would be something like,
```sh
Endpoint=sb://eh-ns-dev-xxxx.servicebus.windows.net/;
SharedAccessKeyName=app-access;
SharedAccessKey=xxxxxxxxxx;
EntityPath=app-logs
```
✅ That entire string = your connection string.

Alternate, we could fetch via CLI
```sh
# List Authorization Rules
az eventhubs eventhub authorization-rule list \
  --resource-group rg-eh-dev \
  --namespace-name <NAMESPACE> \
  --eventhub-name app-logs \
  --output table


az eventhubs eventhub authorization-rule list \
  --resource-group rg-eh-dev \
  --namespace-name eh-ns-dev-ac5929cb  \
  --eventhub-name app-logs \
  --output table

  # Get Keys
az eventhubs eventhub authorization-rule keys list \
  --resource-group rg-eh-dev \
  --namespace-name eh-ns-dev-ac5929cb \
  --eventhub-name app-logs \
  --name app-access

# Use `primaryConnectionString` as your connection string.
```

## Consumer Setup
```sh
pip install azure-eventhub-checkpointstoreblob-aio

cd ../consumer 
python receive_events.py 
```


# References
[Terraform - Resource EventHub ](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub)