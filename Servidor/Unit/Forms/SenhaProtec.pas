unit SenhaProtec;

interface

uses
  Windows, Classes, Controls, Forms, SysUtils,
  StdCtrls, Buttons, Mask;

type
  TfrmSenhaProtec = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtSerial: TEdit;
    edtSenha: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    ArqLic: String;
  end;

var
  frmSenhaProtec: TfrmSenhaProtec;

implementation


{$R *.DFM}

procedure TfrmSenhaProtec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( ssCtrl  in Shift ) and
     ( ssShift in Shift ) and
     ( key = Ord('R') ) and
     ( Application.MessageBox( PChar( 'Atenção! Esse procedimento irá resetar a licença do sistema!' + #13#13 + 'Deseja continuar?'),'Aviso',mb_IconQuestion+mb_YesNo+mb_DefButton2 )=idYes ) then
  begin
    Key := 0;
    close;
  end;
end;

end.
