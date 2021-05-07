program RestDWServerProject;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  RestDWServerFormU in 'RestDWServerFormU.pas' {RestDWForm},
  uDmService in 'uDmService.pas' {DataModule1: TDataModule},
  uutils in 'Unit\uutils.pas',
  Aguarde in 'Unit\Forms\Aguarde.pas' {frmAguarde},
  Aviso in 'Unit\Forms\Aviso.pas' {frmAviso},
  Erro in 'Unit\Forms\Erro.pas' {frmErro},
  Pergunta in 'Unit\Forms\Pergunta.pas' {frmPergunta},
  SenhaProtec in 'Unit\Forms\SenhaProtec.pas' {frmSenhaProtec};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRestDWForm, RestDWForm);
  Application.CreateForm(TfrmAguarde, frmAguarde);
  Application.CreateForm(TfrmAviso, frmAviso);
  Application.CreateForm(TfrmErro, frmErro);
  Application.CreateForm(TfrmPergunta, frmPergunta);
  Application.CreateForm(TfrmSenhaProtec, frmSenhaProtec);
  Application.Run;
end.
