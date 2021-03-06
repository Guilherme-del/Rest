unit Pergunta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type
  TfrmPergunta = class(TForm)
    lblMensagem: TLabel;
    btnNao: TBitBtn;
    btnSim: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPergunta: TfrmPergunta;

implementation

{$R *.dfm}

procedure TfrmPergunta.FormShow(Sender: TObject);
begin
  if lblMensagem.Height > 52 then
    Height := Height+lblMensagem.Height-52;
  Width := lblMensagem.Width + 90;
  if Width < 300 then
    Width := 300;

  btnSim.Left       := Trunc(frmPergunta.Width/2) - btnSim.Width - 6;
  btnNao.Left       := Trunc(frmPergunta.Width/2) + 6;
end;

procedure TfrmPergunta.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key='S' then
    btnSim.Click
  else if key='N' then
    btnNao.Click
  else if key=#27 then
    btnNao.Click;
end;

end.
