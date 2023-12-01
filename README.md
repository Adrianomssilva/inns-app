# README


* Documentação API

  # END POINTS
    **Listagem de pousadas**  (GET /api/v1/inns)
      
      - Solicitando através do get nessa url é esperado um retorno
      de um Array com uma lista de pousadas e status 200. Uma informação importante é que apenas as Pousadas PUBLICADAS vão aparecer.

      - Se não existir nenhuma pousada cadastrada o retorno será em branco e com status 200.

      - Caso ocorra erro no servidor o retorno será status 500.


    **Busca de pousadas** (POST /api/v1/inns/search)
      
        - Para uma requisão bem sucedida é preciso passar o argumento da seguinte forma {"query": "nomequevocêdeseja"}. Com tudo certo é esperado um retorno de json com com os dados da pousada. status 200. Vale ressaltar que a busca é feita nos nomes das pousadas.

        - Status 400 ocorre quando a a pesquisa está em branco. Será retornado o erro campo em branco.

        - Status 500 ocorre quando por parte do servidor.

    **Selecionar uma pousada com detalhes** (GET /api/v1/inns/id)

        - O id informado deve pertencer a uma pousada existem no banco de dados. Passando um id correto é esperado uma resposta 200 do servidor além de um json com os dados da pousada. Não são incluidos os dados corporate_name e cnpj. Além disso está incluído a nota da pousada. Caso ela não tenho nenhuma avaliação é retornado nil para esse campo.

        - Caso o usuário passe um id que não existe, ocorrerá o erro 404.

    **Listar quartos de um pousada** (GET /api/v1/inn.id/rooms)

        - O usuário deve passar um id de pousada válido (inn.id) e é esperado status 200. Apenas os quartos disponíveis serão mostrados.
        todos os dados dos quartos são devolvidos no json. 

        - Caso o usuário passe um id de pousada que não exista, retornara status 404
    
    **Consulta de reserva** (POST /api/v1/reservations)
        
        - Para um status 200 são esperados os seguintes argumentos {"reservation":{"start_date":,"end_date":, "guest_number":, "room_id": }}
        start_date => data de entrada;
        end_date => data de saída;
        guest_number => número de hóspedes;
        room_id => id do quarto desejado.
        Todos os dados devem estar preenchidos.

        - Status 412 se faltar algum dado. Também retornará um json com um array com os erros. O usuário pode pegar esses erros e verificar o que deve ser mudado.

        - Status 500 quando ocorre algum erro de servidor.

  
