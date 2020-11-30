
resource "aws_iam_role" "pomelo-node" {
  name = "terraform-eks-pomelo-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "pomelo-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.pomelo-node.name
}

resource "aws_iam_role_policy_attachment" "pomelo-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.pomelo-node.name
}

resource "aws_iam_role_policy_attachment" "pomelo-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.pomelo-node.name
}

resource "aws_eks_node_group" "pomelo" {
  cluster_name    = aws_eks_cluster.pomelo.name
  node_group_name = "pomelo"
  node_role_arn   = aws_iam_role.pomelo-node.arn
  subnet_ids      = aws_subnet.pomelo[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.pomelo-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.pomelo-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.pomelo-node-AmazonEC2ContainerRegistryReadOnly,
  ]

}