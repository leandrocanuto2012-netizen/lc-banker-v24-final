### Instalação Evolution API - Comunidade Visionários

Essse é um guia prático e objetivo para configurar automaticamente a Evolution API com PostgreSQL e Redis utilizando Docker e Docker Compose. 

Todo o ambiente estará pronto para uso após seguir este tutorial.

👉 Entre na **Comunidade** Visionários para aprender mais: ([ENTRAR PARA COMUNIDADE](https://nathanconde.com/comunidade_visionarios)).

---

## Pré-requisitos

Certifique-se de ter:

1. **Docker e Docker Compose** instalados ([Guia de instalação](https://docs.docker.com/get-docker/)).
2. **Chave de autenticação** para a API (*API Key*).

---

## Passo 1: Estrutura do Projeto

Certifique-se de que os arquivos abaixo estejam no diretório do projeto:

1. `Dockerfile`
2. `docker-compose.yml`

---

## Passo 2: Criar o `Dockerfile`

Crie um arquivo `Dockerfile` no diretório raiz com o seguinte conteúdo:

```dockerfile
# Usando a imagem oficial da Evolution API
FROM atendai/evolution-api:v2.1.1

# Variáveis de ambiente
ENV AUTHENTICATION_API_KEY=mude-me

# Expondo a porta da aplicação
EXPOSE 8080

# Comando para iniciar a API
CMD ["npm", "run", "start:prod"]
```

---

## Passo 3: Configurar `docker-compose.yml`

Crie um arquivo `docker-compose.yml` no mesmo diretório com o seguinte conteúdo:

```yaml
version: '3.9'
services:
  evolution-api:
    build: .
    container_name: evolution_api
    restart: always
    ports:
      - "8080:8080"
    environment:
      # Configurações do PostgreSQL
      DATABASE_ENABLED: "${DATABASE_ENABLED}"
      DATABASE_PROVIDER: "${DATABASE_PROVIDER}"
      DATABASE_CONNECTION_URI: "${DATABASE_CONNECTION_URI}"
      DATABASE_CONNECTION_CLIENT_NAME: "${DATABASE_CONNECTION_CLIENT_NAME}"
      DATABASE_SAVE_DATA_INSTANCE: "${DATABASE_SAVE_DATA_INSTANCE}"
      DATABASE_SAVE_DATA_NEW_MESSAGE: "${DATABASE_SAVE_DATA_NEW_MESSAGE}"
      DATABASE_SAVE_MESSAGE_UPDATE: "${DATABASE_SAVE_MESSAGE_UPDATE}"
      DATABASE_SAVE_DATA_CONTACTS: "${DATABASE_SAVE_DATA_CONTACTS}"
      DATABASE_SAVE_DATA_CHATS: "${DATABASE_SAVE_DATA_CHATS}"
      DATABASE_SAVE_DATA_LABELS: "${DATABASE_SAVE_DATA_LABELS}"
      DATABASE_SAVE_DATA_HISTORIC: "${DATABASE_SAVE_DATA_HISTORIC}"

      # Configurações do Redis
      CACHE_REDIS_ENABLED: "${CACHE_REDIS_ENABLED}"
      CACHE_REDIS_URI: "${CACHE_REDIS_URI}"
      CACHE_REDIS_PREFIX_KEY: "${CACHE_REDIS_PREFIX_KEY}"
      CACHE_REDIS_SAVE_INSTANCES: "${CACHE_REDIS_SAVE_INSTANCES}"
      CACHE_LOCAL_ENABLED: "${CACHE_LOCAL_ENABLED}"

      # Chave de autenticação da API
      AUTHENTICATION_API_KEY: "${AUTHENTICATION_API_KEY}"
    depends_on:
      - redis
      - postgres

  redis:
    image: redis:7
    container_name: evolution_redis
    restart: always
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "-u", "${CACHE_REDIS_URI}", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  postgres:
    image: postgres:14
    container_name: evolution_postgres
    restart: always
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: "${POSTGRES_USER}"
      POSTGRES_PASSWORD: "${POSTGRES_PASSWORD}"
      POSTGRES_DB: "${POSTGRES_DB}"
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "${POSTGRES_USER}"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  redis_data:
  postgres_data:
```

---

## Passo 4: Configurar Variáveis de Ambiente

Crie um arquivo `.env` no mesmo diretório e adicione a seguinte configuração:

```env
# Substitua pela sua chave de autenticação
AUTHENTICATION_API_KEY=sua_chave_de_autenticacao
```

Para gerar um Hash (Chave de acesso) 
Acesse o site abaixo e copie a chave Encryption key 256 gerada no campo
https://acte.ltd/utils/randomkeygen

---

## Passo 5: Subir o Ambiente com Docker Compose

Execute o seguinte comando para subir os contêineres:

```bash
docker-compose up -d
```

Este comando irá:

1. Criar e inicializar o PostgreSQL.
2. Configurar a Evolution API para usar o PostgreSQL e o Redis.
3. Expor a API na porta `8080`.

---

## Passo 6: Verificar a Instalação

Após a execução bem-sucedida, você pode acessar a API em:

```
http://localhost:8080
```

Para verificar se o PostgreSQL está funcionando corretamente, use um cliente de banco de dados (como DBeaver ou pgAdmin) e conecte-se com as seguintes credenciais:

- **Host:** `localhost`
- **Porta:** `5432`
- **Usuário:** `evolution_user`
- **Senha:** `evolution_password`
- **Banco de Dados:** `evolution_db`

---

## Passo 7: Documentação Adicional

Para mais informações sobre a API, consulte a [documentação oficial](https://doc.evolution-api.com/v2/pt/get-started/introduction).

---

## Contribuição

Se você encontrar problemas ou tiver sugestões, entre em contato com a **Comunidade Visionários**. 🎉👇
([ENVIAR MENSAGEM](https://wa.me/5532999817168?text=Ol%C3%A1,%20gostaria%20de%20dar%20uma%20sugest%C3%A3o)).

---

**Comunidade Visionários - Domine as IAs e esteja um passo à frente**
