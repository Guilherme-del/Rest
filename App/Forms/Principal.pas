unit Principal;

interface

  uses
    System.SysUtils, System.Types, System.UITypes, System.Classes,
    System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
    ALFmxLayouts, ALFmxObjects, FMX.Styles.Objects;

  type
    TfrmPrincipal = class(TForm)
      Header: TALLayout;
      ALRectangle1: TALRectangle;
      Footer: TALLayout;
      Rectangle1: TRectangle;
      Main: TALLayout;
      ALRectangle2: TALRectangle;
      Button1: TButton;
      Bottom: TALLayout;
      Right: TALLayout;
      Sair: TMaskedImage;
      btnSair: TButton;
      procedure btnSairClick(Sender: TObject);
      procedure Button1Click(Sender: TObject);

      private
        { Private declarations }
      public
        { Public declarations }
    end;

  var
    frmPrincipal: TfrmPrincipal;

implementation

  {$R *.fmx}

  uses MainFrame, FrmcadFunc, Cadastros, DmTabelas, Manutencao;

  procedure TfrmPrincipal.btnSairClick(Sender: TObject);
    begin
      MessageDlg('Deseja sair do app ?',
        System.UITypes.TMsgDlgType.mtInformation,
        [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
          procedure(const AResult: System.UITypes.TModalResult)
          begin
            case AResult of
              mrYES:
                begin
                  Application.Terminate
                end;
              mrNo:
                Show;
            end;
          end);
    end;

  procedure TfrmPrincipal.Button1Click(Sender: TObject);
    begin
      Application.CreateForm(TfrmmainFrame, frmMainFrame);
      frmMainFrame.Show;
    end;

end.
