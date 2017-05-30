# Beluga

## Requisitos:

- [Elixir](elixir-lang.org)
- [NodeJS](https://nodejs.org)

## Instalar
```shell
git clone git@github.com:esdrasedu/beluga.git
cd beluga
npm install
mix phoenix.server
```

## Obs
- Filtro é feito back side, poderia ter sido feito front side, mas para valores com grande volume o melhor é ser feito back side
- Filtro é feito com o OPERADOR OR
- Paginação não foi feita, pois não é obrigatório no desafio, mas para maior performance seria melhor fazer em back side
- Listagem é ordenada pela data decrescente 