aws_subnets = {

  "subnet01" = {
    value = "subnet-05e232be57e95011f"
  }

  "subnet02" = {
    value = "subnet-031f09e86179cbbe3"
  }

}

aws_eks_node_group_config = {
  "eks-node-01" = {
    node_group_name = "eks-node-01"
    eks_cluster_name = "productivity_app_eks" 

    node_iam_role = "eks-node-group-01"

    subnet1 = "subnet-05e232be57e95011f"
    subnet2 = "subnet-05e232be57e95011f"

    tags = {
      Name = "eks-node-01"
    }
  }

  "eks-node-02" = {
    node_group_name = "eks-node-02"
    eks_cluster_name = "productivity_app_eks" 

    node_iam_role = "eks-node-group-02"

    subnet1 = "subnet-05e232be57e95011f"
    subnet2 = "subnet-05e232be57e95011f"

    tags = {
      Name = "eks-node-02"
    }
  }
}