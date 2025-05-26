environment  = "infra"
region       = "us-east-1"
cidr_slash16 = "10.30"

azs = [
  "us-east-1a",
  "us-east-1b"
]

enable_nat_gateway         = true
create_igw                 = true
create_vpc                 = true
create_egress_only_igw     = false
enable_ipv6                = false
ipv6_cidr                  = null

manage_default_network_acl = true
default_network_acl_name   = "infra-default-nacl"

default_network_acl_ingress = [
  {
    rule_no    = "100"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0"
    to_port    = "65535"
    protocol   = "tcp"
  }
]

default_network_acl_egress = [
  {
    rule_no    = "100"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0"
    to_port    = "65535"
    protocol   = "tcp"
  }
]

default_network_acl_tags = {
  Name        = "infra-default-nacl"
  Environment = "infra"
}
