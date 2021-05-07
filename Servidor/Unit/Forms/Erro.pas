unit Erro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type
  TfrmErro = class(TForm)
    lblMensagem: TLabel;
    btnOk: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmErro: TfrmErro;

implementation

{$R *.dfm}

procedure TfrmErro.FormShow(Sender: TObject);
begin
  frmErro.Width := lblMensagem.Width + 90;
  frmErro.Height := frmErro.Height-16+lblMensagem.Height;
  btnOK.Left    := Trunc(frmErro.Width/2) - Trunc( btnOK.Width/2);
end;

end.
