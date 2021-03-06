unit Manutencao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, ALFmxObjects, FMX.Layouts, ALFmxLayouts, FMX.Styles.Objects;

type
  TFrmManu = class(TForm)
    Header: TALLayout;
    Footer: TALLayout;
    ALRectangle1: TALRectangle;
    ALRectangle2: TALRectangle;
    MaskedImage1: TMaskedImage;
    MaskedImage2: TMaskedImage;
    MaskedImage3: TMaskedImage;
    MaskedImage4: TMaskedImage;
    procedure MaskedImage2Click(Sender: TObject);
    procedure MaskedImage4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmManu: TFrmManu;

implementation

{$R *.fmx}

uses Principal, DmTabelas, MainFrame, FrmcadFunc, Cadastros;

procedure TFrmManu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//FreeAndNil(frmManu);
end;

procedure TFrmManu.MaskedImage2Click(Sender: TObject);
begin
frmPrincipal.Show;
FrmManu.Close;
end;

procedure TFrmManu.MaskedImage4Click(Sender: TObject);
begin
FrmManu.Close;
end;

end.
