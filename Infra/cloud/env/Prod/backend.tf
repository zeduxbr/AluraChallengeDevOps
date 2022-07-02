terraform {
  backend "s3" {
    bucket = "seu-backet-s3" #Altere aqui e coloque o seu bucket no S3
    key    = "Prod/terraform.tfstate"
    region = "sua-regiao-aws" #Altere aqui e coloque a sua regiao no aws
  }
}