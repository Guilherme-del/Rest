object DmTabela: TDmTabela
  OldCreateOrder = False
  Height = 361
  Width = 626
  object RESTClient1: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 368
    Top = 40
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 504
    Top = 104
  end
  object RESTResponse1: TRESTResponse
    Left = 368
    Top = 104
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = cdsFunc
    FieldDefs = <>
    ResponseJSON = RESTResponse1
    Left = 136
    Top = 288
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Username = 'SYSDBA'
    Password = 'masterkey'
    Left = 504
    Top = 40
  end
  object cdsFunc: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FilterOptions = [foCaseInsensitive]
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    StoreDefs = True
    Left = 24
    Top = 288
    object cdsFuncID: TWideStringField
      FieldName = 'ID'
      Size = 255
    end
    object cdsFuncNOME: TWideStringField
      FieldName = 'NOME'
      Size = 255
    end
    object cdsFuncCNPJ: TWideStringField
      FieldName = 'CNPJ'
      Size = 255
    end
    object cdsFuncLOGRADOURO: TWideStringField
      FieldName = 'LOGRADOURO'
      Size = 255
    end
    object cdsFuncCIDADE: TWideStringField
      FieldName = 'CIDADE'
      Size = 255
    end
    object cdsFuncBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Size = 255
    end
    object cdsFuncESTADO: TWideStringField
      FieldName = 'ESTADO'
      Size = 255
    end
    object cdsFuncCEP: TWideStringField
      FieldName = 'CEP'
      Size = 255
    end
    object cdsFuncTELEFONE: TWideStringField
      FieldName = 'TELEFONE'
      Size = 255
    end
    object cdsFuncCONTATO: TWideStringField
      FieldName = 'CONTATO'
      Size = 255
    end
    object cdsFuncIE: TWideStringField
      FieldName = 'IE'
      Size = 255
    end
    object cdsFuncCOMPLEMENTO: TWideStringField
      FieldName = 'COMPLEMENTO'
      Size = 255
    end
    object cdsFuncNUMERO: TWideStringField
      FieldName = 'NUMERO'
      Size = 255
    end
  end
end
