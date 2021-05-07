unit DmTabelas;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Authenticator.Basic, FireDAC.Stan.Async, FireDAC.DApt, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, REST.Response.Adapter, Data.Bind.Grid, Data.Bind.DBScope;

type
  TDmTabela = class(TDataModule)
    BindingsList1: TBindingsList;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    RESTResponse1: TRESTResponse;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
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
  RESTClient1.BaseURL := 'http://localhost:8082/';
end;

end.
