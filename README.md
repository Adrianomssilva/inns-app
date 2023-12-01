# README


* Documentação API

  # END POINTS
    **Listagem de pousadas**  (GET /api/v1/inns)
      
      - Solicitando através do get nessa url é esperado um retorno
      de um Array com uma lista de pousadas e cod 200. Uma informação importante é que apenas as Pousadas PUBLICADAS vão aparecer.

      - Se não existir nenhuma pousada cadastrada o retorno será em branco e com cod 200.

      - Caso ocorra erro no servidor o retorno será 500.


    **Busca de pousadas** (POST /api/v1/inns/search)
      
        - Para uma requisão bem sucedida é preciso passar o argumento da seguinte forma {"query": "nomequevocêdeseja"}. Com tudo certo é esperado um retorno de json com com os dados da pousada.

        - Erro 400 ocorre quando a a pesquisa está em branco. Será retornado o motivo do erro.

        - Erro 500 ocorre quando o 

