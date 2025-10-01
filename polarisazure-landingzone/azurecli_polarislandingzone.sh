markdown-pdf: Export (pdf)#!/bin/bash
# azurecli_polarislandingzone.sh
# Provision all Azure vNets and subnets for all resource groups

set -e


# connectivityhub
echo "Creating connectivityhub vNet and subnets..."
az group create --name connectivityhub --location centralus
az network vnet create --resource-group connectivityhub --name vnet-connectivityhub --address-prefix 10.50.0.0/16 --location centralus
az network vnet subnet create --resource-group connectivityhub --vnet-name vnet-connectivityhub --name public1 --address-prefix 10.50.0.0/23
az network vnet subnet create --resource-group connectivityhub --vnet-name vnet-connectivityhub --name public2 --address-prefix 10.50.2.0/23
az network vnet subnet create --resource-group connectivityhub --vnet-name vnet-connectivityhub --name firewall1 --address-prefix 10.50.4.0/27
az network vnet subnet create --resource-group connectivityhub --vnet-name vnet-connectivityhub --name firewall2 --address-prefix 10.50.4.32/27
az network vnet subnet create --resource-group connectivityhub --vnet-name vnet-connectivityhub --name private1 --address-prefix 10.50.8.0/23
az network vnet subnet create --resource-group connectivityhub --vnet-name vnet-connectivityhub --name private2 --address-prefix 10.50.10.0/23


# connectivityhub-dr
echo "Creating connectivityhub-dr vNet and subnets..."
az group create --name connectivityhub-dr --location eastus2
az network vnet create --resource-group connectivityhub-dr --name vnet-connectivityhub-dr --address-prefix 10.70.0.0/20 --location eastus2
az network vnet subnet create --resource-group connectivityhub-dr --vnet-name vnet-connectivityhub-dr --name public1 --address-prefix 10.70.0.0/23
az network vnet subnet create --resource-group connectivityhub-dr --vnet-name vnet-connectivityhub-dr --name public2 --address-prefix 10.70.2.0/23
az network vnet subnet create --resource-group connectivityhub-dr --vnet-name vnet-connectivityhub-dr --name firewall1 --address-prefix 10.70.4.0/27
az network vnet subnet create --resource-group connectivityhub-dr --vnet-name vnet-connectivityhub-dr --name firewall2 --address-prefix 10.70.4.32/27
az network vnet subnet create --resource-group connectivityhub-dr --vnet-name vnet-connectivityhub-dr --name private1 --address-prefix 10.70.8.0/23
az network vnet subnet create --resource-group connectivityhub-dr --vnet-name vnet-connectivityhub-dr --name private2 --address-prefix 10.70.10.0/23

# tenant001
echo "Creating tenant001 vNet and subnets..."
az group create --name tenant001 --location centralus
az network vnet create --resource-group tenant001 --name vnet-tenant001 --address-prefix 10.40.0.0/24 --location centralus
az network vnet subnet create --resource-group tenant001 --vnet-name vnet-tenant001 --name subnet1 --address-prefix 10.40.0.0/28
az network vnet subnet create --resource-group tenant001 --vnet-name vnet-tenant001 --name subnet2 --address-prefix 10.40.0.16/28

# tenant002
echo "Creating tenant002 vNet and subnets..."
az group create --name tenant002 --location centralus
az network vnet create --resource-group tenant002 --name vnet-tenant002 --address-prefix 10.40.1.0/24 --location centralus
az network vnet subnet create --resource-group tenant002 --vnet-name vnet-tenant002 --name subnet1 --address-prefix 10.40.1.0/28
az network vnet subnet create --resource-group tenant002 --vnet-name vnet-tenant002 --name subnet2 --address-prefix 10.40.1.16/28

# dev
echo "Creating dev vNet and subnets..."

# dev
echo "Creating dev vNet, subnets, NSGs, route tables, and tags..."
az group create --name dev --location centralus
az network vnet create --resource-group dev --name vnet-dev --address-prefix 10.60.0.0/21 --location centralus --tags environment=dev owner=network
az network nsg create --resource-group dev --name nsg-dev-subnet1 --location centralus --tags environment=dev
az network nsg create --resource-group dev --name nsg-dev-subnet2 --location centralus --tags environment=dev
az network nsg create --resource-group dev --name nsg-dev-subnet3 --location centralus --tags environment=dev
az network route-table create --resource-group dev --name rt-dev-subnet1 --location centralus --tags environment=dev
az network route-table create --resource-group dev --name rt-dev-subnet2 --location centralus --tags environment=dev
az network route-table create --resource-group dev --name rt-dev-subnet3 --location centralus --tags environment=dev
az network vnet subnet create --resource-group dev --vnet-name vnet-dev --name subnet1 --address-prefix 10.60.0.0/23 --network-security-group nsg-dev-subnet1 --route-table rt-dev-subnet1
az network vnet subnet create --resource-group dev --vnet-name vnet-dev --name subnet2 --address-prefix 10.60.2.0/23 --network-security-group nsg-dev-subnet2 --route-table rt-dev-subnet2
az network vnet subnet create --resource-group dev --vnet-name vnet-dev --name subnet3 --address-prefix 10.60.4.0/23 --network-security-group nsg-dev-subnet3 --route-table rt-dev-subnet3
az tag create --resource-id $(az network vnet show --resource-group dev --name vnet-dev --query id -o tsv) --tags environment=dev owner=network

# Repeat the above pattern for all other resource groups and subnets, updating names, locations, and tags as appropriate.

# sit
echo "Creating sit vNet and subnets..."
az group create --name sit --location centralus
az network vnet create --resource-group sit --name vnet-sit --address-prefix 10.61.0.0/21 --location centralus
az network vnet subnet create --resource-group sit --vnet-name vnet-sit --name subnet1 --address-prefix 10.61.0.0/23
az network vnet subnet create --resource-group sit --vnet-name vnet-sit --name subnet2 --address-prefix 10.61.2.0/23
az network vnet subnet create --resource-group sit --vnet-name vnet-sit --name subnet3 --address-prefix 10.61.4.0/23

# uat
echo "Creating uat vNet and subnets..."
az group create --name uat --location centralus
az network vnet create --resource-group uat --name vnet-uat --address-prefix 10.62.0.0/21 --location centralus
az network vnet subnet create --resource-group uat --vnet-name vnet-uat --name subnet1 --address-prefix 10.62.0.0/23
az network vnet subnet create --resource-group uat --vnet-name vnet-uat --name subnet2 --address-prefix 10.62.2.0/23
az network vnet subnet create --resource-group uat --vnet-name vnet-uat --name subnet3 --address-prefix 10.62.4.0/23

# performance
echo "Creating performance vNet and subnets..."
az group create --name performance --location centralus
az network vnet create --resource-group performance --name vnet-performance --address-prefix 10.63.0.0/21 --location centralus
az network vnet subnet create --resource-group performance --vnet-name vnet-performance --name subnet1 --address-prefix 10.63.0.0/23
az network vnet subnet create --resource-group performance --vnet-name vnet-performance --name subnet2 --address-prefix 10.63.2.0/23
az network vnet subnet create --resource-group performance --vnet-name vnet-performance --name subnet3 --address-prefix 10.63.4.0/23

# prod
echo "Creating prod vNet and subnets..."
az group create --name prod --location centralus
az network vnet create --resource-group prod --name vnet-prod --address-prefix 10.80.0.0/21 --location centralus
az network vnet subnet create --resource-group prod --vnet-name vnet-prod --name subnet1 --address-prefix 10.80.0.0/23
az network vnet subnet create --resource-group prod --vnet-name vnet-prod --name subnet2 --address-prefix 10.80.2.0/23
az network vnet subnet create --resource-group prod --vnet-name vnet-prod --name subnet3 --address-prefix 10.80.4.0/23

# dr
echo "Creating dr vNet and subnets..."
az group create --name dr --location eastus2
az network vnet create --resource-group dr --name vnet-dr --address-prefix 10.81.0.0/21 --location eastus2
az network vnet subnet create --resource-group dr --vnet-name vnet-dr --name subnet1 --address-prefix 10.81.0.0/23
az network vnet subnet create --resource-group dr --vnet-name vnet-dr --name subnet2 --address-prefix 10.81.2.0/23
az network vnet subnet create --resource-group dr --vnet-name vnet-dr --name subnet3 --address-prefix 10.81.4.0/23

# tools
echo "Creating tools vNet and subnets..."
az group create --name tools --location centralus
az network vnet create --resource-group tools --name vnet-tools --address-prefix 10.30.0.0/21 --location centralus
az network vnet subnet create --resource-group tools --vnet-name vnet-tools --name subnet1 --address-prefix 10.30.0.0/23
az network vnet subnet create --resource-group tools --vnet-name vnet-tools --name subnet2 --address-prefix 10.30.2.0/23
az network vnet subnet create --resource-group tools --vnet-name vnet-tools --name subnet3 --address-prefix 10.30.4.0/23

# tools-dr
echo "Creating tools-dr vNet and subnets..."
az group create --name tools-dr --location eastus2
az network vnet create --resource-group tools-dr --name vnet-tools-dr --address-prefix 10.31.0.0/21 --location eastus2
az network vnet subnet create --resource-group tools-dr --vnet-name vnet-tools-dr --name subnet1 --address-prefix 10.31.0.0/23
az network vnet subnet create --resource-group tools-dr --vnet-name vnet-tools-dr --name subnet2 --address-prefix 10.31.2.0/23
az network vnet subnet create --resource-group tools-dr --vnet-name vnet-tools-dr --name subnet3 --address-prefix 10.31.4.0/23

# silver_eks
echo "Creating silver_eks vNet and subnets..."
az group create --name silver_eks --location centralus
az network vnet create --resource-group silver_eks --name vnet-silver-eks --address-prefix 10.10.0.0/16 --location centralus
az network vnet subnet create --resource-group silver_eks --vnet-name vnet-silver-eks --name routable1 --address-prefix 10.10.0.0/23
az network vnet subnet create --resource-group silver_eks --vnet-name vnet-silver-eks --name routable2 --address-prefix 10.10.2.0/23
az network vnet subnet create --resource-group silver_eks --vnet-name vnet-silver-eks --name nonroutable1 --address-prefix 100.64.0.0/20
az network vnet subnet create --resource-group silver_eks --vnet-name vnet-silver-eks --name nonroutable2 --address-prefix 100.64.16.0/20

# silver_eksgbd
echo "Creating silver_eksgbd vNet and subnets..."
az group create --name silver_eksgbd --location centralus
az network vnet create --resource-group silver_eksgbd --name vnet-silver-eksgbd --address-prefix 10.10.4.0/16 --location centralus
az network vnet subnet create --resource-group silver_eksgbd --vnet-name vnet-silver-eksgbd --name routable1 --address-prefix 10.10.4.0/23
az network vnet subnet create --resource-group silver_eksgbd --vnet-name vnet-silver-eksgbd --name routable2 --address-prefix 10.10.6.0/23
az network vnet subnet create --resource-group silver_eksgbd --vnet-name vnet-silver-eksgbd --name nonroutable1 --address-prefix 100.64.32.0/20
az network vnet subnet create --resource-group silver_eksgbd --vnet-name vnet-silver-eksgbd --name nonroutable2 --address-prefix 100.64.48.0/20

# gold_eks
echo "Creating gold_eks vNet and subnets..."
az group create --name gold_eks --location centralus
az network vnet create --resource-group gold_eks --name vnet-gold-eks --address-prefix 10.10.8.0/16 --location centralus
az network vnet subnet create --resource-group gold_eks --vnet-name vnet-gold-eks --name routable1 --address-prefix 10.10.8.0/23
az network vnet subnet create --resource-group gold_eks --vnet-name vnet-gold-eks --name routable2 --address-prefix 10.10.10.0/23
az network vnet subnet create --resource-group gold_eks --vnet-name vnet-gold-eks --name nonroutable1 --address-prefix 100.64.64.0/20
az network vnet subnet create --resource-group gold_eks --vnet-name vnet-gold-eks --name nonroutable2 --address-prefix 100.64.80.0/20

# gold_eksgbd
echo "Creating gold_eksgbd vNet and subnets..."
az group create --name gold_eksgbd --location centralus
az network vnet create --resource-group gold_eksgbd --name vnet-gold-eksgbd --address-prefix 10.10.12.0/16 --location centralus
az network vnet subnet create --resource-group gold_eksgbd --vnet-name vnet-gold-eksgbd --name routable1 --address-prefix 10.10.12.0/23
az network vnet subnet create --resource-group gold_eksgbd --vnet-name vnet-gold-eksgbd --name routable2 --address-prefix 10.10.14.0/23
az network vnet subnet create --resource-group gold_eksgbd --vnet-name vnet-gold-eksgbd --name nonroutable1 --address-prefix 100.64.96.0/20
az network vnet subnet create --resource-group gold_eksgbd --vnet-name vnet-gold-eksgbd --name nonroutable2 --address-prefix 100.64.112.0/20

# prd_eks
echo "Creating prd_eks vNet and subnets..."
az group create --name prd_eks --location centralus
az network vnet create --resource-group prd_eks --name vnet-prd-eks --address-prefix 10.20.0.0/16 --location centralus
az network vnet subnet create --resource-group prd_eks --vnet-name vnet-prd-eks --name routable1 --address-prefix 10.20.0.0/23
az network vnet subnet create --resource-group prd_eks --vnet-name vnet-prd-eks --name routable2 --address-prefix 10.20.2.0/23
az network vnet subnet create --resource-group prd_eks --vnet-name vnet-prd-eks --name routable3 --address-prefix 10.20.4.0/23
az network vnet subnet create --resource-group prd_eks --vnet-name vnet-prd-eks --name nonroutable1 --address-prefix 100.65.0.0/20
az network vnet subnet create --resource-group prd_eks --vnet-name vnet-prd-eks --name nonroutable2 --address-prefix 100.65.16.0/20
az network vnet subnet create --resource-group prd_eks --vnet-name vnet-prd-eks --name nonroutable3 --address-prefix 100.65.32.0/20

# prd_eksgbd
echo "Creating prd_eksgbd vNet and subnets..."
az group create --name prd_eksgbd --location centralus
az network vnet create --resource-group prd_eksgbd --name vnet-prd-eksgbd --address-prefix 10.20.4.0/16 --location centralus
az network vnet subnet create --resource-group prd_eksgbd --vnet-name vnet-prd-eksgbd --name routable1 --address-prefix 10.20.4.0/23
az network vnet subnet create --resource-group prd_eksgbd --vnet-name vnet-prd-eksgbd --name routable2 --address-prefix 10.20.6.0/23
az network vnet subnet create --resource-group prd_eksgbd --vnet-name vnet-prd-eksgbd --name routable3 --address-prefix 10.20.8.0/23
az network vnet subnet create --resource-group prd_eksgbd --vnet-name vnet-prd-eksgbd --name nonroutable1 --address-prefix 100.65.32.0/20
az network vnet subnet create --resource-group prd_eksgbd --vnet-name vnet-prd-eksgbd --name nonroutable2 --address-prefix 100.65.48.0/20
az network vnet subnet create --resource-group prd_eksgbd --vnet-name vnet-prd-eksgbd --name nonroutable3 --address-prefix 100.65.64.0/20

# dr_eks
echo "Creating dr_eks vNet and subnets..."
az group create --name dr_eks --location eastus2
az network vnet create --resource-group dr_eks --name vnet-dr-eks --address-prefix 10.20.8.0/16 --location eastus2
az network vnet subnet create --resource-group dr_eks --vnet-name vnet-dr-eks --name routable1 --address-prefix 10.20.8.0/23
az network vnet subnet create --resource-group dr_eks --vnet-name vnet-dr-eks --name routable2 --address-prefix 10.20.10.0/23
az network vnet subnet create --resource-group dr_eks --vnet-name vnet-dr-eks --name routable3 --address-prefix 10.20.12.0/23
az network vnet subnet create --resource-group dr_eks --vnet-name vnet-dr-eks --name nonroutable1 --address-prefix 100.65.64.0/20
az network vnet subnet create --resource-group dr_eks --vnet-name vnet-dr-eks --name nonroutable2 --address-prefix 100.65.80.0/20
az network vnet subnet create --resource-group dr_eks --vnet-name vnet-dr-eks --name nonroutable3 --address-prefix 100.65.96.0/20

# dr_eksgbd
echo "Creating dr_eksgbd vNet and subnets..."
az group create --name dr_eksgbd --location eastus2
az network vnet create --resource-group dr_eksgbd --name vnet-dr-eksgbd --address-prefix 10.20.12.0/16 --location eastus2
az network vnet subnet create --resource-group dr_eksgbd --vnet-name vnet-dr-eksgbd --name routable1 --address-prefix 10.20.12.0/23
az network vnet subnet create --resource-group dr_eksgbd --vnet-name vnet-dr-eksgbd --name routable2 --address-prefix 10.20.14.0/23
az network vnet subnet create --resource-group dr_eksgbd --vnet-name vnet-dr-eksgbd --name routable3 --address-prefix 10.20.16.0/23
az network vnet subnet create --resource-group dr_eksgbd --vnet-name vnet-dr-eksgbd --name nonroutable1 --address-prefix 100.65.96.0/20
az network vnet subnet create --resource-group dr_eksgbd --vnet-name vnet-dr-eksgbd --name nonroutable2 --address-prefix 100.65.112.0/20
az network vnet subnet create --resource-group dr_eksgbd --vnet-name vnet-dr-eksgbd --name nonroutable3 --address-prefix 100.66.0.0/20

echo "All vNets and subnets created."
