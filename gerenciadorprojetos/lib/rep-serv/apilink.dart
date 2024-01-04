//link para acesso ao servidor
// atualmente offline 
class Api{
  String login(){
    return "http://actionsolution.sytes.net:9000/auth/login";
  }
  String registrar(){
    return "http://actionsolution.sytes.net:9000/usuarios/novo";
  }
  String getGrupos(){
    return "http://actionsolution.sytes.net:9000/grupos/todos";
  }
  String getUsers(){
    return "http://actionsolution.sytes.net:9000/grupos/todos/usuarios";
  }
  String removerUser(){
    return "http://actionsolution.sytes.net:9000/grupos/remover/usuario";
  }
  String adicionarUser(){
    return "http://actionsolution.sytes.net:9000/grupos/adicionar/usuario";
  }
  String criarGrupo(){
    return "http://actionsolution.sytes.net:9000/grupos/novo";
  }
  String getProjetos(){
    return "http://actionsolution.sytes.net:9000/projetos/todos";
  }
  String criarProjeto(){
    return "http://actionsolution.sytes.net:9000/projetos/novo";
  }
  String removerProjeto(){
    return "http://actionsolution.sytes.net:9000/grupos/remover/projeto";
  }
  String adicionarProjeto(){
    return "http://actionsolution.sytes.net:9000/grupos/adicionar/projeto";
  }
  String getTarefas(){
    return "http://actionsolution.sytes.net:9000/tarefas/todas";
  }
  String criarTarefa(){
    return "http://actionsolution.sytes.net:9000/tarefas/adicionar/tarefa";
  }
  String removerTarefa(){
    return "http://actionsolution.sytes.net:9000/tarefas/remover/tarefa";
  }
}