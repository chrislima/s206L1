@starwars
Feature: Executar testes funcionais nas APIs do Star Wars (swapi)


Background: Executa antes de cada teste
    * def url_base = "https://swapi.dev/api/"

Scenario: Verificar o retorno com sucesso da API /people/1/ com dados válidos de requisição (request)
    Given url 'https://swapi.dev/api/people/1/'
    When method get
    Then status 200

Scenario: Verificar o retorno com sucesso da API /people/1/ com dados inválidos de requisição (request)
    Given url 'https://swapi.dev/api/people/1/1234'
    When method get
    Then status 404

Scenario: Verificar o retorno com sucesso da API /people/1/ com dados válidos de requisição (request) e garantir que o retorno tem o JSON esperado (name e height)
    Given url 'https://swapi.dev/api/people/1/'
    When method get
    Then status 200
    And  match response.name == "Luke Skywalker"
    And  match response.height == "172"

Scenario: Verificar o retorno com sucesso da API /planets/7/ com dados válidos de request e garantir o JSON de retorno
    Given url url_base
    And path 'planets/7/'
    When method get
    Then status 200
    And match response.name == "Endor"
    And match response.residents[0] == "https://swapi.dev/api/people/30/"
    And match response.films[0] == "https://swapi.dev/api/films/3/"

Scenario: Verificar o retorno com sucesso da API /starships/9/ com dados válidos de request e garantir que o retorno tem o JSON esperado (films) e utilizar este retorno para um novo teste.
    Given url url_base
    And path 'starships/9/'
    And method get
    And status 200
    And def inputfilms = $.films[0]
    And print inputfilms
    And url inputfilms
    When method get
    Then status 200
    And response.title == "A New Hope"
