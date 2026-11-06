# Auditor Fiscal BITMAX

Aplicativo Windows para auditoria assistida de arquivos EFD ICMS/IPI e EFD-Contribuições.

## Download

Baixe o instalador na página [Releases](https://github.com/jgstrdrgs-dotcom/Auditor-fiscal-bitmax/releases). A versão atual é **2.6.17**.

O setup instala o aplicativo e cria atalhos no Menu Iniciar. Ele pode ser instalado por usuário, sem permissões de administrador. A desinstalação remove os arquivos do aplicativo e preserva os dados do usuário fora da pasta de instalação.

Requisito: Windows 64 bits. O instalador verifica a arquitetura antes de continuar.

Na tela de correções, CFOPs e contas 0500 sem indicação individual são preenchidos em uma única janela. Cada CFOP mantém as opções do próprio documento/item; uma conta pode ser aplicada a várias linhas somente quando for válida em todas elas. Detalhamentos do bloco M continuam exigindo dados de origem por linha.

## Validação oficial

O Auditor pode ser iniciado sem instalar Python ou Java separadamente. A validação oficial depende do PVA/PGE da Receita Federal instalado à parte; esses programas não são redistribuídos pelo instalador do BITMAX. Consulte `installer/REQUISITOS-PVA-PGE.html` para acessar as páginas oficiais e configurar o validador no aplicativo.

## Gerar o instalador

Com o executável standalone já compilado e o NSIS 3 instalado, execute:

```powershell
./installer/build-installer.ps1 -AppExe "C:\caminho\Auditor Fiscal BITMAX 2.6.17.exe"
```

O resultado será criado em `artifacts/Auditor Fiscal BITMAX Setup 2.6.17.exe`.
