unit frmDialog;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, ALFmxLayouts;

type
  TfrmDialogue = class(TForm)
    Header: TALLayout;
    Footer: TALLayout;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDialogue: TfrmDialogue;

implementation

{$R *.fmx}

uses Principal;


procedure TfrmDialogue.Button1Click(Sender: TObject);
begin
Application.Terminate;
end;

end.
