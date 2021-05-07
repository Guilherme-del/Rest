program Android;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Forms\Principal.pas' {frmPrincipal},
  MainFrame in 'Forms\MainFrame.pas' {FrmMainFrame},
  Cadastros in 'Forms\Cadastros.pas' {FrmCad},
  DmTabelas in 'Forms\DmTabelas.pas' {DmTabela: TDataModule},
  FrmcadFunc in 'Forms\FrmcadFunc.pas' {FrmCadFun},
  Manutencao in 'Forms\Manutencao.pas' {FrmManu};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDmTabela, DmTabela);
  Application.Run;
end.

