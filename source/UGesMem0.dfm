object frmGesMem: TfrmGesMem
  Left = 234
  Top = 105
  Width = 544
  Height = 497
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'GESTION DE MEMOIRE"ALGORITHME SECONDE CHANCE"'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 192
    Top = 280
    Width = 5
    Height = 19
  end
  object Label3: TLabel
    Left = 189
    Top = 208
    Width = 5
    Height = 19
  end
  object Label2: TLabel
    Left = 176
    Top = 200
    Width = 44
    Height = 19
    Caption = '&Taille:'
    FocusControl = Edit2
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 40
    Top = 200
    Width = 62
    Height = 19
    Caption = '&Adresse:'
    FocusControl = Edit1
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 160
    Width = 26
    Height = 19
    Caption = 'DP:'
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object btnAjouter: TButton
    Left = 40
    Top = 264
    Width = 129
    Height = 33
    Caption = 'A&jouter'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TabStop = False
    OnClick = btnAjouterClick
  end
  object btnFixer: TButton
    Left = 176
    Top = 264
    Width = 129
    Height = 33
    Caption = '&Fixer'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TabStop = False
    OnClick = btnFixerClick
  end
  object Edit1: TEdit
    Left = 40
    Top = 224
    Width = 129
    Height = 27
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 176
    Top = 224
    Width = 129
    Height = 27
    TabOrder = 2
    OnKeyPress = Edit2KeyPress
  end
  object btnFermer: TBitBtn
    Left = 416
    Top = 424
    Width = 113
    Height = 33
    Caption = 'F&ermer'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = btnFermerClick
    Kind = bkClose
  end
  object btnSimuler: TButton
    Left = 312
    Top = 264
    Width = 105
    Height = 33
    Caption = '&Simuler'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnSimulerClick
  end
  object gbResultats: TGroupBox
    Left = 40
    Top = 312
    Width = 489
    Height = 105
    Caption = 'R'#233'sultas'
    TabOrder = 6
    object SgDP: TStringGrid
      Left = 8
      Top = 24
      Width = 473
      Height = 57
      TabStop = False
      ColCount = 10
      DefaultColWidth = 45
      FixedCols = 0
      RowCount = 2
      TabOrder = 0
    end
  end
  object btnInitialiser: TButton
    Left = 424
    Top = 264
    Width = 105
    Height = 33
    Caption = '&Initialiser'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnInitialiserClick
  end
  object btnGraph: TBitBtn
    Left = 160
    Top = 424
    Width = 249
    Height = 33
    Caption = '&Repr'#233'sentation Graphique'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 424
    Width = 113
    Height = 33
    Caption = 'Repren&dre'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = BitBtn1Click
  end
  object GroupBox1: TGroupBox
    Left = 40
    Top = 8
    Width = 489
    Height = 185
    Caption = 'Etat de la m'#233'moire'
    TabOrder = 10
    object St1: TStringGrid
      Left = 8
      Top = 24
      Width = 473
      Height = 153
      TabStop = False
      ColCount = 10
      DefaultColWidth = 45
      FixedCols = 0
      RowCount = 6
      FixedRows = 2
      TabOrder = 0
    end
  end
end
