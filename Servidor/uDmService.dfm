object ServerMethodDM: TServerMethodDM
  OldCreateOrder = False
  OnCreate = ServerMethodDataModuleCreate
  Encoding = esUtf8
  OnMassiveProcess = ServerMethodDataModuleMassiveProcess
  Height = 445
  Width = 889
  object DWServerEvents1: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovDateTime
            ParamName = 'result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'inputdata'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'resultstring'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'servertime'
        OnReplyEvent = DWServerEvents1EventsservertimeReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'sql'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'loaddatasetevent'
        OnReplyEvent = DWServerEvents1EventsloaddataseteventReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'result'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'getemployee'
        OnReplyEventByType = DWServerEvents1EventsgetemployeeReplyEventByType
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'result'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'segundoparam'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'getemployeeDW'
        OnReplyEvent = DWServerEvents1EventsgetemployeeDWReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovInteger
            ParamName = 'mynumber'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovInteger
            ParamName = 'result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'eventint'
        OnReplyEvent = DWServerEvents1EventseventintReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovDateTime
            ParamName = 'mydatetime'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovDateTime
            ParamName = 'result'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'eventdatetime'
        OnReplyEvent = DWServerEvents1EventseventdatetimeReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'entrada'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'helloworldPJ'
        OnReplyEvent = DWServerEvents1EventshelloworldReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovString
            ParamName = 'result'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'entrada'
            Encoded = True
          end>
        JsonMode = jmDataware
        Name = 'helloworldRDW'
        OnReplyEvent = DWServerEvents1EventshelloworldRDWReplyEvent
      end
      item
        Routes = [crAll]
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'sql1'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'sql2'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'sql3'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'sql4'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'sql5'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odOUT
            ObjectValue = ovBoolean
            ParamName = 'result'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'athorarioliberar'
        OnReplyEventByType = DWServerEvents1EventsathorarioliberarReplyEventByType
      end
      item
        Routes = [crAll]
        DWParams = <>
        JsonMode = jmDataware
        Name = 'assyncevent'
        OnReplyEvent = DWServerEvents1EventsassynceventReplyEvent
      end>
    ContextName = 'SE1'
    Left = 520
    Top = 17
  end
  object DWServerEvents2: TDWServerEvents
    IgnoreInvalidParams = True
    Events = <
      item
        Routes = [crGet]
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'helloworld'
        OnReplyEvent = DWServerEvents2Eventshelloworld2ReplyEvent
      end>
    ContextName = 'SE2'
    Left = 580
    Top = 17
  end
  object RESTDWPoolerDB1: TRESTDWPoolerDB
    RESTDriver = RESTDWDriverFD1
    Compression = True
    Encoding = esUtf8
    StrsTrim = True
    StrsEmpty2Null = True
    StrsTrim2Len = True
    Active = True
    PoolerOffMessage = 'RESTPooler not active.'
    ParamCreate = True
    Left = 404
    Top = 81
  end
  object RESTDWDriverFD1: TRESTDWDriverFD
    CommitRecords = 100
    OnPrepareConnection = RESTDWDriverFD1PrepareConnection
    Connection = Server_FDConnection
    Left = 405
    Top = 36
  end
  object Server_FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\DXE5\Desktop\Android Crud\Servidor\DB\EMPLOYEE' +
        '.FDB'
      'Protocol=Local'
      'ConnectionDef=EMPLOYEE')
    FetchOptions.AssignedValues = [evCursorKind]
    FetchOptions.CursorKind = ckDefault
    UpdateOptions.AssignedValues = [uvCountUpdatedRecords]
    ConnectedStoredUsage = []
    LoginPrompt = False
    Transaction = FDTransaction1
    OnError = Server_FDConnectionError
    BeforeConnect = Server_FDConnectionBeforeConnect
    Left = 45
    Top = 15
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 133
    Top = 60
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 249
    Top = 180
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 141
    Top = 15
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 113
    Top = 124
  end
  object FDTransaction1: TFDTransaction
    Options.AutoStop = False
    Options.DisconnectAction = xdRollback
    Connection = Server_FDConnection
    Left = 41
    Top = 71
  end
  object qryLogin: TFDQuery
    Connection = Server_FDConnection
    SQL.Strings = (
      'select * from tb_usuario'
      'where tb_usuario.nm_login = :usuario'
      'and tb_usuario.ds_senha = :password')
    Left = 337
    Top = 279
    ParamData = <
      item
        Name = 'USUARIO'
        DataType = ftString
        ParamType = ptInput
        Size = 30
      end
      item
        Name = 'PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Size = 30
      end>
    object qryLoginID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
      Origin = 'ID_PESSOA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryLoginNM_LOGIN: TStringField
      FieldName = 'NM_LOGIN'
      Origin = 'NM_LOGIN'
      Size = 30
    end
    object qryLoginDS_SENHA: TStringField
      FieldName = 'DS_SENHA'
      Origin = 'DS_SENHA'
      Size = 30
    end
    object qryLoginDS_FOTO: TBlobField
      FieldName = 'DS_FOTO'
      Origin = 'DS_FOTO'
    end
    object qryLoginID_USUARIO: TIntegerField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
    end
    object qryLoginFL_ATIVO: TStringField
      FieldName = 'FL_ATIVO'
      Origin = 'FL_ATIVO'
      Size = 1
    end
    object qryLoginDT_INCLUSAO: TSQLTimeStampField
      FieldName = 'DT_INCLUSAO'
      Origin = 'DT_INCLUSAO'
    end
    object qryLoginDT_ALTERACAO: TSQLTimeStampField
      FieldName = 'DT_ALTERACAO'
      Origin = 'DT_ALTERACAO'
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 145
    Top = 300
  end
  object DWServerContext1: TDWServerContext
    IgnoreInvalidParams = False
    ContextList = <
      item
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'entrada'
            Encoded = True
          end>
        ContentType = 'text/html'
        ContextName = 'init'
        Routes = [crAll]
        IgnoreBaseHeader = False
      end
      item
        DWParams = <>
        ContentType = 'text/html'
        ContextName = 'index'
        Routes = [crAll]
        IgnoreBaseHeader = False
      end
      item
        DWParams = <>
        ContentType = 'text/html'
        ContextName = 'openfile'
        Routes = [crAll]
        IgnoreBaseHeader = False
      end
      item
        DWParams = <>
        ContentType = 'text/html'
        ContextName = 'php'
        Routes = [crAll]
        IgnoreBaseHeader = False
      end
      item
        DWParams = <>
        ContentType = 'text/html'
        ContextName = 'angular'
        Routes = [crAll]
        IgnoreBaseHeader = False
      end
      item
        DWParams = <>
        ContentType = 'text/html'
        ContextName = 'zsend'
        Routes = [crAll]
        IgnoreBaseHeader = False
      end
      item
        DWParams = <>
        ContentType = 'text/html'
        ContextName = 'webpascal'
        DefaultHtml.Strings = (
          '')
        Routes = [crAll]
        ContextRules = dwcrEmployee
        IgnoreBaseHeader = False
      end>
    BaseContext = 'www'
    RootContext = 'index'
    Left = 568
    Top = 105
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 137
    Top = 244
  end
  object dwcrEmployee: TDWContextRules
    ContentType = 'text/html'
    MasterHtml.Strings = (
      '<!DOCTYPE html>'
      '<html lang="pt-br">'
      '<head>'
      '    <meta charset="UTF-8">'
      ''
      
        '    <meta http-equiv="Content-Type" content="text/html; charset=' +
        'UTF-8">'
      
        '    <meta name="viewport" content="width=device-width, initial-s' +
        'cale=1, shrink-to-fit=no">'
      
        '    <meta name="description" content="Consumindo servidor RestDa' +
        'taware">'
      '    <link rel="icon" href="img/browser.ico">'
      ''
      
        '    <link rel="alternate" type="application/rss+xml" title="RSS ' +
        '2.0" href="http://www.datatables.net/rss.xml">'
      
        '    <link rel="stylesheet" type="text/css" href="https://cdnjs.c' +
        'loudflare.com/ajax/libs/twitter-bootstrap/4.1.1/css/bootstrap.cs' +
        's">'
      
        '    <link rel="stylesheet" type="text/css" href="https://cdn.dat' +
        'atables.net/1.10.19/css/dataTables.bootstrap4.min.css">'
      ''
      ''
      
        '    <script type="text/javascript" language="javascript" src="ht' +
        'tps://code.jquery.com/jquery-3.3.1.js"></script>'
      
        '    <script type="text/javascript" language="javascript" src="ht' +
        'tps://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></' +
        'script>'
      
        '    <script type="text/javascript" language="javascript" src="ht' +
        'tps://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js' +
        '"></script>'
      ''
      '    {%labeltitle%}'
      ''
      
        '    <link rel="stylesheet" type="text/css" href="//cdn.datatable' +
        's.net/1.10.15/css/jquery.dataTables.css">'
      ''
      '</head>'
      '<body>'
      '    {%navbar%}'
      '    {%datatable%}'
      '    {%incscripts%} '
      '</body>'
      '</html>')
    MasterHtmlTag = '$body'
    IncludeScripts.Strings = (
      '<script src="https://code.jquery.com/jquery-1.12.4.js"></script>'
      
        '    <script src="https://cdn.datatables.net/1.10.16/js/jquery.da' +
        'taTables.min.js"></script>'
      '    <script type="text/javascript">'
      '        $(document).ready(function () {'
      
        '            var datatable = $('#39'#my-table'#39').DataTable({ //dataTab' +
        'le tamb'#233'm funcionar'
      
        '                dom: "Bfrtip", // Use dom: '#39'Blfrtip'#39', para fazer' +
        ' o seletor "por p'#225'gina" aparecer.'
      '                ajax: {'
      '                    url: window.location + '#39'&dwmark:datatable'#39','
      '                    type: '#39'GET'#39','
      
        '                    '#39'beforeSend'#39': function (request) {request.se' +
        'tRequestHeader("content-type","application/x-www-form-urlencoded' +
        '; charset=UTF-8");},'
      '                    dataSrc: '#39#39'},'
      '                stateSave: true,'
      '                columns: ['
      '                    {title: '#39'CODIGO'#39', data: '#39'EMP_NO'#39'},'
      '                    {title: '#39'NOME'#39', data: '#39'FIRST_NAME'#39'},'
      '                    {title: '#39'SOBRENOME'#39', data: '#39'LAST_NAME'#39'},'
      '                    {title: '#39'TELEFONE'#39', data: '#39'PHONE_EXT'#39'},'
      '                    {title: '#39'DATA'#39', data: '#39'HIRE_DATE'#39'},'
      
        '                    {title: '#39'EMPREGO/PAIS'#39', data: '#39'JOB_COUNTRY'#39'}' +
        ','
      '                    {title: '#39'SALARIO'#39', data: '#39'SALARY'#39'},'
      '                ],'
      '            });'
      '            console.log(datatable);'
      '        });'
      '    </script>')
    IncludeScriptsHtmlTag = '{%incscripts%}'
    Items = <
      item
        ContextTag = '<title>Consumindo servidor RestDataware</title>'
        TypeItem = 'text'
        ClassItem = 'form-control item'
        TagID = 'labeltitle'
        TagReplace = '{%labeltitle%}'
        ObjectName = 'labeltitle'
      end
      item
        ContextTag = 
          '<nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap' +
          ' p-0">'#13#10'        <a class="navbar-brand col-sm-3 col-md-2 mr-0" h' +
          'ref="index.html">'#13#10'            <img src="imgs/logodw.png" alt="R' +
          'EST DATAWARE" title="REST DATAWARE"/>'#13#10'        </a>'#13#10'        <h4' +
          ' style="color: #fff">Consumindo API REST (RDW) com Javascript</h' +
          '4>'#13#10'    </nav>'
        TypeItem = 'text'
        ClassItem = 'form-control item'
        TagID = 'navbar'
        TagReplace = '{%navbar%}'
        ObjectName = 'navbar'
      end
      item
        ContextTag = 
          '<main role="main" class="col-md-9 ml-sm-auto col-lg-12 pt-3 px-4' +
          '">'#13#10'        <div class="d-flex justify-content-between flex-wrap' +
          ' flex-md-nowrap align-pessoas-center pb-2 mb-3 border-bottom">'#13#10 +
          '            <h5 class="">Listagem de EMPREGADOS </h5>'#13#10'        <' +
          '/div>'#13#10'    </main>'#13#10#13#10'    <div class="col-xs-12 col-sm-12 col-md' +
          '-12 col-lg-12">'#13#10'        <div id="data-table_wrapper" class="dat' +
          'aTables_wrapper form-inline dt-bootstrap no-footer">'#13#10'          ' +
          '  <table id="my-table" class="display"></table>'#13#10'        </div>'#13 +
          #10'    </div>'
        TypeItem = 'text'
        ClassItem = 'form-control item'
        TagID = 'datatable'
        TagReplace = '{%datatable%}'
        ObjectName = 'datatable'
      end>
    Left = 757
    Top = 89
  end
  object dwscEmployeeCRUD: TDWServerContext
    IgnoreInvalidParams = False
    ContextList = <
      item
        DWParams = <>
        ContentType = 'text/html'
        ContextName = 'list'
        DefaultHtml.Strings = (
          '')
        Routes = [crAll]
        ContextRules = dwcrEmployee
        IgnoreBaseHeader = False
      end
      item
        DWParams = <>
        ContentType = 'text/html'
        ContextName = 'login'
        DefaultHtml.Strings = (
          '<!doctype html>'
          '<html>'
          '  <head>'
          #9'    <meta charset="utf-8">'
          #9'    <meta http-equiv="X-UA-Compatible" content="IE=edge">'
          
            #9'    <meta name="viewport" content="width=device-width, initial-' +
            'scale=1, shrink-to-fit=no">'
          #9'    <meta name="description" content="">'
          #9'    <meta name="author" content="">'
          #9'    <link rel="icon" href="layout/img/favicon.png">'
          ''
          #9'    <title>Genesis - Dicomvix</title>'
          ''
          #9'    <!-- Bootstrap core CSS -->'
          #9'    <link href="css/bootstrap.min.css" rel="stylesheet">'
          ''
          #9'    <!-- Custom styles for this template -->'
          #9'    <link href="css/signin.css" rel="stylesheet">'
          ''
          #9'    <script src="plugins/jquery/jquery.js"></script>'
          
            '                      <link href="signaturepad_css/jquery.signat' +
            'urepad.css" rel="stylesheet">'
          
            #9#9'<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3' +
            '.1/jquery.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxl' +
            'twRo8QtmkMRdAu8=" crossorigin="anonymous"></script>'
          #9'    <script src="plugins/jQueryUI/jquery-ui.js"></script>'
          #9'    <script src="js/bootstrap.min.js"></script>'
          '  </head>'
          ''
          '  <body>  '
          #9'<nav class="navbar navbar-expand-lg navbar-light bg-light">'
          
            #9'  <img class="sm-8 img-responsive logo_genesis" src="img/logo-g' +
            'enesis1.png">'
          
            #9'  <button class="navbar-toggler" type="button" data-toggle="col' +
            'lapse" data-target="#navbarNav" aria-controls="navbarNav" aria-e' +
            'xpanded="false" aria-label="Toggle navigation">'
          #9#9'<span class="navbar-toggler-icon"></span>'
          #9'  </button>'
          #9'  <div class="collapse navbar-collapse" id="navbarNav">  '#9'     '
          '          {%LabelMenu%}         '
          #9'  </div>'
          #9'</nav>'
          '    $body    '
          '          '
          '    <!-- Bootstrap core JavaScript'
          '    ================================================== -->'
          
            '    <!-- Placed at the end of the document so the pages load fas' +
            'ter -->'
          '      '
          '    <!-- jQuery first, then Popper.js, then Bootstrap JS -->'
          
            '    <script src="./www/plugins/jquery/jquery.slim.min.js" integr' +
            'ity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8a' +
            'btTE1Pi6jizo" crossorigin="anonymous"></script>'
          
            '    <script src="./www/plugins/popper/umd/popper.min.js" integri' +
            'ty="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l' +
            '8WvCWPIPm49" crossorigin="anonymous"></script>'
          
            '    <script src="./www/plugins/bootstrap/js/bootstrap.min.js" in' +
            'tegrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6' +
            'OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>'
          
            '    <script type="text/javascript" src="js/jquery.mask.min.js"><' +
            '/script> '
          '    <script type="text/javascript" src="js/mask.js"></script>'
          '    <script type="text/javascript" src="js/funcoes.js"></script>'
          
            #9'<script type="text/javascript" src="js/jquery.dataTables.js"></' +
            'script>    '
          
            #9'<script type="text/javascript" src="js/dataTables.bootstrap.js"' +
            '></script>'#9
          '  </body>'
          '</html>')
        Routes = [crAll]
        ContextRules = dwcLogin
        IgnoreBaseHeader = False
      end>
    BaseContext = 'wemcrud'
    BaseHeader.Strings = (
      '')
    RootContext = 'login'
    Left = 408
    Top = 160
  end
  object dwcLogin: TDWContextRules
    ContentType = 'text/html'
    MasterHtml.Strings = (
      '')
    MasterHtmlTag = '$body'
    IncludeScriptsHtmlTag = '{%incscripts%}'
    Items = <
      item
        ContextTag = 
          '<ul class="navbar-nav"> <li class="nav-item"> <a class="nav-link' +
          '" href="index">Login</a></ul>'
        TypeItem = 'text'
        ClassItem = 'form-control item'
        TagID = 'menu'
        TagReplace = '{%LabelMenu%}'
        ObjectName = 'menu'
      end
      item
        ContextTag = '<input {%itemtag%} placeholder="E-Mail">'
        TypeItem = 'text'
        ClassItem = 'form-control item'
        TagID = 'email'
        TagReplace = '{%edtEmail%}'
        ObjectName = 'email'
      end
      item
        ContextTag = '<input {%itemtag%} placeholder="Senha">'
        TypeItem = 'text'
        ClassItem = 'form-control item'
        TagID = 'esenha'
        TagReplace = '{%edtSenha%}'
        ObjectName = 'esenha'
      end
      item
        ContextTag = '<button {%itemtag%}>Login</button>'
        TypeItem = 'button'
        ClassItem = 'btn btn-primary'
        TagID = 'blogin'
        TagReplace = '{%btnLoginOK%}'
        ObjectName = 'blogin'
      end
      item
        ContextTag = '<button {%itemtag%}>Esqueci minha Senha</button>'
        TypeItem = 'button'
        ClassItem = 'btn btn-warning'
        TagID = 'bescsenha'
        TagReplace = '{%iwBTNSenha%}'
        ObjectName = 'bescsenha'
      end
      item
        ContextTag = '<button {%itemtag%}>Cadastrar Senha</button>'
        TypeItem = 'button'
        ClassItem = 'btn btn-success'
        TagID = 'bcadsenha'
        TagReplace = '{%btnCadastro%}'
        ObjectName = 'bcadsenha'
      end>
    Left = 757
    Top = 143
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    Left = 85
    Top = 244
  end
  object FDPhysODBCDriverLink1: TFDPhysODBCDriverLink
    Left = 49
    Top = 308
  end
  object FDQuery1: TFDQuery
    Connection = Server_FDConnection
    Left = 32
    Top = 200
  end
  object qryFunc: TFDQuery
    Connection = Server_FDConnection
    SQL.Strings = (
      'select * from employee'
      '')
    Left = 432
    Top = 232
    object qryFuncEMP_NO: TSmallintField
      FieldName = 'EMP_NO'
      Origin = 'EMP_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryFuncFIRST_NAME: TStringField
      FieldName = 'FIRST_NAME'
      Origin = 'FIRST_NAME'
      Required = True
      Size = 15
    end
    object qryFuncLAST_NAME: TStringField
      FieldName = 'LAST_NAME'
      Origin = 'LAST_NAME'
      Required = True
    end
    object qryFuncPHONE_EXT: TStringField
      FieldName = 'PHONE_EXT'
      Origin = 'PHONE_EXT'
      Size = 4
    end
    object qryFuncHIRE_DATE: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'HIRE_DATE'
      Origin = 'HIRE_DATE'
    end
    object qryFuncDEPT_NO: TStringField
      FieldName = 'DEPT_NO'
      Origin = 'DEPT_NO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryFuncJOB_CODE: TStringField
      FieldName = 'JOB_CODE'
      Origin = 'JOB_CODE'
      Required = True
      Size = 5
    end
    object qryFuncJOB_GRADE: TSmallintField
      FieldName = 'JOB_GRADE'
      Origin = 'JOB_GRADE'
      Required = True
    end
    object qryFuncJOB_COUNTRY: TStringField
      FieldName = 'JOB_COUNTRY'
      Origin = 'JOB_COUNTRY'
      Required = True
      Size = 15
    end
    object qryFuncSALARY: TFloatField
      FieldName = 'SALARY'
      Origin = 'SALARY'
      Required = True
    end
    object qryFuncFULL_NAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'FULL_NAME'
      Origin = 'FULL_NAME'
      ProviderFlags = []
      ReadOnly = True
      Size = 37
    end
  end
  object qryInsFunc: TFDQuery
    CachedUpdates = True
    AggregatesActive = True
    Connection = Server_FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateNonBaseFields]
    UpdateOptions.UpdateTableName = 'employee'
    SQL.Strings = (
      
        'INSERT INTO employee (emp_no,dept_no,first_name,last_name, phone' +
        '_ext, hire_date,job_code,job_grade,job_country,salary,full_name)'
      
        'VALUES (:emp_no, :dept_no, :first_name, :last_name, :phone_ext, ' +
        ':hire_date, :job_code, :job_grade, :job_country,:salary,:full_na' +
        'me)')
    Left = 432
    Top = 288
    ParamData = <
      item
        Name = 'EMP_NO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DEPT_NO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FIRST_NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 40
        Value = Null
      end
      item
        Name = 'LAST_NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 40
        Value = Null
      end
      item
        Name = 'PHONE_EXT'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'HIRE_DATE'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'JOB_CODE'
        DataType = ftString
        ParamType = ptInput
        Size = 20
        Value = Null
      end
      item
        Name = 'JOB_GRADE'
        DataType = ftString
        ParamType = ptInput
        Size = 10
        Value = Null
      end
      item
        Name = 'JOB_COUNTRY'
        ParamType = ptInput
        Size = 25
        Value = Null
      end
      item
        Name = 'SALARY'
        DataType = ftCurrency
        ParamType = ptInput
        Size = 10
        Value = Null
      end
      item
        Name = 'FULL_NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 50
        Value = Null
      end>
  end
  object qryDelFunc: TFDQuery
    Connection = Server_FDConnection
    SQL.Strings = (
      'DELETE FROM employee'
      'employee.emp_no = :codigo')
    Left = 432
    Top = 344
    ParamData = <
      item
        Name = 'CODIGO'
        ParamType = ptInput
        Value = Null
      end>
  end
end
