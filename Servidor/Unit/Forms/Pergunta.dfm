object frmPergunta: TfrmPergunta
  Left = 565
  Top = 226
  BorderStyle = bsToolWindow
  Caption = 'Pergunta'
  ClientHeight = 112
  ClientWidth = 225
  Color = 14474460
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object lblMensagem: TLabel
    Left = 77
    Top = 16
    Width = 79
    Height = 17
    Caption = 'lblMensagem'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object btnNao: TBitBtn
    Left = 112
    Top = 72
    Width = 89
    Height = 25
    Caption = 'N'#227'o'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 0
  end
  object btnSim: TBitBtn
    Left = 16
    Top = 72
    Width = 90
    Height = 25
    Caption = 'Sim'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Kind = bkOK
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
  end
end
