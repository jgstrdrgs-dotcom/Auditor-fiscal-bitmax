# Auditor Fiscal BITMAX

Aplicativo Windows para auditoria assistida de arquivos EFD ICMS/IPI e EFD-Contribuições.

## Download

Baixe o instalador na página [Releases](https://github.com/jgstrdrgs-dotcom/Auditor-fiscal-bitmax/releases). A versão atual é **2.6.16**.

O setup instala o aplicativo e cria atalhos no Menu Iniciar. Ele pode ser instalado por usuário, sem permissões de administrador. A desinstalação remove os arquivos do aplicativo e preserva os dados do usuário fora da pasta de instalação.

## Validação oficial

O Auditor pode ser iniciado sem instalar Python ou Java separadamente. A validação oficial depende do PVA/PGE da Receita Federal instalado à parte; esses programas não são redistribuídos pelo instalador do BITMAX. Consulte `installer/REQUISITOS-PVA-PGE.html` para acessar as páginas oficiais e configurar o validador no aplicativo.

## Gerar o instalador

Com o executável standalone já compilado e o NSIS 3 instalado, execute:

```powershell
./installer/build-installer.ps1 -AppExe "C:\caminho\Auditor Fiscal BITMAX 2.6.16.exe"
```

O resultado será criado em `artifacts/Auditor Fiscal BITMAX Setup 2.6.16.exe`.
