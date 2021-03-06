unit MainFrame;

interface

  uses
    System.SysUtils, System.Types, System.UITypes, System.Classes,
    System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
    ALFmxObjects, FMX.Layouts, ALFmxLayouts, FMX.Styles.Objects,
    FMX.Controls.Presentation, FMX.StdCtrls;

  type
    TFrmMainFrame = class(TForm)
      Header: TALLayout;
      ALRectangle1: TALRectangle;
      Footer: TALLayout;
      ALRectangle2: TALRectangle;
      MaskedImage1: TMaskedImage;
      Main: TALLayout;
      Button1: TButton;
      Button2: TButton;
      Button3: TButton;
      MaskedImage2: TMaskedImage;
      procedure Button4Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
      procedure Button1Click(Sender: TObject);
      procedure Button3Click(Sender: TObject);
      procedure MaskedImage2Click(Sender: TObject);
      private
        { Private declarations }
      public
        { Public declarations }
    end;

  var
    FrmMainFrame: TFrmMainFrame;

implementation

  {$R *.fmx}

  uses Principal, Cadastros, FrmcadFunc, Manutencao, DmTabelas;

  procedure TFrmMainFrame.Button1Click(Sender: TObject);
    begin
      application.CreateForm(TfrmManu, frmManu);
      frmManu.show;
    end;

  procedure TFrmMainFrame.Button2Click(Sender: TObject);
    begin
      application.CreateForm(tfrmcad, frmcad);
      frmcad.show;
    end;

  procedure TFrmMainFrame.Button3Click(Sender: TObject);
    begin
      application.CreateForm(TfrmManu, frmManu);
      frmManu.show;
    end;

  procedure TFrmMainFrame.Button4Click(Sender: TObject);
    begin
      FrmMainFrame.Close;
      FrmPrincipal.show;
    end;

  procedure TFrmMainFrame.MaskedImage2Click(Sender: TObject);
    begin
      FrmMainFrame.Close;
    end;

end.
