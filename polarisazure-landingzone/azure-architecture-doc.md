  # Azure Landing Zone Architecture

  ## Summary
  This document provides a professional overview of the Azure landing zone architecture, designed for secure, scalable, and organized cloud environments. It is intended for architects, engineers, and stakeholders who need a clear reference for resource layout and network topology.

  ## Table of Contents
    1. Summary
    2. How to Use This Document
    3. Architecture Summary
    4. Resource Groups and Networks
    5. Policy Notes

  ## How to Use This Document
  Use this guide to quickly locate resource group, vNet, and subnet details for each Azure subscription. Tables are grouped for clarity. For design changes, update both this document and the Terraform configuration.

  ## Architecture Summary
  - Hub-and-spoke topology for secure, scalable networking
  - Centralized connectivity and firewall management
  - Segregated environments for production, non-production, shared services, and tenants

  ### Resource Summary Table

  #### Connectivity Subscription

  **Resource Groups:**
  - connectivityhub (centralus)
  - connectivityhub-dr (eastus2)

  **connectivityhub (centralus)**
  | vNet Name            | vNet CIDR     | Subnet Name | Subnet CIDR   |
  |----------------------|---------------|-------------|---------------|
  | vnet-connectivityhub | 10.50.0.0/16  | public1     | 10.50.0.0/23  |
  | vnet-connectivityhub | 10.50.0.0/16  | public2     | 10.50.2.0/23  |
  | vnet-connectivityhub | 10.50.0.0/16  | firewall1   | 10.50.4.0/27  |
  | vnet-connectivityhub | 10.50.0.0/16  | firewall2   | 10.50.4.32/27 |
  | vnet-connectivityhub | 10.50.0.0/16  | private1    | 10.50.8.0/23  |
  | vnet-connectivityhub | 10.50.0.0/16  | private2    | 10.50.10.0/23 |

  **connectivityhub-dr (eastus2)**
  | vNet Name               | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |-------------------------|--------------|-------------|---------------|
  | vnet-connectivityhub-dr | 10.70.0.0/20 | public1     | 10.70.0.0/23  |
  | vnet-connectivityhub-dr | 10.70.0.0/20 | public2     | 10.70.2.0/23  |
  | vnet-connectivityhub-dr | 10.70.0.0/20 | firewall1   | 10.70.4.0/27  |
  | vnet-connectivityhub-dr | 10.70.0.0/20 | firewall2   | 10.70.4.32/27 |
  | vnet-connectivityhub-dr | 10.70.0.0/20 | private1    | 10.70.8.0/23  |
  | vnet-connectivityhub-dr | 10.70.0.0/20 | private2    | 10.70.10.0/23 |

  #### Non-Prod Apps Subscription

  **Resource Groups:**
  - dev (centralus)
  - sit (centralus)
  - uat (centralus)
  - performance (centralus)
  - silver_eks (centralus)
  - silver_eksgbd (centralus)
  - gold_eks (centralus)
  - gold_eksgbd (centralus)

  **dev (centralus)**
  | vNet Name   | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |-------------|--------------|-------------|---------------|
  | vnet-dev    | 10.60.0.0/21 | subnet1     | 10.60.0.0/23  |
  | vnet-dev    | 10.60.0.0/21 | subnet2     | 10.60.2.0/23  |
  | vnet-dev    | 10.60.0.0/21 | subnet3     | 10.60.4.0/23  |

  **sit (centralus)**
  | vNet Name   | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |-------------|--------------|-------------|---------------|
  | vnet-sit    | 10.61.0.0/21 | subnet1     | 10.61.0.0/23  |
  | vnet-sit    | 10.61.0.0/21 | subnet2     | 10.61.2.0/23  |
  | vnet-sit    | 10.61.0.0/21 | subnet3     | 10.61.4.0/23  |

  **uat (centralus)**
  | vNet Name   | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |-------------|--------------|-------------|---------------|
  | vnet-uat    | 10.62.0.0/21 | subnet1     | 10.62.0.0/23  |
  | vnet-uat    | 10.62.0.0/21 | subnet2     | 10.62.2.0/23  |
  | vnet-uat    | 10.62.0.0/21 | subnet3     | 10.62.4.0/23  |

  **performance (centralus)**
  | vNet Name         | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |-------------------|--------------|-------------|---------------|
  | vnet-performance  | 10.63.0.0/21 | subnet1     | 10.63.0.0/23  |
  | vnet-performance  | 10.63.0.0/21 | subnet2     | 10.63.2.0/23  |
  | vnet-performance  | 10.63.0.0/21 | subnet3     | 10.63.4.0/23  |

  **silver_eks (centralus)**
  | vNet Name        | vNet CIDR    | Subnet Name    | Subnet CIDR   |
  |------------------|--------------|----------------|---------------|
  | vnet-silver-eks  | 10.10.0.0/16 | routable1      | 10.10.0.0/23  |
  | vnet-silver-eks  | 10.10.0.0/16 | routable2      | 10.10.2.0/23  |
  | vnet-silver-eks  | 10.10.0.0/16 | nonroutable1   | 100.64.0.0/20 |
  | vnet-silver-eks  | 10.10.0.0/16 | nonroutable2   | 100.64.16.0/20|

  **silver_eksgbd (centralus)**
  | vNet Name           | vNet CIDR    | Subnet Name    | Subnet CIDR   |
  |---------------------|--------------|----------------|---------------|
  | vnet-silver-eksgbd  | 10.10.4.0/16 | routable1      | 10.10.4.0/23  |
  | vnet-silver-eksgbd  | 10.10.4.0/16 | routable2      | 10.10.6.0/23  |
  | vnet-silver-eksgbd  | 10.10.4.0/16 | nonroutable1   | 100.64.32.0/20|
  | vnet-silver-eksgbd  | 10.10.4.0/16 | nonroutable2   | 100.64.48.0/20|

  **gold_eks (centralus)**
  | vNet Name        | vNet CIDR    | Subnet Name    | Subnet CIDR   |
  |------------------|--------------|----------------|---------------|
  | vnet-gold-eks    | 10.10.8.0/16 | routable1      | 10.10.8.0/23  |
  | vnet-gold-eks    | 10.10.8.0/16 | routable2      | 10.10.10.0/23 |
  | vnet-gold-eks    | 10.10.8.0/16 | nonroutable1   | 100.64.64.0/20|
  | vnet-gold-eks    | 10.10.8.0/16 | nonroutable2   | 100.64.80.0/20|

  **gold_eksgbd (centralus)**
  | vNet Name           | vNet CIDR    | Subnet Name    | Subnet CIDR   |
  |---------------------|--------------|----------------|---------------|
  | vnet-gold-eksgbd    | 10.10.12.0/16| routable1      | 10.10.12.0/23 |
  | vnet-gold-eksgbd    | 10.10.12.0/16| routable2      | 10.10.14.0/23 |
  | vnet-gold-eksgbd    | 10.10.12.0/16| nonroutable1   | 100.64.96.0/20|
  | vnet-gold-eksgbd    | 10.10.12.0/16| nonroutable2   | 100.64.112.0/20|

  #### Prod Apps Subscription

  **Resource Groups:**
  - prod (centralus)
  - dr (eastus2)
  - prd_eks (centralus)
  - prd_eksgbd (centralus)
  - dr_eks (eastus2)
  - dr_eksgbd (eastus2)

  **prod (centralus)**
  | vNet Name   | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |-------------|--------------|-------------|---------------|
  | vnet-prod   | 10.80.0.0/21 | subnet1     | 10.80.0.0/23  |
  | vnet-prod   | 10.80.0.0/21 | subnet2     | 10.80.2.0/23  |
  | vnet-prod   | 10.80.0.0/21 | subnet3     | 10.80.4.0/23  |

  **dr (eastus2)**
  | vNet Name   | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |-------------|--------------|-------------|---------------|
  | vnet-dr     | 10.81.0.0/21 | subnet1     | 10.81.0.0/23  |
  | vnet-dr     | 10.81.0.0/21 | subnet2     | 10.81.2.0/23  |
  | vnet-dr     | 10.81.0.0/21 | subnet3     | 10.81.4.0/23  |

  **prd_eks (centralus)**
  | vNet Name        | vNet CIDR    | Subnet Name    | Subnet CIDR   |
  |------------------|--------------|----------------|---------------|
  | vnet-prd-eks     | 10.20.0.0/16 | routable1      | 10.20.0.0/23  |
  | vnet-prd-eks     | 10.20.0.0/16 | routable2      | 10.20.2.0/23  |
  | vnet-prd-eks     | 10.20.0.0/16 | routable3      | 10.20.4.0/23  |
  | vnet-prd-eks     | 10.20.0.0/16 | nonroutable1   | 100.65.0.0/20 |
  | vnet-prd-eks     | 10.20.0.0/16 | nonroutable2   | 100.65.16.0/20|
  | vnet-prd-eks     | 10.20.0.0/16 | nonroutable3   | 100.65.32.0/20|

  **prd_eksgbd (centralus)**
  | vNet Name           | vNet CIDR    | Subnet Name    | Subnet CIDR   |
  |---------------------|--------------|----------------|---------------|
  | vnet-prd-eksgbd     | 10.20.4.0/16 | routable1      | 10.20.4.0/23  |
  | vnet-prd-eksgbd     | 10.20.4.0/16 | routable2      | 10.20.6.0/23  |
  | vnet-prd-eksgbd     | 10.20.4.0/16 | routable3      | 10.20.8.0/23  |
  | vnet-prd-eksgbd     | 10.20.4.0/16 | nonroutable1   | 100.65.32.0/20|
  | vnet-prd-eksgbd     | 10.20.4.0/16 | nonroutable2   | 100.65.48.0/20|
  | vnet-prd-eksgbd     | 10.20.4.0/16 | nonroutable3   | 100.65.64.0/20|

  **dr_eks (eastus2)**
  | vNet Name        | vNet CIDR    | Subnet Name    | Subnet CIDR   |
  |------------------|--------------|----------------|---------------|
  | vnet-dr-eks      | 10.20.8.0/16 | routable1      | 10.20.8.0/23  |
  | vnet-dr-eks      | 10.20.8.0/16 | routable2      | 10.20.10.0/23 |
  | vnet-dr-eks      | 10.20.8.0/16 | routable3      | 10.20.12.0/23 |
  | vnet-dr-eks      | 10.20.8.0/16 | nonroutable1   | 100.65.64.0/20|
  | vnet-dr-eks      | 10.20.8.0/16 | nonroutable2   | 100.65.80.0/20|
  | vnet-dr-eks      | 10.20.8.0/16 | nonroutable3   | 100.65.96.0/20|

  **dr_eksgbd (eastus2)**
  | vNet Name           | vNet CIDR    | Subnet Name    | Subnet CIDR   |
  |---------------------|--------------|----------------|---------------|
  | vnet-dr-eksgbd      | 10.20.12.0/16| routable1      | 10.20.12.0/23 |
  | vnet-dr-eksgbd      | 10.20.12.0/16| routable2      | 10.20.14.0/23 |
  | vnet-dr-eksgbd      | 10.20.12.0/16| routable3      | 10.20.16.0/23 |
  | vnet-dr-eksgbd      | 10.20.12.0/16| nonroutable1   | 100.65.96.0/20|
  | vnet-dr-eksgbd      | 10.20.12.0/16| nonroutable2   | 100.65.112.0/20|
  | vnet-dr-eksgbd      | 10.20.12.0/16| nonroutable3   | 100.66.0.0/20 |

  #### Shared Services Subscription

  **Resource Groups:**
  - tools (centralus)
  - tools-dr (eastus2)

  **tools (centralus)**
  | vNet Name   | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |-------------|--------------|-------------|---------------|
  | vnet-tools  | 10.30.0.0/21 | subnet1     | 10.30.0.0/23  |
  | vnet-tools  | 10.30.0.0/21 | subnet2     | 10.30.2.0/23  |
  | vnet-tools  | 10.30.0.0/21 | subnet3     | 10.30.4.0/23  |

  **tools-dr (eastus2)**
  | vNet Name      | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |----------------|--------------|-------------|---------------|
  | vnet-tools-dr  | 10.31.0.0/21 | subnet1     | 10.31.0.0/23  |
  | vnet-tools-dr  | 10.31.0.0/21 | subnet2     | 10.31.2.0/23  |
  | vnet-tools-dr  | 10.31.0.0/21 | subnet3     | 10.31.4.0/23  |

  #### Tenant Subscriptions

  **Resource Groups:**
  - tenant001 (centralus)
  - tenant002 (centralus)

  **tenant001 (centralus)**
  | vNet Name        | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |------------------|--------------|-------------|---------------|
  | vnet-tenant001   | 10.40.0.0/24 | subnet1     | 10.40.0.0/28  |
  | vnet-tenant001   | 10.40.0.0/24 | subnet2     | 10.40.0.16/28 |

  **tenant002 (centralus)**
  | vNet Name        | vNet CIDR    | Subnet Name | Subnet CIDR   |
  |------------------|--------------|-------------|---------------|
  | vnet-tenant002   | 10.40.1.0/24 | subnet1     | 10.40.1.0/28  |
  | vnet-tenant002   | 10.40.1.0/24 | subnet2     | 10.40.1.16/28 |

  #### Kubernetes/EKS Subscriptions



## Policy Notes

> **:warning: Key Policies**
> - All routable subnets (`10.x.x.x`) are unique and non-overlapping across the landing zone.
> - Non-routable subnets (`100.x.x.x`) may overlap across resource groups.
> - DR resource groups are deployed in `us-east2`; all others are in `us-central` unless otherwise specified.
> - All public ingress/egress is routed through the connectivity subscription and firewall.
> - No direct vNet peering between spokes; all cross-group traffic must traverse the hub.
