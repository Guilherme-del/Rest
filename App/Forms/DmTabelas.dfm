object DmTabela: TDmTabela
  OldCreateOrder = False
  Height = 331
  Width = 580
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 28
    Top = 29
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Response = RESTResponse1
    Left = 240
    Top = 104
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 112
    Top = 48
  end
  object RESTClient1: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 64
    Top = 104
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 80
    Top = 168
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Left = 352
    Top = 64
  end
end
