# Refera Challenge


## Transform

### Configurar ambiente local

Crie um ambiente virtual e instale as libs necessárias:

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```
Coloque suas credenciais AWS dentro de ~/.aws/credencials

```
[default]
aws_access_key_id =
aws_secret_access_key =
```

Configure o seu profile do dbt em ~/.dbt/profiles.yml:

```yaml
dbt_refera_challenge:
  target: dev
  outputs:
    dev:
      type: athena
      s3_staging_dir: s3://data-warehouse-refera-challenge/dbt/
      region_name: us-east-1
      schema: dbt_aluizio
      database: awsdatacatalog
```

Teste a conexão com o Athena:

```bash 
dbt debug
```

### Rodando o modelo de dados

Para aplicar as tranformações no Data Warehouse, rode:

```
dbt run
```

Para rodar os testes nas tabelas, rode:

```
dbt test
```

### Rodando em produção

Dentro de profiles está o profile com o DW de produção. O dbt está rodando atravês de uma lambda function que é schedulada pelo cloudwatch event.

### Deploy

Tendo a transformação validada em schema pessoal o processo de atualização se da por:

**Atenção:** Para se gerar uma nova versão deve se atualizar a versão do projeto em `dbt_project.yml`

1. Release da nova imagem dbt no ecr

```bash
make build_image
make push_image
```

2. Atualização da imagem na lambda:

```bash
make terraform_plan
```

3. Verificado que a imagem será bumpada na lambda pode se seguir para aplicar a atualização:

```bash
make terraform_apply
```