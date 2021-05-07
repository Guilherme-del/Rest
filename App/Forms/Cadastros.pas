unit Cadastros;

interface

  uses
    System.SysUtils, System.Types, System.UITypes, System.Classes,
    System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
    ALFmxObjects, FMX.Layouts, ALFmxLayouts, FMX.Styles.Objects,
    FMX.Controls.Presentation, FMX.StdCtrls;

  type
    TFrmCad = class(TForm)
      Header: TALLayout;
      Footer: TALLayout;
      ALRectangle1: TALRectangle;
      ALRectangle2: TALRectangle;
      MaskedImage1: TMaskedImage;
      Button3: TButton;
      Button4: TButton;
      Button5: TButton;
      Button6: TButton;
      MaskedImage2: TMaskedImage;
      MaskedImage3: TMaskedImage;
      procedure Button4Click(Sender: TObject);
      procedure MaskedImage2Click(Sender: TObject);
      procedure Button6Click(Sender: TObject);
      procedure Button3Click(Sender: TObject);
      procedure Button5Click(Sender: TObject);
      private
        { Private declarations }
      public
        { Public declarations }
    end;

  var
    FrmCad: TFrmCad;

implementation

  {$R *.fmx}

  uses MainFrame, Principal, FrmcadFunc, DmTabelas, Manutencao;

  procedure TFrmCad.Button3Click(Sender: TObject);
    begin
      application.CreateForm(TfrmManu, frmManu);
      frmManu.show;
    end;

  procedure TFrmCad.Button4Click(Sender: TObject);
    begin
      FrmCad.Close;
    end;

  procedure TFrmCad.Button5Click(Sender: TObject);
    begin
      application.CreateForm(TfrmManu, frmManu);
      frmManu.show;
    end;

  procedure TFrmCad.Button6Click(Sender: TObject);
    begin
      application.CreateForm(TfrmCadFun, frmCadFun);
      frmCadFun.show;
    end;

  procedure TFrmCad.MaskedImage2Click(Sender: TObject);
    begin
      frmPrincipal.show;
      FrmCad.Close;
    end;

end.
