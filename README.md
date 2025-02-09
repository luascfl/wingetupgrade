# Script de Atualização de pacotes do Winget
Este script automatiza o processo de atualização de pacotes gerenciados pelo winget, excluindo pacotes específicos.

## Recursos Principais
* Verifica automaticamente e instala atualizações para pacotes gerenciados pelo winget.
* Permite a exclusão de pacotes específicos do processo de atualização.
* Fornece saída informativa indicando quais pacotes estão sendo atualizados e quaisquer erros encontrados.
* Usa o comando `winget upgrade` para atualizar os pacotes.

## Tecnologias Utilizadas
* PowerShell

## Pré-requisitos
* Sistema operacional Windows com o gerenciador de pacotes winget instalado. Você pode instalar o winget seguindo as instruções em [https://learn.microsoft.com/pt-br/windows/package-manager/winget/](https://learn.microsoft.com/pt-br/windows/package-manager/winget/).

## Instalação
1. **Baixe o script:** Baixe `wingetupgrade.ps1` deste repositório.
2. **Salve o script:** Salve o arquivo em um local conveniente no seu sistema.

## Uso
1. **Execute o script:** Abra o PowerShell como administrador e navegue até o diretório onde você salvou `wingetupgrade.ps1`. Em seguida, execute o script usando o seguinte comando:
   ```powershell
   .\wingetupgrade.ps1
   ```
2. **Revise a saída:** O script exibirá uma lista de pacotes disponíveis para atualização, excluindo aqueles definidos na matriz `$excludedPackages` dentro do script. Ele então tentará atualizar esses pacotes. Quaisquer erros encontrados durante o processo de atualização serão relatados.
3. **Personalize os pacotes excluídos:** A matriz `$excludedPackages` no script `wingetupgrade.ps1` controla quais pacotes são ignorados durante o processo de atualização. Altere essa matriz para adicionar ou remover pacotes conforme necessário. Por exemplo, para excluir "Visual Studio Code" e "Firefox", adicione-os à matriz assim:
   ```powershell
   $excludedPackages = @("Microsoft.Edge", "Visual Studio Code", "Firefox")
   ```
   Lembre-se de salvar as alterações no arquivo `wingetupgrade.ps1` após modificar a matriz.

## Configuração
A configuração do script é principalmente gerenciada através da matriz `$excludedPackages`. Essa matriz contém uma lista de identificadores de pacotes (por exemplo, "Microsoft.Edge") que serão excluídos do processo de atualização. Você pode modificar essa matriz diretamente no arquivo `wingetupgrade.ps1`.

## Estrutura do Projeto
O projeto consiste em dois arquivos:
* `wingetupgrade.ps1`: O script principal do PowerShell.
* `LICENSE`: O arquivo da Licença MIT.

## Contribuição
Contribuições são bem-vindas! Sinta-se à vontade para enviar pull requests com melhorias ou novos recursos.

## Licença
Este projeto está licenciado sob a Licença MIT - consulte o arquivo [LICENSE](LICENSE) para obter detalhes.

## Tratamento de Erros
O script inclui tratamento de erros para os comandos `winget upgrade`. Se ocorrer um erro durante a atualização de um pacote específico, uma mensagem de erro será exibida, mas o script continuará processando outros pacotes. Examine cuidadosamente a mensagem de erro para obter detalhes específicos sobre o problema. Problemas comuns podem incluir questões de conectividade de rede, permissões insuficientes ou problemas com o próprio pacote.

## Notas
Este script é fornecido "no estado em que se encontra", sem qualquer garantia. Use-o por sua conta e risco. Sempre faça backup do seu sistema antes de executar scripts que modifiquem as configurações do sistema.