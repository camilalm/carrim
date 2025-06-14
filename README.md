
## Informações técnicas

### Dependências
- ruby 3.3.1
- rails 7.1.3.2
- postgres 16
- redis 5.2.0

## Como executar o projeto

### Executando com docker

Construir imagens
```bash
docker compose build
```

Iniciar containers
```bash
docker compose up -d
```

Criar banco de dados
```bash
docker compose run test bundle exec rails db:create db:migrate RAILS_ENV=test
docker compose run web bundle exec rails db:create db:migrate
```

### Executando sem o docker
Dado que todas as as ferramentas estão instaladas e configuradas:

Instalar as dependências do:
```bash
bundle install
```

Executar o sidekiq:
```bash
bundle exec sidekiq
```

Executar projeto:
```bash
bundle exec rails server
```

Executar os testes:
```bash
bundle exec rspec
```

## Endpoints

### Ver carrinho atual
```
curl --request GET \
     --url {{url}}/cart \
     --header 'accept: application/json'
```

### Criar carrinho
```
curl --request POST \
     --url {{url}}/cart \
     --header 'accept: application/json' \
     --data product_id=2 \
     --data quantity=2
```

### Adicionar produto ao carrinho
```
curl --request POST \
     --url {{url}}/cart/add_item \
     --header 'accept: application/json' \
     --data product_id=2 \
     --data quantity=2
```

### Remover produto do carrinho
```
curl --request DELETE \
     --url {{url}}/cart/{{product_id}} \
     --header 'accept: application/json'
```

### Listar produtos
```
curl --request GET \
     --url {{url}}/products
```
