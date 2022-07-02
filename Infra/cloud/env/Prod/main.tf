module "producao" {
  source = "../../cloud"

  nome = "producao-aluraflix"
  descricao = "aplicacao-de-producao-aluraflix"
  max = 5
  maquina = "t2.micro"
  ambiente = "ambiente-de-producao-aluraflix"
}

