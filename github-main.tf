terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
    token = "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"
}

resource "github_repository" "myrepo" {
  name        = "203-bookstore-api-repo"
  description = "Bookstore app"
  auto_init = true  
  visibility = "private"
}

resource "github_branch_default" "default"{
  repository = github_repository.myrepo.name
  branch     = "main"
}

variable "files" {
    default = ["bookstore-api.py", "docker-compose.yaml", "requirements.txt", "Dockerfile"]
}


resource "github_repository_file" "appfiles" {
  for_each = toset (var.files)
  repository          = github_repository.myrepo.name
  branch              = "main"
  file                = each.value
  content             = file (each.value)
  commit_message      = "merhaba-commit"
  overwrite_on_create = true
}
    

