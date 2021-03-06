unit uutils;


interface

uses
  SysUtils, Classes, ShellApi, Windows, Dialogs, Forms, DB, Graphics, Jpeg,
  ExtCtrls, StrUtils, Math, Aviso, Erro, Pergunta, Controls, SenhaProtec, IniFiles, DBClient;

const
  SuporteABCS = 'Suporte ABCS: (19) 3866-1927 - suporte@abcsinformatica.com.br';
  WH_Keyboard_LL = 13;
  LLKHF_ALTDOWN  = $00000020;
  C1  = 49;


type
   TTipoImagem = (tiBitmap, tiJpeg);

  PKBDLLHOOKSTRUCT = ^KBDLLHOOKSTRUCT;
    KBDLLHOOKSTRUCT = packed record
      vkCode      : DWORD;
      scanCode    : DWORD;
      flags       : DWORD;
      time        : DWORD;
      dwExtraInfo : DWORD;
    end;

   TWinVer = ( wvUnknown, wvWin95, wvWin95OSR2, wvWin98, wvWin98SE,
              wvWinME, wvWinNT31, wvWinNT35, wvWinNT351, wvWinNT4, wvWin2000, wvWinXP);

   TString = class(TObject)
    private
      fStr: String;
    public
      constructor Create(const AStr: String) ;
      property Str: String read FStr write FStr;
    end;

  //suporte a arrays dinamicos
  TStringArray   = array of String;
  TIntegerArray  = array of Integer;

  //comparação
  function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: String): String; overload;
  function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: Integer): Integer; overload;
  function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: Extended): Extended; overload;
  function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: TDateTime): TDateTime; overload;
  function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: Boolean): Boolean; overload;
  function Between(Valor, Inicio, Fim: Integer): Boolean; overload;
  function Between(Valor, Inicio, Fim: Extended): Boolean; overload;
  function Between(Valor, Inicio, Fim: TDateTime): Boolean; overload;
  function Between(const Valor, Inicio, Fim: String): Boolean; overload;

  //incrementa o array em 1 unidade
  function IncDinArray(var A: TStringArray): Integer; overload;
  function IncDinArray(var A: TIntegerArray): Integer; overload;
  //adiciona um elemento no fim do array
  function DinArrayAdd(var A: TStringArray; const S: String): Integer; overload;
  function DinArrayAdd(var A: TIntegerArray; I: Integer): Integer; overload;
  //localiza elemento num array
  function DinArrayFnd(const A: TStringArray; const S: String): Integer; overload;
  function DinArrayFnd(const A: TIntegerArray; const I: Integer): Integer; overload;

  //verifica se 2 strings são iguais ignorando a caixa
  function Igual(const S1, S2: String): Boolean;

  procedure FindFiles(const Filtro: String; var Retorno: TStringArray);
  procedure CopyF(const Source, Dest: String);
  procedure CopyDir(const Source, Dest: String);
  function  ExtraiArg(const Args, Chr: string; var Pos: Integer): string;
  function  ExtraiArgStr(const Args, Str: string; var Pos: Integer): string;
  procedure ExtraiArgsStr(const Args, Str: String; var ArgsRet: TStringArray);
  function Pergunta( Mens: string; Botao2Def: Boolean = False ): Boolean;
  procedure Aviso( Mens: String );
  procedure Erro( Mens: String; Suporte: Boolean = False );

  procedure ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao : TImage);
  procedure GravaFoto(DataSet : TDataSet; BlobFieldName, FileName :String);
  procedure ExcluiFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao : TImage);
  procedure ExportaFoto(DataSet : TDataSet; BlobFieldName, FileName: String; TipoImagem : TTipoImagem);

  function ColocaFiltro( const SQLOrig, Where: WideString ): WideString;
  //Procedure usada para liberar todos os objectos associados a um TString, principalmente usado para qdo associar uma string com o método AddObjects
  procedure FreeObjects(const strings: TStrings) ;
  //Arredonda o valor para a qtde de casas decimais informada
  function Arredondar( const Valor: Single; CasasDec: Byte ): Single;
  function NomeTecla(Key: Word; Shift: TShiftState):string;
  function FMonta_EAN(CodEAN13: String): String;
  function PosicaoVetor(sTexto:string;aVetor:array of string):integer;
  //Converte cor HTML para TColor
  function HexToTColor(sColor : string) : TColor;
  //Detecta a versão do windows
  function VersaoWin: TWinVer;
  //Ativa e desativa as teclas do windows
  procedure HabDesTeclasWin( Habilita: Boolean );
  function Decrypt(const S: String): String;
  function Encrypt(Action, Src: String): String;
  function SoValidade( SerialFull: ShortString ): Integer;
  function SoSerial( SerialFull: ShortString ): ShortString;
  function SoLicenca( SerialFull: ShortString ): ShortString;
  function CalcSerial( Licenca: ShortString; ValidReal: Integer ): ShortString;
  function CalcSenha( NSerial: ShortString ): ShortString;
  function ChecaEstado( DataSet: TDataSet ): Boolean;
  function Exclusao( DataSet: TDataSet; Mens: Boolean ): Boolean;
  function ChecaCPF( CPF: ShortString ): Boolean;
  function SoNumeros( const Valor: ShortString ): String;
  function LPad(const Valor: ShortString; const Tamanho: Integer; const Ch: Char): ShortString;
  function ChecaCNPJ( CNPJ: ShortString ): Boolean;
  //filtros
  procedure PreparaFiltro( var Filtro: WideString; Condicao: WideString ); overload;
  procedure PreparaFiltro( var Filtro: WideString; Campo, Valor, Sinal: ShortString; Aspas: Boolean ); overload;
  procedure PreparaFiltro( var Filtro: WideString; Campo, Valor: ShortString; Aspas: Boolean ); overload;
implementation

var
  OldHook: HHook;

constructor TString.Create(const AStr: String) ;
begin
  inherited Create;
  FStr := AStr;
end;

function SoLicenca( SerialFull: ShortString ): ShortString;
var
  Licenca, Validade: String;
begin
  Validade := Copy(SerialFull, 0, 3);
  Licenca :=   IntToStr( StrToInt('$'+Copy(SerialFull, 6, 5)));
  Licenca := Copy(Licenca, 0, Length(Licenca)-2);
  Result := Licenca+'-'+Validade;
end;

procedure PreparaFiltro( var Filtro: WideString; Condicao: WideString );
begin
  if Trim( Condicao ) <> '' then
  begin
    if Trim( Filtro ) <> '' then
      Filtro := Filtro + ' and ';
    Filtro := Filtro + Condicao;
  end;
end;

procedure PreparaFiltro( var Filtro: WideString; Campo, Valor, Sinal: ShortString; Aspas: Boolean );
var
  FiltroAux: String;
begin
  if Trim( Valor ) <> '' then
  begin
    if Aspas then
      FiltroAux := Campo + ' ' + Sinal + ' ' + QuotedStr( Trim(Valor) )
    else
      FiltroAux := Campo + ' ' + Sinal + ' ' + Trim(Valor);
    PreparaFiltro( Filtro, FiltroAux );
  end;
end;

procedure PreparaFiltro( var Filtro: WideString; Campo, Valor: ShortString; Aspas: Boolean );
begin
  PreparaFiltro( Filtro, Campo, Valor, '=', Aspas );
end;

function ChecaCNPJ( CNPJ: ShortString ): Boolean;
var
  V: ShortString;
  A, B, C,
  DV: Integer;
begin
  try
    if CNPJ = '' then
      SysUtils.Abort;
    CNPJ := SoNumeros( CNPJ );
    V := CNPJ;
    if Length(V) <> 14 then
      V := LPad(V, 14, '0');
    B := 0;
    C := 0;
    for A := 2 to 9 do
      B := B + StrToInt(Copy(V, 14-A, 1)) * A;
    for A := 2 to 5 do
      B := B + StrToInt(Copy(V, 6-A, 1)) * A;
    if (B mod 11 = 0) or (B mod 11 = 1) then
      DV := 0
    else
      DV := 11 - (B mod 11);
    if DV <> StrToInt(Copy(V, 13, 1)) then
      SysUtils.Abort;
    for A := 1 to 8 do
      C := C + StrToInt(Copy(V, 14-A, 1)) * (A + 1);
    for A := 1 to 5 do
      C := C + StrToInt(Copy(V, 6-A, 1)) * (A + 1);
    if (C mod 11 = 0) or (C mod 11 = 1) then
      DV := 0
    else
      DV := 11 - (C mod 11);
    if DV <> StrToInt(Copy(V, 14, 1)) then
      SysUtils.Abort;
    Result := True;
  except
    Result := False;
  end;
end;

function LPad(const Valor: ShortString; const Tamanho: Integer; const Ch: Char): ShortString;
begin
  if Length(Valor) >= Tamanho then
    Result:= Copy(Valor, Length(Valor) - Tamanho + 1, Tamanho)
  else
    Result:= StringOfChar(Ch, Tamanho - Length(Valor)) + Valor;
end;

function SoNumeros( const Valor: ShortString ): String;
var
  i: SmallInt;
  Aux: String;
begin
  Aux := '';
  for i:=1 to Length( Valor ) do
    if Ord( Valor[i] ) in [48..57] then
      Aux := Aux + Valor[i];
  Result := Aux;
end;

function ChecaCPF( CPF: ShortString ): Boolean;
var
  V, V1: ShortString;
  A, B, C,
  DV: Integer;
begin
  try
    if CPF = '' then
      SysUtils.Abort;
    CPF := SoNumeros( CPF );
    V := CPF;
    if Length(V) <> 11 then
      V := LPad(V, 11, '0');
    B := 0;
    C := 0;
    for A := 2 to 10 do
      B := B + StrToInt(Copy(V, A-1, 1)) * (12 - A);
    if (B mod 11 = 0) or (B mod 11 = 1) then
      DV := 0
    else
      DV := 11 - (B mod 11);
    if DV <> StrToInt(Copy(V, 10, 1)) then
      SysUtils.Abort;
    V1 := V + IntToStr(DV);
    for A := 2 to 11 do
      C := C + StrToInt(Copy(V1, A-1 ,1)) * (13 - A);
    if (C mod 11 = 0) or (C mod 11 = 1) then
      DV := 0
    else
      DV := 11 - (C mod 11);
    if DV <> StrToInt(Copy(V, 11, 1)) then
      SysUtils.Abort;
    Result := True;
  except
    Result := False;
  end;
end;


function Exclusao( DataSet: TDataSet; Mens: Boolean ): Boolean;
begin

end;

function ChecaEstado( DataSet: TDataSet ): Boolean;
var
  Retorno: Integer;
begin

end;

function CalcSenha( NSerial: ShortString ): ShortString;
var
  DiaAux, MesAux, AnoAux, Fator: Word;
begin
  DecodeDate( Date, AnoAux, MesAux, DiaAux );
  NSerial := SoSerial( NSerial );
  if ( DiaAux div 2 ) = 0 then
    Fator := StrToInt( '$' + Copy( NSerial, 11, 2 ) ) + DiaAux
  else
    Fator := ( StrToInt( '$' + Copy( NSerial, 11, 2 ) ) + StrToInt( '$' + Copy( NSerial, 11, 2 ) ) ) + MesAux;
  Result := Format( '%x-%x', [ ( StrToInt( '$' + Copy( NSerial, 1, 5 ) ) * Fator ),
                               ( StrToInt( '$' + Copy( NSerial, 7, 6 ) ) * Fator + MesAux ) ] );
end;

function CalcSerial( Licenca: ShortString; ValidReal: Integer ): ShortString;
const
  Validade: byte = 63;
var
  Dia, Mes, Ano, I, ValorDC, DC: Word;
  DiaMes: ShortString;
begin
  if Pos( '-', Licenca ) > 0 then
    try
      ValidReal := StrToInt( '$' + Copy( Licenca, Pos('-',Licenca)+1, Length( Licenca ) ) );
      Licenca := Copy( Licenca, 1, Pos( '-', Licenca ) - 1 );
    except
      ValidReal := 63;
    end;
  DC := 0;
  DecodeDate(Date, Ano, Mes, Dia);
  DiaMes := Format( '%.2d', [Dia + Mes] );
  while StrToInt( DiaMes ) >= 10 do
    DiaMes := IntToStr( StrToInt( DiaMes[1] ) + StrToInt( DiaMes[2] ) );
  Result := DiaMes + IntToStr( Validade + StrToInt( DiaMes ) ) + Format('%.2d',[Dia]) + Format('%.2d',[Mes]);
  for i:=1 to Length( Result ) do
  begin
    if ( i mod 2 ) <> 0 then
      ValorDC := StrToInt( Result[i] ) * 1
    else
      ValorDC := StrToInt( Result[i] ) * 2;
    DC := DC + StrToInt( Format('%.2d',[ValorDC] )[1] ) + StrToInt( Format('%.2d',[ValorDC])[2] );
  end;
  Result := Format( '%x', [ StrToInt( Result ) ] );
  Result := Result + '-' + Format('%.2d',[ ( DC ) mod 10 ]);
  Result := Format( '%x', [ StrToInt( Licenca + Copy( IntToStr(Ano),3,2 ) ) ] ) + '-' + Result;
  Result := Format( '%.3x', [ValidReal] ) + 'X-' + Result;
end;

function SoSerial( SerialFull: ShortString ): ShortString;
var
  PosValid: Byte;
begin
  PosValid := Pos( 'X-', SerialFull );
  if PosValid > 0 then
    Result := Copy( SerialFull, PosValid+2, Length( SerialFull ) )
  else
    Result := SerialFull
end;

function SoValidade( SerialFull: ShortString ): Integer;
var
  PosValid: Byte;
begin
  PosValid := Pos( 'X-', SerialFull );
  if PosValid > 0 then
    Result  := StrToInt( '$' + Copy( SerialFull, 1, PosValid-1 ) )
  else
    Result := 63;
end;

function Decrypt(const S: String): String;
begin
  Decrypt := Encrypt( 'D',  S );
end;

function Encrypt(Action, Src: String): String;
var
  KeyLen, KeyPos, OffSet, SrcPos, SrcAsc, TmpSrcAsc, Range: Integer;
  Dest, Key: String;
begin
  result := '';
  if Src <> '' then
  begin
    Key := '!@ab#$cs';
    Dest := '';
    KeyLen := Length(Key);
    KeyPos := 0;
    SrcPos := 0;
    SrcAsc := 0;
    Range := 256;
    if (UpperCase(Action) = 'C') then
    begin
      Randomize;
      OffSet := Random(Range);
      Dest := Format('%1.2x', [OffSet]);
      for SrcPos := 1 to Length(Src) do
      begin
        Application.ProcessMessages;
        SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
        if KeyPos < KeyLen then
          KeyPos := KeyPos + 1
        else
          KeyPos := 1;
        SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
        Dest := Dest + Format('%1.2x', [SrcAsc]);
        OffSet := SrcAsc;
      end;
    end
    else if (UpperCase(Action) = 'D') then
    begin
      OffSet := StrToInt('$' + copy(Src, 1, 2));
      SrcPos := 3;
      repeat
        SrcAsc := StrToInt('$' + copy(Src, SrcPos, 2));
        if (KeyPos < KeyLen) then
          KeyPos := KeyPos + 1
        else
          KeyPos := 1;
        TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
        if TmpSrcAsc <= OffSet then
          TmpSrcAsc := 255 + TmpSrcAsc - OffSet
        else
          TmpSrcAsc := TmpSrcAsc - OffSet;
        Dest := Dest + Chr(TmpSrcAsc);
        OffSet := SrcAsc;
        SrcPos := SrcPos + 2;
      until (SrcPos >= Length(Src));
    end;
    result := Dest;
  end;
end;



//********** rotinas de manutencao de array dinamicos ***************

function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: String): String; overload;
begin
  if Comparacao then result := Para_Verdadeiro
  else result := Para_Falso;
end;

function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: Integer): Integer; overload;
begin
  if Comparacao then
    result := Para_Verdadeiro
  else
    result := Para_Falso;
end;

function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: Extended): Extended; overload;
begin
  if Comparacao then result := Para_Verdadeiro
  else result := Para_Falso;
end;

function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: TDateTime): TDateTime; overload;
begin
  if Comparacao then result := Para_Verdadeiro
  else result := Para_Falso;
end;

function IIF( const Comparacao: Boolean; const Para_Verdadeiro, Para_Falso: Boolean): Boolean; overload;
begin
  if Comparacao then result := Para_Verdadeiro
  else result := Para_Falso;
end;

function Between(Valor, Inicio, Fim: Integer): Boolean; overload;
begin
  result := (Valor >= Inicio) and (Valor <= Fim);
end;

function Between(Valor, Inicio, Fim: Extended): Boolean; overload;
begin
  result := (Valor >= Inicio) and (Valor <= Fim);
end;

function Between(Valor, Inicio, Fim: TDateTime): Boolean; overload;
begin
  result := (Valor >= Inicio) and (Valor <= Fim);
end;

function Between(const Valor, Inicio, Fim: String): Boolean; overload;
begin
  result := (Valor >= Inicio) and (Valor <= Fim);
end;

function IncDinArray(var A: TStringArray): Integer; overload;
begin
  result := High(A) + 2;
  SetLength(A, result);
end;

function IncDinArray(var A: TIntegerArray): Integer; overload;
begin
  result := High(A) + 2;
  SetLength(A, result);
end;

{function IncDinArray(var A: TByteArray): Integer; overload;
begin
  result := High(A) + 2;
  SetLength(A, result);
end;}

function DinArrayAdd(var A: TStringArray; const S: String): Integer; overload;
begin
  result := IncDinArray(A) - 1;
  A[result] := S;
end;

function DinArrayAdd(var A: TIntegerArray; I: Integer): Integer; overload;
begin
  result := IncDinArray(A) - 1;
  A[result] := I;
end;

{function DinArrayAdd(var A: TByteArray; I: Byte): Integer; overload;
begin
  result := IncDinArray(A) - 1;
  A[result] := I;
end;}

function DinArrayFnd(const A: TStringArray; const S: String): Integer; overload;
var I: Integer;
begin
  result := -1;
  for I := 0 to High(A) do
    if A[I] = S then
    begin
      result := I;
      Break;
    end;
end;

function DinArrayFnd(const A: TIntegerArray; const I: Integer): Integer; overload;
var Y: Integer;
begin
  result := -1;
  for Y := 0 to High(A) do
    if A[Y] = I then
    begin
      result := Y;
      Break;
    end;
end;

{function DinArrayFnd(const A: TByteArray; I: Byte): Integer; overload;
var Y: Integer;
begin
  result := -1;
  for Y := 0 to High(A) do
    if A[Y] = I then
    begin
      result := Y;
      Break;
    end;
end;}

function Igual(const S1, S2: String): Boolean; overload;
begin
  result := CompareText(S1, S2) = 0;
end;

procedure FindFiles(const Filtro: String; var Retorno: TStringArray); overload;
var
  sr: TSearchRec;
begin
  SetLength(Retorno, 0);
  if FindFirst(Filtro, faAnyFile, sr) = 0 then
  begin
    if (sr.Attr and 16) = 0 then
      DinArrayAdd(Retorno, sr.Name);
    while FindNext(sr) = 0 do
      if (sr.Attr and 16) = 0 then
        DinArrayAdd(Retorno, sr.Name);
    SysUtils.FindClose(sr);
  end;
end;

procedure CopyF(const Source, Dest: String);
var
  FromF, ToF, Age: Integer;
  NumRead, NumWritten: Integer;
  Buf: array[1..4096] of Char;
begin
  FromF := FileOpen(Source, fmOpenRead);
  ToF := FileCreate(Dest);
  Age := FileGetDate(FromF);
  repeat
    NumRead := FileRead(FromF, Buf, SizeOf(Buf));
    NumWritten := FileWrite(ToF, Buf, NumRead);
  until (NumRead = 0) or (NumWritten <> NumRead);
  {$IFDEF LINUX}
    FileSetDate(Dest, Age);
  {$ELSE}
    FileSetDate(ToF, Age);
  {$ENDIF}
  FileClose(FromF);
  FileClose(ToF);
end;

procedure CopyDir(const Source, Dest: String);
var
  I: Integer;
  Lista: TStringArray;
begin
  FindFiles(Source + '*.*', Lista);
  for I := 0 to High(Lista) do
    CopyF(IncludeTrailingPathDelimiter(Source) + Lista[I], IncludeTrailingPathDelimiter(Dest) + Lista[I]);
end;

{
function Pergunta( Mens: String; BotaoDef: Integer = 0 ): Integer;
begin
  Result := Application.MessageBox( PChar( Mens ), 'Aviso', mb_IconQuestion+mb_YesNo+BotaoDef );
end;
}

function Pergunta( Mens: String; Botao2Def: Boolean = False ): Boolean;
//var
//  BotaoDef: Integer;
begin
//  if Botao2Def then
//    BotaoDef := mb_DefButton2
//  else
//    BotaoDef := 0;
//  Result := Application.MessageBox( PChar( Mens ), 'Aviso', mb_IconQuestion+mb_YesNo+BotaoDef )=idYes;
  Application.CreateForm(TfrmPergunta,frmPergunta);
  try
    frmPergunta.lblMensagem.Caption := Mens;
    if Botao2Def then
    begin
      frmPergunta.btnNao.Default  := True;
      frmPergunta.btnSim.Default  := False;
      frmPergunta.btnNao.TabOrder := 0;
      frmPergunta.btnSim.TabOrder := 1;
    end
    else
    begin
      frmPergunta.btnSim.Default := True;
      frmPergunta.btnNao.Default := False;
      frmPergunta.btnNao.TabOrder := 1;
      frmPergunta.btnSim.TabOrder := 0;
    end;
    Result := frmPergunta.ShowModal=mrOK;
  finally
    FreeAndNil( frmPergunta );
  end
end;

procedure Aviso( Mens: String );
begin
  Application.CreateForm(TfrmAviso,frmAviso);
  try
    frmAviso.lblMensagem.Caption := Mens;
    frmAviso.ShowModal;
  finally
    FreeAndNil( frmAviso );
  end
//  Application.MessageBox( PChar( Mens ), 'Aviso', mb_IconInformation );
end;

procedure Erro( Mens: String; Suporte: Boolean = False );
begin
  Application.CreateForm(TfrmErro, frmErro);
  try
    frmErro.lblMensagem.Caption := Mens;
    frmErro.ShowModal;
  finally
    FreeAndNil( frmErro );
  end
//  if Suporte then
//    Mens := Mens + #13#10 + SuporteABCS;
//  Application.MessageBox( PChar( Mens ), 'Aviso', mb_IconError );
end;

function ExtraiArg(const Args, Chr: string; var Pos: Integer): string;
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(Args)) and (Args[I] <> Chr) do
    Inc(I);
  Result := Copy(Args, Pos, I - Pos);
  if (I <= Length(Args)) and (Args[I] = Chr) then
    Inc(I);
  Pos := I;
end;

function ExtraiArgStr(const Args, Str: string; var Pos: Integer): string;
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(Args)) and not Igual(copy(Args, I, Length(Str)), Str) do
    Inc(I);
  Result := Copy(Args, Pos, I - Pos);
  if (I <= Length(Args)) and Igual(copy(Args, I, Length(Str)), Str) then
    Inc(I, Length(Str));
  Pos := I;
end;

procedure ExtraiArgsStr(const Args, Str: String; var ArgsRet: TStringArray);
var
  Pos: Integer;
begin
  SetLength(ArgsRet, 0);
  if Args = '' then Exit;
  Pos := 1;
  while Pos <= Length(Args) do
    DinArrayAdd(ArgsRet, ExtraiArgStr(Args, Str, Pos));
end;

{procedure ExtraiArgs(const Args, Chr: String; ArgsRet: TStrings);
var
  Pos: Integer;
begin
  ArgsRet.Clear;
  if Args = '' then Exit;
  Pos := 1;
  while Pos <= Length(Args) do
    ArgsRet.Append(ExtraiArg(Args, Chr, Pos));
end;}

{function PreLoader: Boolean;
var
  Arq, ArqLoc: String;
  ExeDir: String;
  ExeName: String; //nome do executavel

  procedure Executar(const FileName : String);
  begin
    ShellExecute(
    0,	// handle to parent window
    'open',	// pointer to string that specifies operation to perform
    PChar(FileName),	// pointer to filename or folder name string
    nil,	// pointer to string that specifies executable-file parameters
    PChar(ExeDir),	// pointer to string that specifies default directory
    SW_SHOW 	// whether file is shown when opened
    );
  end;

  procedure CopyF(const Source, Dest: String);
  var
    FromF, ToF, Age: Integer;
    NumRead, NumWritten: Integer;
    Buf: array[1..2048] of Char;
  begin
    if FileExists(Dest) then
      if not DeleteFile(PChar(Dest)) then
      begin
        Sleep(4000);
        if not DeleteFile(PChar(Dest)) then
          ShowMessage('Não foi possível remover o arquivo: ' + Dest);
      end;
    FromF := FileOpen(Source, fmShareDenyNone);
    if FromF = -1 then
    begin
      ShowMessage('Não foi possível ler o arquivo: ' + Source);
      Exit;
    end;
    ToF := FileCreate(Dest);
    if ToF = -1 then
    begin
      ShowMessage('Não foi possível criar o arquivo: ' + Dest);
      FileClose(FromF);
      Exit;
    end;
    Age := FileGetDate(FromF);
//    FAtualiza.Progresso.Max := FileSeek(FromF,0,2);
//    FAtualiza.Progresso.Position := 0;
    FileSeek(FromF,0,0);
    repeat
      NumRead := FileRead(FromF, Buf, SizeOf(Buf));
      NumWritten := FileWrite(ToF, Buf, NumRead);
//      FAtualiza.Progresso.Position := FAtualiza.Progresso.Position + NumRead;
    until (NumRead = 0) or (NumWritten <> NumRead);
    if FileSetDate(ToF, Age) <> 0 then
      ShowMessage('Não foi possível definir os atributos de data para o arquivo: ' + Dest);
    FileClose(FromF);
    FileClose(ToF);
  end;

  procedure Copia(const Fonte, Destino: String);
  begin
    Application.ProcessMessages;
    CopyF(Fonte, Destino);
  end;

begin
  Result  := False;
  ExeName := ExtractFileName(Application.ExeName); //Recebe o nome do executavel
  ExeDir  := ExtractFilePath(Application.ExeName);
  Arq     := AnsiReplaceText(ExeName, 'New', '');
  ArqLoc  := ExeDir + 'Updates\';

  if DirectoryExists( ArqLoc ) then
  begin
    if AnsiUpperCase( ExeName) = AnsiUpperCase( Arq) then
    begin
      DeleteFile(pChar(ExeDir + 'New' + Arq));
      if FileExists(ArqLoc + Arq) then
      begin
        if FileAge(ArqLoc + Arq) <> FileAge(ExeDir + Arq) then
        begin
          Copia(ArqLoc + Arq, ExeDir + 'New' + Arq);
          Application.Terminate;
          if FileExists(ArqLoc + 'PrmComct.bpl') then
            Copia(ArqLoc + 'PrmComct.bpl', ExeDir + 'PrmComct.bpl');
          if FileExists(ArqLoc + 'DlpComct.bpl') then
            Copia(ArqLoc + 'DlpComct.bpl', ExeDir + 'DlpComct.bpl');
          CopyDir(ArqLoc + 'Plugins\', ExeDir + 'Plugins');
          Executar(ExeDir + 'New' + Arq);
          Exit;
        end;
      end
      else
      begin
//        ShowMessage('Não foi possível conectar a ' + ArqLoc);
        Exit;
      end;
    end else If AnsiUpperCase( ExeName) = 'NEW' + AnsiUpperCase( Arq) then
    begin
      Copia(ExeDir + 'NEW' + Arq, ExeDir + Arq);
//      Copia(ArqLoc + 'PrmComct.bpl', ExeDir + 'New' + 'PrmComct.bpl');
//      Copia(ArqLoc + 'DlpComct.bpl', ExeDir + 'New' + 'DlpComct.bpl');
      result := True;
    end;
  end;
end;

procedure Executar;
var FileName, ExeDir: String;
begin
  FileName:=ExtractFileName(application.ExeName); //Recebe o nome do executavel
  ExeDir := ExtractFilePath(Application.ExeName);
  if AnsiUpperCase( Copy(FileName,1,3)) = 'NEW' then
    FileName:= Copy(FileName, 4, Length(FileName));
  ShellExecute(
  0,	// handle to parent window
  'open',	// pointer to string that specifies operation to perform
  PChar(FileName),	// pointer to filename or folder name string
  nil,	// pointer to string that specifies executable-file parameters
  PChar(ExeDir),	// pointer to string that specifies default directory
  SW_SHOW 	// whether file is shown when opened
  );
end;}

procedure ExibeFoto(DataSet : TDataSet; BlobFieldName : String; ImageExibicao : TImage);
var
  BlobStream : TStream;
  JpegImage : TJPEGImage;
  bitmap:TBitMap;
begin
  BlobStream := DataSet.CreateBlobStream(DataSet.FieldByname(BlobFieldName), bmRead);
  if BlobStream.Size <> 0 then
  begin
    JpegImage  := TJPEGImage.Create;
    try
      JpegImage.LoadFromStream(BlobStream);
      ImageExibicao.Picture.Assign(JpegImage);
      ImageExibicao.Center:=true;
    finally
      BlobStream.Free;
      JpegImage.Free;
    end;
  end
  else
  begin
    Bitmap:=TBitMap.Create;
    Try
      Bitmap.Width:=1;
      Bitmap.Height:=1;
      ImageExibicao.Picture.Assign(BitMap);
      ImageExibicao.Center:=false;
    finally
      Bitmap.Free;
      BlobStream.Free;
    end;
  end;
end;

procedure GravaFoto(DataSet : TDataSet; BlobFieldName, FileName : String);
var
  ext : string;
  JpegImage : TJPEGImage;
  bitmap:TBitMap;
begin
  if (DataSet.State in [dsEdit,dsInsert]) then
  begin
    ext := UpperCase(ExtractFileExt(FileName));
    if (ext <> '.BMP') and (ext <> '.JPG') and (ext <> '.JPEG') then
    begin
      raise EAccessViolation.Create('Formato de imagem não suportado! Formato suportado: Jpeg ou Bitmap');
      Abort;
    end;
    JpegImage := TJpegImage.Create;
    Bitmap := TBitmap.Create;
    try
      if (ext = '.BMP') then
      begin
        Bitmap.LoadFromFile(FileName);
        JpegImage.Assign(Bitmap);
        JpegImage.Compress;
      end
      else
      begin
          JpegImage.LoadFromFile(FileName);
      end;
      JpegImage.SaveToFile('FIGURA.JPG');
      (DataSet.FieldByName(BlobFieldName) as TBlobField).LoadFromFile('FIGURA.JPG');
    finally
      Bitmap.Free;
      JpegImage.Free;
    end;
  end;
end;

procedure ExcluiFoto(DataSet : TDataSet; BlobFieldName : String;ImageExibicao : TImage);
var
  bitmap:TBitMap;
begin
  if (DataSet.State in [dsEdit,dsInsert]) and not((DataSet.FieldByName(BlobFieldName) as TBlobField).IsNull) then
  begin
    (DataSet.FieldByName(BlobFieldName) as TBlobField).Clear; // para limpar o TImage use // Image1.Picture := Nil;
    Bitmap:=TBitMap.Create;
    try
      Bitmap.Width:=1;
      Bitmap.Height:=1;
      ImageExibicao.Picture.Assign(BitMap);
      ImageExibicao.Center:=false;
    finally
      Bitmap.Free;
    end;
  end;
end;

procedure ExportaFoto(DataSet : TDataSet; BlobFieldName, FileName : string; TipoImagem : TTipoImagem);
begin
    // SERÁ IMPLEMENTADO FUTURAMENTE // ME FALTA TEMPO :)

end;

function ColocaFiltro( const SQLOrig, Where: WideString ): WideString;
var
  GroupOrder, SQLAux, Aux: String;
begin
  if Trim( Where ) <> '' then
  begin
//    SQLOrig := UpperCase( SQLOrig );
    if Pos( 'GROUP BY', UpperCase( SQLOrig ) ) > 0 then
      Aux := 'GROUP BY'
    else if Pos( 'ORDER BY', UpperCase( SQLOrig ) ) > 0 then
      Aux := 'ORDER BY'
    else
      Aux := '';
    if Aux <> '' then
    begin
      SQLAux := Copy( SQLOrig, 1, Pos( Aux, UpperCase( SQLOrig ) )-1 );
      GroupOrder := Copy( SQLOrig, Pos( Aux, UpperCase( SQLOrig ) ), Length( SQLOrig ) );
    end
    else
    begin
      SQLAux := SQLOrig;
      GroupOrder := '';
    end;
    if Pos('WHERE',UpperCase( SQLOrig ) ) > 0 then
      SQLAux := SQLAux + ' AND '
    else
      SQLAux := SQLAux + ' WHERE ';
    Result := SQLAux + Where + ' ' + GroupOrder;
  end
  else
    Result := SQLOrig;
end;

procedure FreeObjects(const strings: TStrings) ;
var
  i: integer;
  o: TObject;
begin
  for i := 0 to Pred(strings.Count) do
  begin
    o := strings.Objects[i];
    FreeAndNil(o) ;
  end;
end;

function Arredondar( const Valor: Single; CasasDec: Byte ): Single;
begin
  Result := RoundTo( Valor, CasasDec * -1 );
end;

function NomeTecla(Key: Word; Shift: TShiftState):string;
begin
   if (ssShift in Shift) then
      result := 'SHIFT+';
   if (ssCtrl in Shift) then
      result := result + 'CTRL+';
   if (ssAlt in Shift) then
      result := result + 'ALT+';

   if ( key in [VK_F1,VK_F2,VK_F3,VK_F4,VK_F5,VK_F6,VK_F7,VK_F8,VK_F9,VK_F10,VK_F11,123] ) or
      ( (key >= 65) and (Key <= 90) ) or
      ( (key >= 48) and (Key <= 57) ) then
   begin //123 Para o F12, se usar VK_F12 não funciona
     if key = 27 then
       result := result + 'ESC'
     else if key = VK_F1 then
       result := result + 'F1'
     else if key = VK_F2 then
       result := result + 'F2'
     else if key = VK_F3 then
       result := result + 'F3'
     else if key = VK_F4 then
       result := result + 'F4'
     else if key = VK_F5 then
       result := result + 'F5'
     else if key = VK_F6 then
       result := result + 'F6'
     else if key = VK_F7 then
       result := result + 'F7'
     else if key = VK_F8 then
       result := result + 'F8'
     else if key = VK_F9 then
       result := result + 'F9'
     else if key = VK_F10 then
       result := result + 'F10'
     else if key = VK_F11 then
       result := result + 'F11'
     else if key = VK_F12 then
       result := result + 'F12'
     else if (key >= 65) and (Key <= 90) then
       result := result + chr(Key)
     else if (key >= 48) and (Key <= 57) then
       result := result + 'NUM ' + chr(Key)
     else
       result := '';
  end
  else
    result := '';
end;

function FMonta_EAN(CodEAN13: String): String;
//Var A,DV : Integer;
begin
{
  //////Coloco o '2' na FRENTE para ser igual a padrão da barra interna dos produtos...
  CodEAN13 := '2' + PadR(Trim(CodEAN13),11,'0');

  if not StrIsNumber( CodEAN13 ) then
     exit;

  DV := 0;
  For A := 12 downto 1 do
     DV := DV + (StrToInt( CodEAN13[A] ) * IfThen(odd(A),1,3));

  DV := (Ceil( DV / 10 ) * 10) - DV;

  Result := CodEAN13 + IntToStr( DV );
}
end;

function PosicaoVetor(sTexto:string;aVetor:array of string):integer;
var
  i:integer;
begin
  result := - 1;
  for i:=0 to length(aVetor)-1 do
    if aVetor[i] = sTexto then
      result := i;
end;

function HexToTColor(sColor : string) : TColor;
begin
   Result := RGB(StrToInt('$'+Copy(sColor, 1, 2)), StrToInt('$'+Copy(sColor, 3, 2)), StrToInt('$'+Copy(sColor, 5, 2)));
end;

function VersaoWin: TWinVer;
var
  KernelVersionHi: DWORD;
  Kernel32FileName: string;
  VerFixedFileInfo: TVSFixedFileInfo;

  function GetModulePath(const Module: HMODULE): string;
  var
    L: Integer;
  begin
    L := MAX_PATH + 1;
    SetLength(Result, L);
    L := Windows.GetModuleFileName(Module, Pointer(Result), L);
    SetLength(Result, L);
  end;

  function VersionFixedFileInfo(const FileName: string; var FixedInfo: TVSFixedFileInfo): Boolean;
  var
    Size, FixInfoLen: DWORD;
    Handle: THandle;
    Buffer: string;
    FixInfoBuf: PVSFixedFileInfo;
  begin
    Result := False;
    //Size := GetFileVersionInfoSize(PChar(FileName), Handle);
    if Size > 0 then
    begin
      SetLength(Buffer, Size);
      if GetFileVersionInfo(PChar(FileName), Handle, Size, Pointer(Buffer)) and
        VerQueryValue(Pointer(Buffer), '\', Pointer(FixInfoBuf), FixInfoLen) and
        (FixInfoLen = SizeOf(TVSFixedFileInfo)) then
      begin
        Result := True;
        FixedInfo := FixInfoBuf^;
      end;
    end;
  end;

begin
  Kernel32FileName := GetModulePath(GetModuleHandle(kernel32));
  if ( Win32Platform <> VER_PLATFORM_WIN32_NT ) and VersionFixedFileInfo(Kernel32FileName, VerFixedFileInfo) then
    KernelVersionHi := VerFixedFileInfo.dwProductVersionMS
  else
    KernelVersionHi := 0;

  Result := wvUnknown;
  case Win32Platform of
    VER_PLATFORM_WIN32_WINDOWS:
      case Win32MinorVersion of
        0..9:
          if Trim(Win32CSDVersion) = 'B' then
            Result := wvWin95OSR2
          else
            Result := wvWin95;
        10..89:
          // On Windows ME Win32MinorVersion can be 10 (indicating Windows 98
          // under certain circumstances (image name is setup.exe). Checking
          // the kernel version is one way of working around that.
          if KernelVersionHi = $0004005A then // 4.90.x.x
            Result := wvWinME
          else
          if Trim(Win32CSDVersion) = 'A' then
            Result := wvWin98SE
          else
            Result := wvWin98;
        90:
          Result := wvWinME;
      end;
    VER_PLATFORM_WIN32_NT:
      case Win32MajorVersion of
        3:
          case Win32MinorVersion of
            1:
              Result := wvWinNT31;
            5:
              Result := wvWinNT35;
            51:
              Result := wvWinNT351;
          end;
        4:
          Result := wvWinNT4;
        5:
          case Win32MinorVersion of
            0:
              Result := wvWin2000;
            1:
              Result := wvWinXP;
          end;
      end;
  end;
end;

//Função interna utilizada para desabilitar as teclas de função do windows
//Desabilita Alt+Tab, Win, Win+E, Ctrl+Esc
function LowLevelHookProc(nCode:Integer; awParam: WPARAM; alParam:LPARAM): LRESULT; stdcall;
var
  ControlPressed, AltPressed, EscapePressed, WinPressed, TabPressed: boolean;
  pkbhs: PKBDLLHOOKSTRUCT;
  FilterThis: boolean;
begin
  FilterThis := false;
  if nCode = HC_ACTION then
  begin
    pkbhs := PKBDLLHOOKSTRUCT(alParam);

    ControlPressed := (GetAsyncKeyState(VK_CONTROL) and $8000) <> 0;
    AltPressed := ((pkbhs^.flags and LLKHF_ALTDOWN)<>0);
    EscapePressed := (pkbhs^.vkCode = VK_ESCAPE);
    WinPressed := (pkbhs^.vkCode in [VK_LWIN, VK_RWIN]);
    TabPressed := (pkbhs^.vkCode = VK_TAB);

    // Disable WINDOWS Key
    if WinPressed then
      FilterThis := true
    else
      // Disable CTRL+ESC
      if ControlPressed and EscapePressed then
        FilterThis := true
      else
        // Disable ALT+TAB
        if AltPressed and TabPressed then
          FilterThis := true
        else
          // Disable ALT+ESC
          if AltPressed and EscapePressed then
            FilterThis := true;
  end;
  if not FilterThis then
    Result:= CallNextHookEx (OldHook, nCode, awParam, alParam)
  else
    Result := 1;
end;

procedure HabDesTeclasWin( Habilita: Boolean );
var
  OldValue : LongBool;
  WinXP2000: Boolean;
begin
  case VersaoWin of
    wvWin2000:   WinXP2000 := True;
    wvWinXP:     WinXP2000 := True;
    else         WinXP2000 := False;
  end;
  if WinXP2000 then
  begin
    if not Habilita then
      OldHook := SetWindowsHookEx(WH_Keyboard_LL, LowLevelHookProc, HInstance, 0)
    else
      UnHookWindowsHookEx(OldHook);
  end
  else
    SystemParametersInfo(97, Word(not Habilita), @OldValue, 0);
end;

end.
