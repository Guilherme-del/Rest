unit FrmcadFunc;

interface

  uses
    System.SysUtils, System.Types, System.UITypes, System.Classes,
    System.Variants,
    FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
    FMX.Styles.Objects, ALFmxObjects, FMX.Layouts, ALFmxLayouts, FMX.ListBox,
    FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, System.Rtti,
    FMX.Grid.Style, FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
    FireDAC.DApt.Intf, Data.Bind.Components, Data.Bind.DBScope,
    Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ScrollBox, FMX.Grid,
    Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Bind.Grid,
    System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Grid,
    Data.Bind.Controls, FMX.Bind.Navigator, REST.Response.Adapter, System.JSON;

  type
    TFrmCadFun = class(TForm)
      Header: TALLayout;
      Footer: TALLayout;
      ALRectangle1: TALRectangle;
      MaskedImage1: TMaskedImage;
      MaskedImage2: TMaskedImage;
      ALRectangle2: TALRectangle;
      MaskedImage3: TMaskedImage;
      ALLayout1: TALLayout;
      ALRectangle3: TALRectangle;
      cmbIndex: TComboBox;
      MaskedImage4: TMaskedImage;
      edtFuncionario: TEdit;
      Button1: TButton;
      StringGrid1: TStringGrid;
      FDMemTable1: TFDMemTable;
      BindSourceDB1: TBindSourceDB;
      BindingsList1: TBindingsList;
      LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
      NavigatorBindSourceDB1: TBindNavigator;
      procedure MaskedImage2Click(Sender: TObject);
      procedure MaskedImage3Click(Sender: TObject);
      procedure MaskedImage4Click(Sender: TObject);
      procedure Button1Click(Sender: TObject);

      procedure cmbIndexChange(Sender: TObject);
      private
        { Private declarations }
      public
        { Public declarations }
    end;

  var
    FrmCadFun: TFrmCadFun;

implementation

  {$R *.fmx}

  uses Principal, Cadastros, DmTabelas, MainFrame, IPPeerClient,

    REST.Client,
    Data.Bind.ObjectScope, REST.Types,

    Manutencao;

  procedure TFrmCadFun.Button1Click(Sender: TObject);
    var
      aJSON : string;
      JObj: TJSONArray;
      vConv: TCustomJSONDataSetAdapter;
    begin
      with DmTabela do
        begin
          RESTClient1.ResetToDefaults;
          RESTRequest1.ResetToDefaults;
          RESTResponse1.ResetToDefaults;
          RESTClient1.BaseURL := 'http://localhost:8082/SE1';

          HTTPBasicAuthenticator1.Username := 'SYSDBA';
          HTTPBasicAuthenticator1.Password := 'masterkey';

          try
            RESTRequest1.Resource := '/getemployee';
            RESTRequest1.Method := TRESTRequestMethod.rmGET;
            RESTRequest1.Execute;

            if RESTResponse1.StatusCode = 200 then
              begin
                aJson := RESTResponse1.Content;
                JObj := TJSONObject.ParseJSONValue(aJson) as TJSONArray;
                vConv := TCustomJSONDataSetAdapter.Create(Nil);
                try
                  vConv.DataSet := FDMemTable1;
                  vConv.UpdateDataSet(JObj);
                finally
                  vConv.Free;
                  JObj.Free;
                end;
              end;
          except

          end;
        end;
    end;

  procedure TFrmCadFun.cmbIndexChange(Sender: TObject);
    var
      key: char;
    begin
      if cmbIndex.ItemIndex = 0 then
        begin
          if ((key in ['0' .. '9'] = false) and (word(key) <> vkback)) then
            key := #0;
        end;
    end;

  procedure TFrmCadFun.MaskedImage2Click(Sender: TObject);
    begin
      frmPrincipal.Show;
      FrmCadFun.Close;
    end;

  procedure TFrmCadFun.MaskedImage3Click(Sender: TObject);
    begin
      FrmCadFun.Close;
    end;

  procedure TFrmCadFun.MaskedImage4Click(Sender: TObject);
    begin
      with DmTabela do
        begin
          DmTabela.CarregaServer();

          RESTRequest1.Resource := 'SE1/getemployees';
          RESTRequest1.Method := TRESTRequestMethod.rmGET;
          RESTRequest1.Execute;
        end;
    end;

end.