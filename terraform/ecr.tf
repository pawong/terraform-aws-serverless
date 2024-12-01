resource "aws_ecr_repository" "repo" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

locals {
  repo_url = aws_ecr_repository.repo.repository_url
}

resource "null_resource" "image" {
  triggers = {
    detect_docker_source_changes = var.force_image_rebuild == false ? "" : timestamp()
  }

  provisioner "local-exec" {
    command = <<EOF
cd ..
aws ecr get-login-password | docker login --username AWS --password-stdin ${local.repo_url}
docker build --platform linux/amd64 --provenance false -t ${local.repo_url}:latest .
docker push ${local.repo_url}:latest
    EOF
  }
}

data "aws_ecr_image" "latest" {
  repository_name = aws_ecr_repository.repo.name
  image_tag       = "latest"
  depends_on      = [null_resource.image]
}
