# This Terraform code assumes you have permissions to manage Azure subscriptions and are using the azurerm provider.
# Note: Terraform cannot create Azure subscriptions directly. This code sets up resource groups in existing subscriptions.

provider "azurerm" {
  features = {}
  # Set the subscription_id for each block as needed
}

# Example for Non-Prod Apps Subscription
provider "azurerm" {
  alias           = "nonprod"
  subscription_id = var.nonprod_subscription_id
  features        = {}
}

resource "azurerm_resource_group" "nonprod" {
  provider = azurerm.nonprod
  name     = "rg-nonprod-apps"
  location = var.location
}

resource "azurerm_resource_group" "dev" {
  provider = azurerm.nonprod
  name     = "rg-dev"
  location = var.location
}

# vNet and subnets for dev
resource "azurerm_virtual_network" "dev" {
  name                = "vnet-dev"
  address_space       = ["10.60.0.0/21"]
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
}
resource "azurerm_subnet" "dev_subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.60.0.0/23"]
}
resource "azurerm_subnet" "dev_subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.60.2.0/23"]
}
resource "azurerm_subnet" "dev_subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = ["10.60.4.0/23"]
}
}

resource "azurerm_resource_group" "sit" {
  provider = azurerm.nonprod
  name     = "rg-sit"
  location = var.location
}

# vNet and subnets for sit
resource "azurerm_virtual_network" "sit" {
  name                = "vnet-sit"
  address_space       = ["10.61.0.0/21"]
  location            = azurerm_resource_group.sit.location
  resource_group_name = azurerm_resource_group.sit.name
}
resource "azurerm_subnet" "sit_subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.sit.name
  virtual_network_name = azurerm_virtual_network.sit.name
  address_prefixes     = ["10.61.0.0/23"]
}
resource "azurerm_subnet" "sit_subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.sit.name
  virtual_network_name = azurerm_virtual_network.sit.name
  address_prefixes     = ["10.61.2.0/23"]
}
resource "azurerm_subnet" "sit_subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.sit.name
  virtual_network_name = azurerm_virtual_network.sit.name
  address_prefixes     = ["10.61.4.0/23"]
}
}

resource "azurerm_resource_group" "uat" {
  provider = azurerm.nonprod
  name     = "rg-uat"
  location = var.location
}

# vNet and subnets for uat
resource "azurerm_virtual_network" "uat" {
  name                = "vnet-uat"
  address_space       = ["10.62.0.0/21"]
  location            = azurerm_resource_group.uat.location
  resource_group_name = azurerm_resource_group.uat.name
}
resource "azurerm_subnet" "uat_subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.uat.name
  virtual_network_name = azurerm_virtual_network.uat.name
  address_prefixes     = ["10.62.0.0/23"]
}
resource "azurerm_subnet" "uat_subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.uat.name
  virtual_network_name = azurerm_virtual_network.uat.name
  address_prefixes     = ["10.62.2.0/23"]
}
resource "azurerm_subnet" "uat_subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.uat.name
  virtual_network_name = azurerm_virtual_network.uat.name
  address_prefixes     = ["10.62.4.0/23"]
}
}

resource "azurerm_resource_group" "performance" {
  provider = azurerm.nonprod
  name     = "rg-performance"
  location = var.location
}

# vNet and subnets for performance
resource "azurerm_virtual_network" "performance" {
  name                = "vnet-performance"
  address_space       = ["10.63.0.0/21"]
  location            = azurerm_resource_group.performance.location
  resource_group_name = azurerm_resource_group.performance.name
}
resource "azurerm_subnet" "performance_subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.performance.name
  virtual_network_name = azurerm_virtual_network.performance.name
  address_prefixes     = ["10.63.0.0/23"]
}
resource "azurerm_subnet" "performance_subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.performance.name
  virtual_network_name = azurerm_virtual_network.performance.name
  address_prefixes     = ["10.63.2.0/23"]
}
resource "azurerm_subnet" "performance_subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.performance.name
  virtual_network_name = azurerm_virtual_network.performance.name
  address_prefixes     = ["10.63.4.0/23"]
}
}

resource "azurerm_resource_group" "silver_eks" {
  provider = azurerm.nonprod
  name     = "rg-silver-eks"
  location = var.location
}

resource "azurerm_resource_group" "silver_eksgbd" {
  provider = azurerm.nonprod
  name     = "rg-silver-eksgbd"
  location = var.location
}

resource "azurerm_resource_group" "gold_eks" {
  provider = azurerm.nonprod
  name     = "rg-gold-eks"
  location = var.location
}

resource "azurerm_resource_group" "gold_eksgbd" {
  provider = azurerm.nonprod
  name     = "rg-gold-eksgbd"
  location = var.location
}

# Example for Prod Apps Subscription
provider "azurerm" {
  alias           = "prod"
  subscription_id = var.prod_subscription_id
  features        = {}
}

resource "azurerm_resource_group" "prod" {
  provider = azurerm.prod
  name     = "rg-prod-apps"
  location = var.location
}

# vNet and subnets for prod
resource "azurerm_virtual_network" "prod" {
  name                = "vnet-prod"
  address_space       = ["10.80.0.0/21"]
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
}
resource "azurerm_subnet" "prod_subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.prod.name
  virtual_network_name = azurerm_virtual_network.prod.name
  address_prefixes     = ["10.80.0.0/23"]
}
resource "azurerm_subnet" "prod_subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.prod.name
  virtual_network_name = azurerm_virtual_network.prod.name
  address_prefixes     = ["10.80.2.0/23"]
}
resource "azurerm_subnet" "prod_subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.prod.name
  virtual_network_name = azurerm_virtual_network.prod.name
  address_prefixes     = ["10.80.4.0/23"]
}
}

resource "azurerm_resource_group" "production" {
  provider = azurerm.prod
  name     = "rg-production"
  location = var.location
}

resource "azurerm_resource_group" "dr" {
  provider = azurerm.prod
  name     = "rg-dr"
  location = var.location
}

# vNet and subnets for dr
resource "azurerm_virtual_network" "dr" {
  name                = "vnet-dr"
  address_space       = ["10.81.0.0/21"]
  location            = azurerm_resource_group.dr.location
  resource_group_name = azurerm_resource_group.dr.name
}
resource "azurerm_subnet" "dr_subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.dr.name
  virtual_network_name = azurerm_virtual_network.dr.name
  address_prefixes     = ["10.81.0.0/23"]
}
resource "azurerm_subnet" "dr_subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.dr.name
  virtual_network_name = azurerm_virtual_network.dr.name
  address_prefixes     = ["10.81.2.0/23"]
}
resource "azurerm_subnet" "dr_subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.dr.name
  virtual_network_name = azurerm_virtual_network.dr.name
  address_prefixes     = ["10.81.4.0/23"]
}
}

# DR Resource Group vNet and Subnets (non-overlapping with prod)
resource "azurerm_virtual_network" "dr" {
  name                = "vnet-dr"
  address_space       = ["10.81.0.0/21"]
  location            = azurerm_resource_group.dr.location
  resource_group_name = azurerm_resource_group.dr.name
}

resource "azurerm_subnet" "dr_routable1" {
  name                 = "routable1"
  resource_group_name  = azurerm_resource_group.dr.name
  virtual_network_name = azurerm_virtual_network.dr.name
  address_prefixes     = ["10.81.0.0/23"]
}
  # resource "azurerm_subnet" "dev_nonroutable2" {
  #   name                 = "nonroutable2"
  #   resource_group_name  = azurerm_resource_group.dev.name
  #   virtual_network_name = azurerm_virtual_network.dev.name
  #   address_prefixes     = ["100.66.16.0/20"]
  # }
}

resource "azurerm_resource_group" "prd_eks" {
  provider = azurerm.prod
  name     = "rg-prd-eks"
  location = var.location
}

resource "azurerm_resource_group" "prd_eksgbd" {
  provider = azurerm.prod
  name     = "rg-prd-eksgbd"
  location = var.location
}

resource "azurerm_resource_group" "dr_eks" {
  provider = azurerm.prod
  name     = "rg-dr-eks"
  location = var.location
}

resource "azurerm_resource_group" "dr_eksgbd" {
  provider = azurerm.prod
  name     = "rg-dr-eksgbd"
  location = var.location
}

# Example for Connectivity Subscription
provider "azurerm" {
  alias           = "connectivity"
  subscription_id = var.connectivity_subscription_id
  features        = {}
}

resource "azurerm_resource_group" "connectivityhub" {
  provider = azurerm.connectivity
  name     = "rg-connectivityhub"
  location = var.location
}

resource "azurerm_resource_group" "connectivity_eastus" {
  provider = azurerm.connectivity
  name     = "rg-connectivity-eastus"
  location = var.location
}

# Example for Tenants Subscription
provider "azurerm" {
  alias           = "tenants"
  subscription_id = var.tenants_subscription_id
  features        = {}
}

resource "azurerm_resource_group" "tenants" {
  provider = azurerm.tenants
  name     = "rg-tenants"
  location = var.location
}

resource "azurerm_resource_group" "tenant001" {
  provider = azurerm.tenants
  name     = "rg-tenant001"
  location = var.location
}

resource "azurerm_resource_group" "tenant002" {
  provider = azurerm.tenants
  name     = "rg-tenant002"
  location = var.location
}

# Example for Shared Services Subscription
provider "azurerm" {
  alias           = "sharedservices"
  subscription_id = var.sharedservices_subscription_id
  features        = {}
}

resource "azurerm_resource_group" "tools" {
  provider = azurerm.sharedservices
  name     = "rg-tools"
  location = var.location
}

resource "azurerm_virtual_network" "tools" {
  name                = "vnet-tools"
  address_space       = ["10.30.0.0/21"]
  location            = var.location
  resource_group_name = azurerm_resource_group.tools.name
}

resource "azurerm_subnet" "tools_subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.tools.name
  virtual_network_name = azurerm_virtual_network.tools.name
  address_prefixes     = ["10.30.0.0/23"]
}

resource "azurerm_subnet" "tools_subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.tools.name
  virtual_network_name = azurerm_virtual_network.tools.name
  address_prefixes     = ["10.30.2.0/23"]
}

resource "azurerm_subnet" "tools_subnet3" {
  name                 = "subnet3"
  resource_group_name  = azurerm_resource_group.tools.name
  virtual_network_name = azurerm_virtual_network.tools.name
  address_prefixes     = ["10.30.4.0/23"]
}

resource "azurerm_subnet" "tools_subnet4" {
  # Removed: Only three /23 subnets required for tools RG
}

variable "location" {
  description = "Azure region for all resource groups"
  default     = "eastus"
}

variable "nonprod_subscription_id" {}
variable "prod_subscription_id" {}
variable "connectivity_subscription_id" {}
variable "tenants_subscription_id" {}
variable "sharedservices_subscription_id" {}

# POLICY: No public subnets are allowed in any resource group except those in the connectivity subscription.
# - All non-connectivity resource groups must use only private subnets.
# - Public subnet creation should be restricted and monitored via policy in the connectivity subscription.
# - Enforce this via Azure Policy or manual review as needed.

# POLICY: All public egress and ingress traffic must flow through the connectivity subscription via a centralized firewall.
# - No direct public access is allowed from any other resource group or subscription.
# - Deploy and manage Azure Firewall (or equivalent) in the connectivity subscription for all internet-bound traffic.
# - Enforce UDRs and NSGs to ensure all public traffic routes through the firewall.

# POLICY: All subnets in every resource group must use private IP address ranges only.
# - Do not assign public IPs to subnets or resources, except as managed by the connectivity subscription's firewall.
# - Use 100.x.x.x address space (e.g., 100.64.0.0/10 or subnets thereof) for non-routable private subnets in each resource group.
# - Overlap of 100.x.x.x subnets is allowed across different resource groups.
# - Enforce this via subnet definitions and Azure Policy as needed.

# POLICY: Use 100.x.x.x address space (e.g., 100.64.0.0/10 or subnets thereof) for non-routable private IPs in each resource group.
# - Example for non-routable subnets: 100.64.0.0/20, 100.64.16.0/20, etc.
# - Overlap of 100.x.x.x subnets is allowed across different resource groups.
# - This aligns with RFC6598 (Carrier-Grade NAT address space).

# NOTE: All TCP and TLS routing between resource groups is handled via the connectivity subscription.
# Ensure that any cross-resource-group networking leverages resources (e.g., vNets, firewalls, gateways) defined in the connectivity subscription.
# Do not implement direct peering or routing between non-connectivity resource groups; always route through connectivity.
# Example: Use vNet peering or Azure Firewall in the connectivity subscription for secure routing.

# POLICY: Do not use vNet peering between virtual networks.
# - All cross-subscription and cross-resource-group routing must use custom User Defined Routes (UDRs).
# - UDRs should direct traffic through the connectivity subscription's firewall and virtual appliances as required.
# - This ensures centralized control and inspection of all inter-network traffic.

# POLICY: Shared Services must connect to non-prod and prod resource groups only via the connectivity subscription.
# - All network traffic between shared services and other environments must traverse the connectivity subscription's firewall and custom UDRs.
# - No direct network connections (e.g., vNet peering) between shared services and non-prod/prod vNets are allowed.
# - This ensures centralized control, inspection, and logging of all inter-environment traffic.

# ARCHITECTURE: Hub-and-Spoke using UDRs
# - The connectivity subscription acts as the central hub for all networking.
# - All non-prod, prod, shared services, and tenants subscriptions are spokes.
# - Each spoke connects to the hub (connectivity) via custom User Defined Routes (UDRs).
# - No direct peering or routing between spokes; all inter-spoke traffic must traverse the hub's firewall.
# - The hub manages all public ingress/egress and centralized inspection.
#
# Diagram:
#
#         +-------------------+
#         | Connectivity (Hub)|
#         |  Firewall, UDRs   |
#         +-------------------+
#           /   |    |    \
#          /    |    |     \
#         v     v    v      v
#   +--------+ +--------+ +--------+ +--------+
#   |Non-Prod| |  Prod  | | Shared | | Tenants|
#   | (Spoke)| | (Spoke)| |Services| | (Spoke)|
#   +--------+ +--------+ +--------+ +--------+
#
# - All routing between spokes and to/from the internet is enforced via the hub's UDRs and firewall.
 
 # POLICY: No public subnets are allowed in any resource group except those in the connectivity subscription.
 # - All non-connectivity resource groups must use only private subnets.
 # - Public subnet creation should be restricted and monitored via policy in the connectivity subscription.
 # - Enforce this via Azure Policy or manual review as needed.
 
 # POLICY: All public egress and ingress traffic must flow through the connectivity subscription via a centralized firewall.
 # - No direct public access is allowed from any other resource group or subscription.
 # - Deploy and manage Azure Firewall (or equivalent) in the connectivity subscription for all internet-bound traffic.
 # - Enforce UDRs and NSGs to ensure all public traffic routes through the firewall.
 
 # POLICY: All subnets in every resource group must use private IP address ranges only.
 # - Do not assign public IPs to subnets or resources, except as managed by the connectivity subscription's firewall.
 # - Use 100.x.x.x address space (e.g., 100.64.0.0/10 or subnets thereof) for non-routable private subnets in each resource group.
 # - Overlap of 100.x.x.x subnets is allowed across different resource groups.
 # - Enforce this via subnet definitions and Azure Policy as needed.
 
 # POLICY: Use 100.x.x.x address space (e.g., 100.64.0.0/10 or subnets thereof) for non-routable private IPs in each resource group.
 # - Example for non-routable subnets: 100.64.0.0/20, 100.64.16.0/20, etc.
 # - Overlap of 100.x.x.x subnets is allowed across different resource groups.
 # - This aligns with RFC6598 (Carrier-Grade NAT address space).
 
 # NOTE: All TCP and TLS routing between resource groups is handled via the connectivity subscription.
 # Ensure that any cross-resource-group networking leverages resources (e.g., vNets, firewalls, gateways) defined in the connectivity subscription.
 # Do not implement direct peering or routing between non-connectivity resource groups; always route through connectivity.
 # Example: Use vNet peering or Azure Firewall in the connectivity subscription for secure routing.
 
 # POLICY: Do not use vNet peering between virtual networks.
 # - All cross-subscription and cross-resource-group routing must use custom User Defined Routes (UDRs).
 # - UDRs should direct traffic through the connectivity subscription's firewall and virtual appliances as required.
 # - This ensures centralized control and inspection of all inter-network traffic.
 
 # POLICY: Shared Services must connect to non-prod and prod resource groups only via the connectivity subscription.
 # - All network traffic between shared services and other environments must traverse the connectivity subscription's firewall and custom UDRs.
 # - No direct network connections (e.g., vNet peering) between shared services and non-prod/prod vNets are allowed.
 # - This ensures centralized control, inspection, and logging of all inter-environment traffic.
 
 # ARCHITECTURE: Hub-and-Spoke using UDRs
 # - The connectivity subscription acts as the central hub for all networking.
 # - All non-prod, prod, shared services, and tenants subscriptions are spokes.
 # - Each spoke connects to the hub (connectivity) via custom User Defined Routes (UDRs).
 # - No direct peering or routing between spokes; all inter-spoke traffic must traverse the hub's firewall.
 # - The hub manages all public ingress/egress and centralized inspection.
 #
 # Diagram:
 #
 #         +-------------------+
 #         | Connectivity (Hub)|
 #         |  Firewall, UDRs   |
 #         +-------------------+
 #           /   |    |    \
 #          /    |    |     \
 #         v     v    v      v
 #   +--------+ +--------+ +--------+ +--------+
 #   |Non-Prod| |  Prod  | | Shared | | Tenants|
 #   | (Spoke)| | (Spoke)| |Services| | (Spoke)|
 #   +--------+ +--------+ +--------+ +--------+
 #
 # - All routing between spokes and to/from the internet is enforced via the hub's UDRs and firewall.

# EXAMPLE: Define 4 private subnets, each with 256 available IPs (i.e., /24 CIDR blocks)
# Example CIDR blocks: 10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24
#
# resource "azurerm_virtual_network" "example" {
#   name                = "vnet-example"
#   address_space       = ["10.0.0.0/22"]
#   location            = var.location
#   resource_group_name = azurerm_resource_group.dev.name
# }
#
# resource "azurerm_subnet" "subnet1" {
#   name                 = "subnet1"
#   resource_group_name  = azurerm_resource_group.dev.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.0.0/24"]
# }
# resource "azurerm_subnet" "subnet2" {
#   name                 = "subnet2"
#   resource_group_name  = azurerm_resource_group.dev.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.1.0/24"]
# }
# resource "azurerm_subnet" "subnet3" {
#   name                 = "subnet3"
#   resource_group_name  = azurerm_resource_group.dev.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.2.0/24"]
# }
# resource "azurerm_subnet" "subnet4" {
#   name                 = "subnet4"
#   resource_group_name  = azurerm_resource_group.dev.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = ["10.0.3.0/24"]
# }
# EXAMPLE: For each EKS and EKSGBD resource group, define:
# - 2 subnets with 512 routable private IPs each (/23 CIDR)
# - 2 subnets with 4096 non-routable private IPs each (/20 CIDR)
#
# Example for rg-silver-eks:
# resource "azurerm_virtual_network" "silver_eks" {
#   name                = "vnet-silver-eks"
#   address_space       = ["10.10.0.0/16"]
#   location            = var.location
#   resource_group_name = azurerm_resource_group.silver_eks.name
# }
# resource "azurerm_subnet" "silver_eks_routable1" {
#   name                 = "routable1"
#   resource_group_name  = azurerm_resource_group.silver_eks.name
#   virtual_network_name = azurerm_virtual_network.silver_eks.name
#   address_prefixes     = ["10.10.0.0/23"]
# }
# resource "azurerm_subnet" "silver_eks_routable2" {
#   name                 = "routable2"
#   resource_group_name  = azurerm_resource_group.silver_eks.name
#   virtual_network_name = azurerm_virtual_network.silver_eks.name
#   address_prefixes     = ["10.10.2.0/23"]
# }
# resource "azurerm_subnet" "silver_eks_nonroutable1" {
#   name                 = "nonroutable1"
#   resource_group_name  = azurerm_resource_group.silver_eks.name
#   virtual_network_name = azurerm_virtual_network.silver_eks.name
#   address_prefixes     = ["10.10.4.0/20"]
# }
# resource "azurerm_subnet" "silver_eks_nonroutable2" {
#   name                 = "nonroutable2"
#   resource_group_name  = azurerm_resource_group.silver_eks.name
#   virtual_network_name = azurerm_virtual_network.silver_eks.name
#   address_prefixes     = ["10.10.20.0/20"]
# }
#
# Repeat this pattern for each EKS and EKSGBD resource group, adjusting address spaces as needed to avoid overlap.

# EXAMPLE: Subnet CIDR assignments for EKS/EKSGBD resource groups
#
# RG: silver_eks
#   - routable1:     10.10.0.0/23   (512 IPs)
#   - routable2:     10.10.2.0/23   (512 IPs)
#   - nonroutable1:  100.64.0.0/20  (4096 IPs)
#   - nonroutable2:  100.64.16.0/20 (4096 IPs)
#
# RG: silver_eksgbd
#   - routable1:     10.10.4.0/23   (512 IPs)
#   - routable2:     10.10.6.0/23   (512 IPs)
#   - nonroutable1:  100.64.32.0/20 (4096 IPs)
#   - nonroutable2:  100.64.48.0/20 (4096 IPs)
#
# RG: gold_eks
#   - routable1:     10.10.8.0/23   (512 IPs)
#   - routable2:     10.10.10.0/23  (512 IPs)
#   - nonroutable1:  100.64.64.0/20 (4096 IPs)
#   - nonroutable2:  100.64.80.0/20 (4096 IPs)
#
# RG: gold_eksgbd
#   - routable1:     10.10.12.0/23  (512 IPs)
#   - routable2:     10.10.14.0/23  (512 IPs)
#   - nonroutable1:  100.64.96.0/20 (4096 IPs)
#   - nonroutable2:  100.64.112.0/20 (4096 IPs)
#
# Repeat this pattern for prod and dr EKS/EKSGBD RGs, incrementing the CIDR blocks to avoid overlap.

# EXAMPLE: Subnet CIDR assignments for EKS/EKSGBD resource groups in prod subscription
#
# RG: prd_eks
#   - routable1:     10.20.0.0/23    (512 IPs)
#   - routable2:     10.20.2.0/23    (512 IPs)
#   - nonroutable1:  100.65.0.0/20   (4096 IPs)
#   - nonroutable2:  100.65.16.0/20  (4096 IPs)
#
# RG: prd_eksgbd
#   - routable1:     10.20.4.0/23    (512 IPs)
#   - routable2:     10.20.6.0/23    (512 IPs)
#   - nonroutable1:  100.65.32.0/20  (4096 IPs)
#   - nonroutable2:  100.65.48.0/20  (4096 IPs)
#
# RG: dr_eks
#   - routable1:     10.20.8.0/23    (512 IPs)
#   - routable2:     10.20.10.0/23   (512 IPs)
#   - nonroutable1:  100.65.64.0/20  (4096 IPs)
#   - nonroutable2:  100.65.80.0/20  (4096 IPs)
#
# RG: dr_eksgbd
#   - routable1:     10.20.12.0/23   (512 IPs)
#   - routable2:     10.20.14.0/23   (512 IPs)
#   - nonroutable1:  100.65.96.0/20  (4096 IPs)
#   - nonroutable2:  100.65.112.0/20 (4096 IPs)
#
# Repeat this pattern for any additional EKS/EKSGBD resource groups, incrementing the CIDR blocks to avoid overlap.

# RG: tenant001
#   - vNet
#   - Subnets:
#     * subnet1: 10.40.0.0/25   (128 IPs)
#     * subnet2: 10.40.0.128/25 (128 IPs)
#
# RG: tenant002
#   - vNet
#   - Subnets:
#     * subnet1: 10.40.1.0/25   (128 IPs)
#     * subnet2: 10.40.1.128/25 (128 IPs)
#
# Example Terraform resources:
# resource "azurerm_virtual_network" "tenant001" {
#   name                = "vnet-tenant001"
#   address_space       = ["10.40.0.0/24"]
#   location            = var.location
#   resource_group_name = azurerm_resource_group.tenant001.name
# }
# resource "azurerm_subnet" "tenant001_subnet1" {
#   name                 = "subnet1"
#   resource_group_name  = azurerm_resource_group.tenant001.name
#   virtual_network_name = azurerm_virtual_network.tenant001.name
#   address_prefixes     = ["10.40.0.0/25"]
# }
# resource "azurerm_subnet" "tenant001_subnet2" {
#   name                 = "subnet2"
#   resource_group_name  = azurerm_resource_group.tenant001.name
#   virtual_network_name = azurerm_virtual_network.tenant001.name
#   address_prefixes     = ["10.40.0.128/25"]
# }
# resource "azurerm_virtual_network" "tenant002" {
#   name                = "vnet-tenant002"
#   address_space       = ["10.40.1.0/24"]
#   location            = var.location
#   resource_group_name = azurerm_resource_group.tenant002.name
# }
# resource "azurerm_subnet" "tenant002_subnet1" {
#   name                 = "subnet1"
#   resource_group_name  = azurerm_resource_group.tenant002.name
#   virtual_network_name = azurerm_virtual_network.tenant002.name
#   address_prefixes     = ["10.40.1.0/25"]
# }
# resource "azurerm_subnet" "tenant002_subnet2" {
#   name                 = "subnet2"
#   resource_group_name  = azurerm_resource_group.tenant002.name
#   virtual_network_name = azurerm_virtual_network.tenant002.name
#   address_prefixes     = ["10.40.1.128/25"]
# }

# REGION POLICY:
# - All subnets for the dr resource group are deployed in the us-east2 region.
# - All other subnets (non-prod, prod, tools, tenants, connectivity) are deployed in the us-central region.
# - Set the location property accordingly in each resource definition.
#
# Example:
# resource "azurerm_virtual_network" "dr_eks" {
#   name                = "vnet-dr-eks"
#   address_space       = ["10.20.8.0/21"]
#   location            = "us-east2"
#   resource_group_name = azurerm_resource_group.dr_eks.name
# }
# resource "azurerm_virtual_network" "dev" {
#   name                = "vnet-dev"
#   address_space       = ["10.10.0.0/21"]
#   location            = "us-central"
#   resource_group_name = azurerm_resource_group.dev.name
# }

# INTERNET INGRESS:
# - All internet ingress (public inbound traffic) is allowed only via the connectivityhub resource group.
# - Deploy and manage public IPs, load balancers, and Azure Firewall in connectivityhub for all inbound scenarios.
# - No other resource group or subnet is permitted to have direct public ingress.
# - Example:
# resource "azurerm_public_ip" "connectivityhub_ingress" {
#   name                = "pip-connectivityhub-ingress"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.connectivityhub.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# INTERNET EGRESS GATEWAY:
# - All internet egress (outbound traffic) must route through a centralized egress gateway in the connectivityhub resource group.
# - Deploy and manage Azure Firewall or NAT Gateway in connectivityhub for all outbound scenarios.
# - No other resource group or subnet is permitted to have direct public egress.
# - Example:
# resource "azurerm_firewall" "connectivityhub_egress" {
#   name                = "fw-connectivityhub-egress"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.connectivityhub.name
#   sku_name            = "AZFW_VNet"
#   sku_tier            = "Standard"
# }

# DR CAPABILITY:
# - Each of the following resource groups must have a corresponding DR (Disaster Recovery) resource group in the us-east2 region:
#   * connectivityhub
#   * tools
#   * tenants (tenant001, tenant002, etc.)
# - DR resource groups should mirror the primary resource group structure and subnets, but be deployed in us-east2.
# - Example naming: rg-connectivityhub-dr, rg-tools-dr, rg-tenant001-dr, etc.
#
# Example Terraform resource for DR RG:
# resource "azurerm_resource_group" "connectivityhub_dr" {
#   provider = azurerm.connectivity
#   name     = "rg-connectivityhub-dr"
#   location = "us-east2"
# }
# resource "azurerm_resource_group" "tools_dr" {
#   provider = azurerm.sharedservices
#   name     = "rg-tools-dr"
#   location = "us-east2"
# }
# resource "azurerm_resource_group" "tenant001_dr" {
#   provider = azurerm.tenants
#   name     = "rg-tenant001-dr"
#   location = "us-east2"
# }
# resource "azurerm_resource_group" "tenant002_dr" {
#   provider = azurerm.tenants
#   name     = "rg-tenant002-dr"
#   location = "us-east2"
# }

# DR Resource Group: connectivityhub-dr (us-east2)
#   - vNet: us-east2
#   - Public Subnets:
#       public1: 10.70.0.0/22    (1024 IPs)
#       public2: 10.70.4.0/22    (1024 IPs)
#       public3: 10.70.8.0/22    (1024 IPs)
#       public4: 10.70.12.0/22   (1024 IPs)
#
# Example Terraform resources:
# resource "azurerm_virtual_network" "connectivityhub_dr" {
#   name                = "vnet-connectivityhub-dr"
#   address_space       = ["10.70.0.0/22"]
#   location            = "us-east2"
#   resource_group_name = azurerm_resource_group.connectivityhub_dr.name
# }
# resource "azurerm_subnet" "connectivityhub_dr_public1" {
#   name                 = "public1"
#   resource_group_name  = azurerm_resource_group.connectivityhub_dr.name
#   virtual_network_name = azurerm_virtual_network.connectivityhub_dr.name
#   address_prefixes     = ["10.70.0.0/22"]
# }
# resource "azurerm_subnet" "connectivityhub_dr_public2" {
#   name                 = "public2"
#   resource_group_name  = azurerm_resource_group.connectivityhub_dr.name
#   virtual_network_name = azurerm_virtual_network.connectivityhub_dr.name
#   address_prefixes     = ["10.70.4.0/22"]
# }
# resource "azurerm_subnet" "connectivityhub_dr_public3" {
#   name                 = "public3"
#   resource_group_name  = azurerm_resource_group.connectivityhub_dr.name
#   virtual_network_name = azurerm_virtual_network.connectivityhub_dr.name
#   address_prefixes     = ["10.70.8.0/22"]
# }
# resource "azurerm_subnet" "connectivityhub_dr_public4" {
#   name                 = "public4"
#   resource_group_name  = azurerm_resource_group.connectivityhub_dr.name
#   virtual_network_name = azurerm_virtual_network.connectivityhub_dr.name
#   address_prefixes     = ["10.70.12.0/22"]
# }

# -----------------------------------------------------------------------------
# CONNECTIVITYHUB-DR RESOURCE GROUP ARCHITECTURE (us-east2)
# -----------------------------------------------------------------------------
#
# Subnet Table:
# | Subnet Name | CIDR Block      | Purpose         |
# |-------------|----------------|-----------------|
# | public1     | 10.70.0.0/22   | Public routing  |
# | public2     | 10.70.4.0/22   | Public routing  |
# | firewall1   | 10.70.8.0/22   | Azure Firewall  |
# | firewall2   | 10.70.10.0/22  | Azure Firewall  |
# | private1    | 10.70.12.0/22  | Private routing |
# | private2    | 10.70.16.0/22  | Private routing |
#
# ASCII Diagram:
#
#   +-----------------------------+
#   |   vnet-connectivityhub-dr   |
#   |   10.70.0.0/20              |
#   +-----------------------------+
#   | public1      10.70.0.0/22   |
#   | public2      10.70.4.0/22   |
#   | firewall1    10.70.8.0/22   |
#   | firewall2    10.70.10.0/22  |
#   | private1     10.70.12.0/22  |
#   | private2     10.70.16.0/22  |
#   +-----------------------------+

# -----------------------------------------------------------------------------
# Azure Landing Zone Architecture Documentation (Full)
# -----------------------------------------------------------------------------

## Complete Resource Group and Subnet Table (Grouped by Subscription and Resource Group)

### Connectivity Subscription
| Resource Group         | Region      | vNet Name                | vNet CIDR         | Subnet Name     | Subnet CIDR        | Size (IPs) | Type         |
|-----------------------|-------------|--------------------------|-------------------|------------------|--------------------|------------|--------------|
| connectivityhub       | us-central  | vnet-connectivityhub     | 10.50.0.0/16      | public1         | 10.50.0.0/23       | 512        | Public       |
|                       |             |                          |                   | public2         | 10.50.2.0/23       | 512        | Public       |
|                       |             |                          |                   | firewall1       | 10.50.4.0/27       | 32         | Firewall     |
|                       |             |                          |                   | firewall2       | 10.50.4.32/27      | 32         | Firewall     |
|                       |             |                          |                   | private1        | 10.50.8.0/23       | 512        | Private      |
|                       |             |                          |                   | private2        | 10.50.10.0/23      | 512        | Private      |
| connectivityhub-dr    | us-east2    | vnet-connectivityhub-dr  | 10.70.0.0/20      | public1         | 10.70.0.0/23       | 512        | Public       |
|                       |             |                          |                   | public2         | 10.70.2.0/23       | 512        | Public       |
|                       |             |                          |                   | firewall1       | 10.70.4.0/27       | 32         | Firewall     |
|                       |             |                          |                   | firewall2       | 10.70.4.32/27      | 32         | Firewall     |
|                       |             |                          |                   | private1        | 10.70.8.0/23       | 512        | Private      |
|                       |             |                          |                   | private2        | 10.70.10.0/23      | 512        | Private      |

### Non-Prod Apps Subscription
| Resource Group         | Region      | vNet Name                | vNet CIDR         | Subnet Name     | Subnet CIDR        | Size (IPs) | Type         |
|-----------------------|-------------|--------------------------|-------------------|------------------|--------------------|------------|--------------|
| rg-dev                | us-central  | vnet-dev                 | 10.60.0.0/21      | subnet1         | 10.60.0.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet2         | 10.60.2.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet3         | 10.60.4.0/23       | 512        | Private      |

#### Additional Resources for dev
| Resource Type         | Name                | Associated Subnet   | Tags                  |
|----------------------|---------------------|---------------------|-----------------------|
| Network Security Group| nsg-dev-subnet1     | subnet1             | environment=dev       |
| Network Security Group| nsg-dev-subnet2     | subnet2             | environment=dev       |
| Network Security Group| nsg-dev-subnet3     | subnet3             | environment=dev       |
| Route Table           | rt-dev-subnet1      | subnet1             | environment=dev       |
| Route Table           | rt-dev-subnet2      | subnet2             | environment=dev       |
| Route Table           | rt-dev-subnet3      | subnet3             | environment=dev       |
| Tag                   | environment=dev     | vnet-dev            | owner=network         |
| rg-sit                | us-central  | vnet-sit                 | 10.61.0.0/21      | subnet1         | 10.61.0.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet2         | 10.61.2.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet3         | 10.61.4.0/23       | 512        | Private      |
| rg-uat                | us-central  | vnet-uat                 | 10.62.0.0/21      | subnet1         | 10.62.0.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet2         | 10.62.2.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet3         | 10.62.4.0/23       | 512        | Private      |
| rg-performance        | us-central  | vnet-performance         | 10.63.0.0/21      | subnet1         | 10.63.0.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet2         | 10.63.2.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet3         | 10.63.4.0/23       | 512        | Private      |
| rg-silver-eks         | us-central  | vnet-silver-eks          | 10.10.0.0/16      | routable1       | 10.10.0.0/23       | 512        | Private      |
|                       |             |                          |                   | routable2       | 10.10.2.0/23       | 512        | Private      |
|                       |             |                          |                   | nonroutable1    | 100.64.0.0/20      | 4096       | Private      |
|                       |             |                          |                   | nonroutable2    | 100.64.16.0/20     | 4096       | Private      |
| rg-silver-eksgbd      | us-central  | vnet-silver-eksgbd       | 10.10.4.0/16      | routable1       | 10.10.4.0/23       | 512        | Private      |
|                       |             |                          |                   | routable2       | 10.10.6.0/23       | 512        | Private      |
|                       |             |                          |                   | nonroutable1    | 100.64.32.0/20     | 4096       | Private      |
|                       |             |                          |                   | nonroutable2    | 100.64.48.0/20     | 4096       | Private      |
| rg-gold-eks           | us-central  | vnet-gold-eks            | 10.10.8.0/16      | routable1       | 10.10.8.0/23       | 512        | Private      |
|                       |             |                          |                   | routable2       | 10.10.10.0/23      | 512        | Private      |
|                       |             |                          |                   | nonroutable1    | 100.64.64.0/20     | 4096       | Private      |
|                       |             |                          |                   | nonroutable2    | 100.64.80.0/20     | 4096       | Private      |
| rg-gold-eksgbd        | us-central  | vnet-gold-eksgbd         | 10.10.12.0/16     | routable1       | 10.10.12.0/23      | 512        | Private      |
|                       |             |                          |                   | routable2       | 10.10.14.0/23      | 512        | Private      |
|                       |             |                          |                   | nonroutable1    | 100.64.96.0/20     | 4096       | Private      |
|                       |             |                          |                   | nonroutable2    | 100.64.112.0/20    | 4096       | Private      |

### Prod Apps Subscription
| Resource Group         | Region      | vNet Name                | vNet CIDR         | Subnet Name     | Subnet CIDR        | Size (IPs) | Type         |
|-----------------------|-------------|--------------------------|-------------------|------------------|--------------------|------------|--------------|
| rg-prod               | us-central  | vnet-prod                | 10.80.0.0/21      | subnet1         | 10.80.0.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet2         | 10.80.2.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet3         | 10.80.4.0/23       | 512        | Private      |
| rg-dr                 | us-east2    | vnet-dr                  | 10.81.0.0/21      | subnet1         | 10.81.0.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet2         | 10.81.2.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet3         | 10.81.4.0/23       | 512        | Private      |
| rg-prd-eks            | us-central  | vnet-prd-eks             | 10.20.0.0/16      | routable1       | 10.20.0.0/23       | 512        | Private      |
|                       |             |                          |                   | routable2       | 10.20.2.0/23       | 512        | Private      |
|                       |             |                          |                   | nonroutable1    | 100.65.0.0/20      | 4096       | Private      |
|                       |             |                          |                   | nonroutable2    | 100.65.16.0/20     | 4096       | Private      |
| rg-prd-eksgbd         | us-central  | vnet-prd-eksgbd          | 10.20.4.0/16      | routable1       | 10.20.4.0/23       | 512        | Private      |
|                       |             |                          |                   | routable2       | 10.20.6.0/23       | 512        | Private      |
|                       |             |                          |                   | nonroutable1    | 100.65.32.0/20     | 4096       | Private      |
|                       |             |                          |                   | nonroutable2    | 100.65.48.0/20     | 4096       | Private      |
| rg-dr-eks             | us-east2    | vnet-dr-eks              | 10.20.8.0/16      | routable1       | 10.20.8.0/23       | 512        | Private      |
|                       |             |                          |                   | routable2       | 10.20.10.0/23      | 512        | Private      |
|                       |             |                          |                   | nonroutable1    | 100.65.64.0/20     | 4096       | Private      |
|                       |             |                          |                   | nonroutable2    | 100.65.80.0/20     | 4096       | Private      |
| rg-dr-eksgbd          | us-east2    | vnet-dr-eksgbd           | 10.20.12.0/16     | routable1       | 10.20.12.0/23      | 512        | Private      |
|                       |             |                          |                   | routable2       | 10.20.14.0/23      | 512        | Private      |
|                       |             |                          |                   | nonroutable1    | 100.65.96.0/20     | 4096       | Private      |
|                       |             |                          |                   | nonroutable2    | 100.65.112.0/20    | 4096       | Private      |

### Shared Services Subscription
| Resource Group         | Region      | vNet Name                | vNet CIDR         | Subnet Name     | Subnet CIDR        | Size (IPs) | Type         |
|-----------------------|-------------|--------------------------|-------------------|------------------|--------------------|------------|--------------|
| rg-tools              | us-central  | vnet-tools               | 10.30.0.0/21      | subnet1         | 10.30.0.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet2         | 10.30.2.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet3         | 10.30.4.0/23       | 512        | Private      |
| rg-tools-dr           | us-east2    | vnet-tools-dr            | 10.31.0.0/21      | subnet1         | 10.31.0.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet2         | 10.31.2.0/23       | 512        | Private      |
|                       |             |                          |                   | subnet3         | 10.31.4.0/23       | 512        | Private      |

### Tenants Subscription
| Resource Group         | Region      | vNet Name                | vNet CIDR         | Subnet Name     | Subnet CIDR        | Size (IPs) | Type         |
|-----------------------|-------------|--------------------------|-------------------|------------------|--------------------|------------|--------------|
| rg-tenant001          | us-central  | vnet-tenant001           | 10.40.0.0/24      | subnet1         | 10.40.0.0/25       | 128        | Private      |
|                       |             |                          |                   | subnet2         | 10.40.0.128/25     | 128        | Private      |
| rg-tenant002          | us-central  | vnet-tenant002           | 10.40.1.0/24      | subnet1         | 10.40.1.0/25       | 128        | Private      |
|                       |             |                          |                   | subnet2         | 10.40.1.128/25     | 128        | Private      |

#### NSGs, Route Tables, and Tags for Tenants Subscription
| Resource Group         | NSG Name                | Associated Subnet   | Route Table Name      | Tags                  |
|-----------------------|-------------------------|---------------------|----------------------|-----------------------|
| rg-tenant001          | nsg-tenant001-subnet1   | subnet1             | rt-tenant001-subnet1  | environment=tenant001 |
| rg-tenant001          | nsg-tenant001-subnet2   | subnet2             | rt-tenant001-subnet2  | environment=tenant001 |
| rg-tenant002          | nsg-tenant002-subnet1   | subnet1             | rt-tenant002-subnet1  | environment=tenant002 |
| rg-tenant002          | nsg-tenant002-subnet2   | subnet2             | rt-tenant002-subnet2  | environment=tenant002 |
## ASCII Diagram (Sample)

```
connectivityhub (10.50.0.0/16)
  +-----------+-----------+-----------+-----------+-----------+-----------+
  |  public1  |  public2  | firewall1 | firewall2 | private1  | private2  |
  +-----------+-----------+-----------+-----------+-----------+-----------+
  |10.50.0.0  |10.50.4.0  |10.50.8.0  |10.50.10.0 |10.50.16.0 |10.50.20.0 |
  |   /22     |   /22     |   /23     |   /23     |   /22     |   /22     |
  +-----------+-----------+-----------+-----------+-----------+-----------+
dev (10.60.0.0/21)
  +-----------+-----------+
  |routable1  |routable2  |
  +-----------+-----------+
  |10.60.0.0  |10.60.2.0  |
  |   /23     |   /23     |
  +-----------+-----------+
  subgraph HUB["connectivityhub (us-central)"]
    PUB1["public1\n10.50.0.0/22"]
    PUB2["public2\n10.50.4.0/22"]
    F1["firewall1\n10.50.8.0/23"]
    F2["firewall2\n10.50.10.0/23"]
    PRIV1["private1\n10.50.16.0/22"]
    PRIV2["private2\n10.50.20.0/22"]
    PUB1 --> PUB2 --> F1 --> F2 --> PRIV1 --> PRIV2
  end
  subgraph DRHUB["connectivityhub-dr (us-east2)"]
    DPUB1["public1\n10.70.0.0/22"]
    DPUB2["public2\n10.70.4.0/22"]
    DF1["firewall1\n10.70.8.0/23"]
    DF2["firewall2\n10.70.10.0/23"]
    DPRIV1["private1\n10.70.12.0/22"]
    DPRIV2["private2\n10.70.16.0/22"]
    DPUB1 --> DPUB2 --> DF1 --> DF2 --> DPRIV1 --> DPRIV2
  end
  subgraph DEV["dev (10.60.0.0/21)"]
    D1["routable1\n10.60.0.0/23"]
    D2["routable2\n10.60.2.0/23"]
    D1 --> D2
  end
  subgraph SIT["sit (10.60.4.0/21)"]
    S1["routable1\n10.60.4.0/23"]
    S2["routable2\n10.60.6.0/23"]
    S1 --> S2
  end
  subgraph UAT["uat (10.60.8.0/21)"]
    U1["routable1\n10.60.8.0/23"]
    U2["routable2\n10.60.10.0/23"]
    U1 --> U2
  end
  subgraph PERF["perf (10.60.12.0/21)"]
    P1["routable1\n10.60.12.0/23"]
    P2["routable2\n10.60.14.0/23"]
    P1 --> P2
  end
  subgraph PROD["prod (10.80.0.0/21)"]
    PR1["routable1\n10.80.0.0/23"]
    PR2["routable2\n10.80.2.0/23"]
    PR1 --> PR2
  end
  subgraph TOOLS["tools (10.30.0.0/21)"]
    T1["subnet1\n10.30.0.0/23"]
    T2["subnet2\n10.30.2.0/23"]
    T3["subnet3\n10.30.4.0/23"]
    T4["subnet4\n10.30.6.0/23"]
    T1 --> T2 --> T3 --> T4
  end
  subgraph TENANT001["tenant001 (10.40.0.0/24)"]
    TE1["subnet1\n10.40.0.0/25"]
    TE2["subnet2\n10.40.0.128/25"]
    TE1 --> TE2
  end
  subgraph TENANT002["tenant002 (10.40.1.0/24)"]
    TN1["subnet1\n10.40.1.0/25"]
    TN2["subnet2\n10.40.1.128/25"]
    TN1 --> TN2
  end
  HUB -.-> DEV
  HUB -.-> SIT
  HUB -.-> UAT
  HUB -.-> PERF
  HUB -.-> PROD
  HUB -.-> TOOLS
  HUB -.-> TENANT001
  HUB -.-> TENANT002
  HUB -.-> DRHUB
```
