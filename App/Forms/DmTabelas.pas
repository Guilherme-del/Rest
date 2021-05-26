unit DmTabelas;

interface

  uses
    System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
    FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
    FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Client,
    Data.Bind.Components,
    Data.Bind.ObjectScope, REST.Authenticator.Basic, FireDAC.Stan.Async,
    FireDAC.DApt, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
    System.Bindings.Outputs, REST.Response.Adapter, Data.Bind.Grid,
    Data.Bind.DBScope, Datasnap.DBClient, Datasnap.Provider,
    Datasnap.DSConnect;

  type
    TDmTabela = class(TDataModule)
      RESTClient1: TRESTClient;
      RESTRequest1: TRESTRequest;
      RESTResponse1: TRESTResponse;
      RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
      HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
      cdsFunc: TClientDataSet;
      cdsFuncID: TWideStringField;
      cdsFuncNOME: TWideStringField;
      cdsFuncCNPJ: TWideStringField;
      cdsFuncLOGRADOURO: TWideStringField;
      cdsFuncCIDADE: TWideStringField;
      cdsFuncBAIRRO: TWideStringField;
      cdsFuncESTADO: TWideStringField;
      cdsFuncCEP: TWideStringField;
      cdsFuncTELEFONE: TWideStringField;
      cdsFuncCONTATO: TWideStringField;
      cdsFuncIE: TWideStringField;
      cdsFuncCOMPLEMENTO: TWideStringField;
      cdsFuncNUMERO: TWideStringField;
      private
        // procedure CarregaServer;
        { Private declarations }
      public
        { Public declarations }
        procedure CarregaServer;
    end;

  var
    DmTabela: TDmTabela;

implementation

  {%CLASSGROUP 'FMX.Controls.TControl'}
  {$R *.dfm}
  { TDataModule1 }

  procedure TDmTabela.CarregaServer;
    begin
      RESTClient1.ResetToDefaults;
      RESTRequest1.ResetToDefaults;
      RESTResponse1.ResetToDefaults;


      RESTClient1.BaseURL := 'http://localhost:8082/CRUD';
      RESTRequest1.Resource := '/transportadoras';
      HTTPBasicAuthenticator1.Username := 'SYSDBA';
      HTTPBasicAuthenticator1.Password := 'masterkey';
    end;
end.
