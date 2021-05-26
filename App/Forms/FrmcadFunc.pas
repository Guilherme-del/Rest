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
    Data.Bind.Controls, FMX.Bind.Navigator, REST.Response.Adapter, System.JSON,
    FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Phys.FBDef,
    FireDAC.UI.Intf, FireDAC.Comp.UI, FireDAC.Phys,
    FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.StorageJSON,
    Datasnap.DBClient, Datasnap.Provider, IdBaseComponent, IdComponent,
    IdTCPConnection, IdTCPClient, IdHTTP, FMX.Memo;

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
      MaskNew: TMaskedImage;
      edtNome: TEdit;
      btnSalvaNew: TButton;
      NavigatorBindSourceDB1: TBindNavigator;
      DataSource1: TDataSource;
      BindSourceDB1: TBindSourceDB;
      BindingsList1: TBindingsList;
      btnSalvaMod: TButton;
      btnNew: TButton;
      ALRectangle4: TALRectangle;
      maskMod: TMaskedImage;
      MaskedImage6: TMaskedImage;
      btnModifica: TButton;
      MaskedImage7: TMaskedImage;
      Label1: TLabel;
      Label2: TLabel;
      lblCod: TLabel;
      BindSourceDB2: TBindSourceDB;
      LinkPropertyToFieldText: TLinkPropertyToField;
      LinkControlToField1: TLinkControlToField;
      IdHTTP1: TIdHTTP;
      memoRequest: TMemo;
      edtCNPJ: TEdit;
      Label3: TLabel;
      edtIE: TEdit;
      Label4: TLabel;
      edtCidade: TEdit;
      Label5: TLabel;
      edtEstado: TEdit;
      Label6: TLabel;
      edtLogradouro: TEdit;
      Label7: TLabel;
      Label8: TLabel;
      edtNum: TEdit;
      edtBairro: TEdit;
      Label9: TLabel;
      edtCep: TEdit;
      Label10: TLabel;
      Label11: TLabel;
      edtCel: TEdit;
      Label12: TLabel;
      edtTel: TEdit;
      LinkControlToField2: TLinkControlToField;
      LinkControlToField3: TLinkControlToField;
      LinkControlToField4: TLinkControlToField;
      LinkControlToField5: TLinkControlToField;
      LinkControlToField6: TLinkControlToField;
      LinkControlToField7: TLinkControlToField;
      LinkControlToField8: TLinkControlToField;
      LinkControlToField9: TLinkControlToField;
      LinkControlToField10: TLinkControlToField;
      LinkControlToField11: TLinkControlToField;
      MaskedImage4: TMaskedImage;
      btnDel: TButton;
      MaskedImage5: TMaskedImage;
      btnCanc: TButton;
      procedure btnSalvaNewClick(Sender: TObject);
      procedure btnSalvaModClick(Sender: TObject);
      procedure btnNewClick(Sender: TObject);
      procedure btnMod(Sender: TObject);
      procedure edtNomeChange(Sender: TObject);
      procedure MaskedImage3Click(Sender: TObject);
      procedure MaskedImage2Click(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure btnNewExit(Sender: TObject);
      procedure btnDelClick(Sender: TObject);
      procedure btnCancClick(Sender: TObject);

      private
        { Private declarations }
        procedure CriaNovo;
        procedure Desabilitacampos;
        procedure Habilitacampos;
        procedure Desabilitabotao;
        procedure Habilitabotao1;
        procedure Habilitabotao2;
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

  type
    TIdHTTPAccess = class(TIdHTTP)
    end;

  procedure TFrmCadFun.btnSalvaNewClick(Sender: TObject);
    var
      http: TIdHTTP;
      aJSON: string;
      JObj: TJSONArray;
      jsontosend: TStream;
      vConv: TCustomJSONDataSetAdapter;
      Params: Tstringlist;
    begin
      if edtNome.Text = '' then
        begin
          showmessage('Por favor insira o nome do fornecedor. ');
          edtNome.SetFocus;
          exit
        end;

      with DmTabela do
        begin
          btnModifica.Visible := true;
          lblCod.Text := '';
          http := TIdHTTP.Create(nil);
          http.HandleRedirects := true;
          http.ReadTimeout := 5000;
          http.MaxAuthRetries := 0;
          http.HTTPOptions := [hoInProcessAuth];
          try
            Params := Tstringlist.Create;
            Params.add('[{' + '"' + 'NOME' + '"' + ':' + '"' + edtNome.Text +
                '"' + ',');
            Params.add('"' + 'CNPJ' + '"' + ':' + '"' + edtCNPJ.Text +
                '"' + ',');
            Params.add('"' + 'LOGRADOURO' + '"' + ':' + '"' + edtLogradouro.Text
                + '"' + ',');
            Params.add('"' + 'CIDADE' + '"' + ':' + '"' + edtCidade.Text +
                '"' + ',');
            Params.add('"' + 'BAIRRO' + '"' + ':' + '"' + edtBairro.Text +
                '"' + ',');
            Params.add('"' + 'ESTADO' + '"' + ':' + '"' + edtEstado.Text +
                '"' + ',');
            Params.add('"' + 'CEP' + '"' + ':' + '"' + edtCep.Text + '"' + ',');
            Params.add('"' + 'TELEFONE' + '"' + ':' + '"' + edtTel.Text +
                '"' + ',');
            Params.add('"' + 'CONTATO' + '"' + ':' + '"' + edtCel.Text +
                '"' + ',');
            Params.add('"' + 'IE' + '"' + ':' + '"' + edtIE.Text + '"' + ',');
            Params.add('"' + 'NUMERO' + '"' + ':' + '"' + edtNum.Text +
                '"' + '}] ');

            if RESTResponse1.StatusCode = 200 then
              begin
                http.Request.BasicAuthentication := true;
                http.Request.Username := 'SYSDBA';
                http.Request.Password := 'masterkey';
                http.Request.Accept := 'http';
                http.Request.ContentType := 'application/json';
                http.Request.CharSet := 'utf-8';
                // id := lblCod.Text;

                try
                  jsontosend := TStringStream.Create(Params.Text,
                    System.SysUtils.TEncoding.UTF8);

                  memoRequest.Lines.Text :=
                    http.Post('http://192.168.5.5:8082/CRUD/Transportadoras',
                    jsontosend);
                finally
                  jsontosend.free;
                  // http.free;
                end;
              end;
          except
          end;
          FormCreate(self);
        end;
      Desabilitabotao;
      Desabilitacampos;
      btnModifica.Visible := true;
      btnDel.Visible := true;
      btnCanc.Visible := false;
      MaskedImage5.Visible := false;
    end;

  procedure TFrmCadFun.btnCancClick(Sender: TObject);
    begin
      try
        begin
          Desabilitabotao;
          Desabilitacampos;
          btnModifica.Visible := true;
          btnDel.Visible := true;
          btnNew.Visible := true;
          btnCanc.Visible := false;
          MaskedImage5.Visible := false;
        end;
      finally
        with DmTabela do
          begin
            RESTClient1.ResetToDefaults;
            RESTRequest1.ResetToDefaults;
            RESTResponse1.ResetToDefaults;
            RESTClient1.BaseURL := 'http://192.168.5.5:8082/CRUD';
            HTTPBasicAuthenticator1.Username := 'SYSDBA';
            HTTPBasicAuthenticator1.Password := 'masterkey';
            RESTRequest1.Resource := '/transportadoras';
            RESTRequest1.Method := TRESTRequestMethod.rmGET;
            RESTRequest1.Execute;
          end;
      end;
    end;

  procedure TFrmCadFun.btnDelClick(Sender: TObject);
    var
      JSONObj: TJSONObject;
      Params: Tstringlist;
      JObj: TJSONArray;
      http: TIdHTTP;
      id, aJSON: string;
      jsontosend, res: TStringStream;
    begin
      MessageDlg('Deseja excluir o registro ?',
        System.UITypes.TMsgDlgType.mtInformation,
        [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
          procedure(const AResult: System.UITypes.TModalResult)
          begin
            case AResult of
              mrYES:
                begin
                  http := TIdHTTP.Create(nil);
                  http.HandleRedirects := true;
                  http.ReadTimeout := 5000;
                  http.MaxAuthRetries := 0;
                  http.HTTPOptions := [hoInProcessAuth];
                  try
                    btnNew.Visible := true;
                    begin
                      IdHTTP1.Request.BasicAuthentication := true;
                      IdHTTP1.Request.Username := 'SYSDBA';
                      IdHTTP1.Request.Password := 'masterkey';
                      IdHTTP1.Request.Accept := 'http';
                      IdHTTP1.Request.ContentType := 'application/json';
                      IdHTTP1.Request.CharSet := 'utf-8';
                      try
                        Params := Tstringlist.Create;
                        Params.add('[{' + '"ID":' + lblCod.Text + '}]');
                        res := TStringStream.Create('');
                        jsontosend := TStringStream.Create(Params.Text,
                          System.SysUtils.TEncoding.UTF8);

                        // http.delete('http://192.168.5.5:8082/CRUD/Transportadoras',jsontosend); tentativas falhas -------<
                        // TIdHTTPAccess(http).DoRequest('DELETE', 'http://192.168.5.5:8082/CRUD/Transportadoras', nil, jsontosend, []);

                        TIdHTTPAccess(IdHTTP1).DoRequest(Id_HTTPMethodDelete,
                          'http://192.168.5.5:8082/CRUD/Transportadoras',
                          jsontosend, res, []);
                      finally
                        with DmTabela do
                          begin
                            RESTClient1.ResetToDefaults;
                            RESTRequest1.ResetToDefaults;
                            RESTResponse1.ResetToDefaults;
                            RESTClient1.BaseURL :=
                              'http://192.168.5.5:8082/CRUD';
                            HTTPBasicAuthenticator1.Username := 'SYSDBA';
                            HTTPBasicAuthenticator1.Password := 'masterkey';
                            RESTRequest1.Resource := '/transportadoras';
                            RESTRequest1.Method := TRESTRequestMethod.rmGET;
                            RESTRequest1.Execute;
                          end;
                      end;
                    end;
                  finally
                    jsontosend.free;
                    // testar exception
                  end;
                end;
              mrNo:
                begin
                  // FrmCadFun.Create(self);
                end;
            end;
          end);
    end;

  procedure TFrmCadFun.btnMod(Sender: TObject);
    begin
      Habilitacampos;
      maskMod.Visible := true;
      btnNew.Visible := false;
      edtNome.SetFocus;
      Habilitabotao2;
      btnDel.Visible := false;
      btnCanc.Visible := true;
      MaskedImage5.Visible := true;
    end;

  procedure TFrmCadFun.btnSalvaModClick(Sender: TObject);
    var
      JSONObj: TJSONObject;
      Params: Tstringlist;
      JObj: TJSONArray;
      http: TIdHTTP;
      id, aJSON: string;
      vConv: TCustomJSONDataSetAdapter;
      jsontosend: TStream;
    begin
      with DmTabela do
        begin
          http := TIdHTTP.Create(nil);
          http.HandleRedirects := true;
          http.ReadTimeout := 5000;
          http.MaxAuthRetries := 0;
          http.HTTPOptions := [hoInProcessAuth];
          try
            btnNew.Visible := true;
            begin
              Params := Tstringlist.Create;
              Params.add('[{' + '"' + 'ID' + '"' + ':' + lblCod.Text + ',');
              Params.add('"' + 'NOME' + '"' + ':' + '"' + edtNome.Text +
                '"' + ',');
              Params.add('"' + 'CNPJ' + '"' + ':' + '"' + edtCNPJ.Text +
                '"' + ',');
              Params.add('"' + 'LOGRADOURO' + '"' + ':' + '"' +
                edtLogradouro.Text + '"' + ',');
              Params.add('"' + 'CIDADE' + '"' + ':' + '"' + edtCidade.Text +
                '"' + ',');
              Params.add('"' + 'BAIRRO' + '"' + ':' + '"' + edtBairro.Text +
                '"' + ',');
              Params.add('"' + 'ESTADO' + '"' + ':' + '"' + edtEstado.Text +
                '"' + ',');
              Params.add('"' + 'CEP' + '"' + ':' + '"' + edtCep.Text +
                '"' + ',');
              Params.add('"' + 'TELEFONE' + '"' + ':' + '"' + edtTel.Text +
                '"' + ',');
              Params.add('"' + 'CONTATO' + '"' + ':' + '"' + edtCel.Text +
                '"' + ',');
              Params.add('"' + 'IE' + '"' + ':' + '"' + edtIE.Text + '"' + ',');
              Params.add('"' + 'NUMERO' + '"' + ':' + '"' + edtNum.Text +
                '"' + '}] ');
              try
                http.Request.BasicAuthentication := true;
                http.Request.Username := 'SYSDBA';
                http.Request.Password := 'masterkey';
                http.Request.Accept := 'http';
                http.Request.ContentType := 'application/json';
                http.Request.CharSet := 'utf-8';
                id := lblCod.Text;

                jsontosend := TStringStream.Create(Params.Text,
                  System.SysUtils.TEncoding.UTF8);

                memoRequest.Lines.Text :=
                  http.Put('http://192.168.5.5:8082/CRUD/Transportadoras',
                  jsontosend);
              finally
                // http.free;
                jsontosend.free;
              end;
            end;
          except
          end;
        end;
      Desabilitabotao;
      Desabilitacampos;
      btnNew.Visible := true;
      btnDel.Visible := true;
      btnCanc.Visible := false;
      MaskedImage5.Visible := false;
    end;

  procedure TFrmCadFun.btnNewClick(Sender: TObject);
    begin
      btnCanc.Visible := true;
      MaskedImage5.Visible := true;
      CriaNovo;
      Habilitacampos;
      MaskNew.Visible := true;
      Habilitabotao1;
      edtNome.SetFocus;
      btnModifica.Visible := false;
      btnDel.Visible := false;

      DmTabela.cdsFunc.Close;

    end;

  procedure TFrmCadFun.btnNewExit(Sender: TObject);
    begin
      CriaNovo;
      Habilitacampos;
      MaskNew.Visible := true;
      Habilitabotao1;
      edtNome.SetFocus;
      btnModifica.Visible := false;
    end;

  procedure TFrmCadFun.CriaNovo;
    var
      i: Integer;
    begin
      for i := 0 to FrmCadFun.ComponentCount - 1 do
        begin
          if FrmCadFun.Components[i] is TEdit then
            TEdit(FrmCadFun.Components[i]).Text := '';
        end;
      lblCod.Text := '';
    end;

  procedure TFrmCadFun.Desabilitabotao;
    begin
      btnSalvaNew.Enabled := false;
      btnSalvaMod.Enabled := false;
      btnSalvaNew.Visible := false;
      btnSalvaMod.Visible := false;
      // btnDel.Visible := false;
      maskMod.Visible := false;
      MaskNew.Visible := false;
    end;

  procedure TFrmCadFun.Desabilitacampos;
    var
      i: Integer;
    begin
      for i := 0 to FrmCadFun.ComponentCount - 1 do
        begin
          if FrmCadFun.Components[i] is TEdit then
            TEdit(FrmCadFun.Components[i]).Enabled := false;
        end;

    end;

  procedure TFrmCadFun.edtNomeChange(Sender: TObject);
    begin
      lblCod.Text := '';
    end;

  procedure TFrmCadFun.FormCreate(Sender: TObject);
    var
      aJSON: string;
      JObj: TJSONArray;
      vConv: TCustomJSONDataSetAdapter;
    begin
      try
        with DmTabela do
          begin
            RESTClient1.ResetToDefaults;
            RESTRequest1.ResetToDefaults;
            RESTResponse1.ResetToDefaults;
            RESTClient1.BaseURL := 'http://192.168.5.5:8082/CRUD';
            HTTPBasicAuthenticator1.Username := 'SYSDBA';
            HTTPBasicAuthenticator1.Password := 'masterkey';
            RESTRequest1.Resource := '/transportadoras';
            RESTRequest1.Method := TRESTRequestMethod.rmGET;
            RESTRequest1.Execute;
            RESTResponseDataSetAdapter1.Active := true;
            try
              if RESTResponse1.StatusCode = 200 then
                begin
                  aJSON := RESTResponse1.Content;
                  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
                  try
                  finally
                    JObj.free;
                  end;
                end;
            except
              showmessage('Falha ao conectar-se com o servidor!');
            end;
          end;
        Desabilitacampos;
        Desabilitabotao;
      except
        showmessage('Falha ao conectar-se com o servidor!');
      end;
    end;

  procedure TFrmCadFun.Habilitabotao1;
    begin
      btnSalvaNew.Enabled := true;
      btnSalvaNew.Visible := true;
      maskMod.Visible := false;
    end;

  procedure TFrmCadFun.Habilitabotao2;
    begin
      btnSalvaMod.Enabled := true;
      btnSalvaMod.Visible := true;
      btnDel.Visible := false;
      maskMod.Visible := true;
    end;

  procedure TFrmCadFun.Habilitacampos;
    var
      i: Integer;
    begin
      for i := 0 to FrmCadFun.ComponentCount - 1 do
        begin
          if FrmCadFun.Components[i] is TEdit then
            TEdit(FrmCadFun.Components[i]).Enabled := true;
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

end.
