# Projeto: unindo-conceitos

# Sobre
Este projeto tem como objetivo utilizar vários conceitos estudados. Os principais estão abaixo:
- Vagrant com Hyper-v
- Terraform com AWS
- Ansible
- Docker
- Python com framework flask
- Shell Script
- Git
- Gitlab (CI/CD)

## Objetivo
O objetivo deste projeto é simular a implantação de um portal escrito em python utilizando o framework flask. Para isso precisamos realizar a instalação da infraestrutura em alta disponibilidade e utilizar integração continua e entrega continua para produtividade dos desenvolvedores.

## Das pastas
- vagrant: IaC para ambiente on premise
- terraform: IaC para ambiente Cloud AWS
- ansible: Arquivos para gestão da configuração
- frontend: Aplicação em flask simulando um frontend

## Estrutura de servidores
- srv1 - k8s master dev
- srv2 - k8s worker1 dev
- srv3 - k8s worker2 dev
- srv4 - gitlab runner local
- srv5 - lb on premise

## Melhorias futuras
- Configurar todas as vms do vagrant em apenas um projeto
- Playbook mais portável entre on premise e cloud com variáveis para os usuários vagrant e ubuntu e chaves privadas
- Migração do DNS da go daddy para o route 53 utilizando terraform para os registros
- fazer a instalação do ingress controller em cloud (atualmente está apenas em bare metal)

## Observações do projeto
**Hyper-v**
- Utilizando memória dinâmica para otimização de recursos local

