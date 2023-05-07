module "aws_eks_module" {
  source = "./modules/aws_eks"
  subnet_ids = ["subnet-05e232be57e95011f", "subnet-031f09e86179cbbe3"]
}


module "aws_eks_node_group" {
  source = "./modules/aws_eks_node_group"
  for_each = var.aws_eks_node_group_config

  eks_cluster_name = each.value.eks_cluster_name
  node_group_name  = each.value.node_group_name
  subnet_ids = [each.value.subnet1, each.value.subnet2]
  node_iam_role = each.value.node_iam_role
}