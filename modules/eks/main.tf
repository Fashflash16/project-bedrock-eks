module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "project-bedrock-eks-cluster"
  cluster_version = "1.32"

  subnet_ids = [
    module.vpc.private_subnets[0],
    module.vpc.private_subnets[1]
  ]

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    app_node_group = {
      desired_size = 2
      max_size     = 3
      min_size     = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  enable_irsa = true

  tags = {
    Environment = "dev"
    Project     = "bedrock"
  }
}
