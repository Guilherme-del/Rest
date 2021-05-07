unit Aviso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls,
  StdCtrls, Buttons;

type
  TfrmAviso = class(TForm)
    lblMensagem: TLabel;
    btnOk: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAviso: TfrmAviso;

implementation

{$R *.dfm}

procedure TfrmAviso.FormShow(Sender: TObject);
begin
  if lblMensagem.Height > 52 then
    Height := Height+lblMensagem.Height-52;

  frmAviso.Width := lblMensagem.Width + 90;
  btnOK.Left     := Trunc(frmAviso.Width/2) - Trunc( btnOK.Width/2);
end;

end.
