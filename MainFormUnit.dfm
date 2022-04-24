object MainForm: TMainForm
  Left = 411
  Top = 154
  Caption = 'Multy Thread Search App'
  ClientHeight = 636
  ClientWidth = 1050
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = 18
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 18
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 1050
    Height = 77
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1050
      77)
    object lblFilePath: TLabel
      Left = 13
      Top = 42
      Width = 94
      Height = 18
      Caption = 'Current Path'
    end
    object btnSelectFolder: TButton
      Left = 13
      Top = 8
      Width = 164
      Height = 25
      Caption = 'Select Folder'
      TabOrder = 0
      OnClick = btnSelectFolderClick
    end
    object edtFilePath: TEdit
      Left = 113
      Top = 39
      Width = 920
      Height = 26
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 'D:\ThreadsTest\'
    end
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 478
    Width = 1050
    Height = 158
    Align = alBottom
    Caption = 'BottomPanel'
    TabOrder = 1
    Visible = False
    object pcThreadsLog: TPageControl
      Left = 1
      Top = 1
      Width = 1048
      Height = 156
      ActivePage = shMainLog
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object shMainLog: TTabSheet
        Caption = 'shMainLog'
      end
    end
  end
  object RightPanel: TPanel
    Left = 830
    Top = 77
    Width = 220
    Height = 401
    Align = alRight
    TabOrder = 2
    object lblThreadsCount: TLabel
      Left = 6
      Top = 110
      Width = 204
      Height = 18
      Caption = 'Chose the count of threads'
    end
    object lblFileMask: TLabel
      Left = 5
      Top = 6
      Width = 110
      Height = 18
      Caption = 'Filename Mask'
    end
    object btnApplyThreadsCount: TButton
      Left = 5
      Top = 159
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 0
      OnClick = btnApplyThreadsCountClick
    end
    object speThreads: TSpinEdit
      Left = 6
      Top = 131
      Width = 99
      Height = 28
      MaxValue = 10000
      MinValue = 1
      TabOrder = 1
      Value = 5
    end
    object btnStartSearch: TButton
      Left = 6
      Top = 62
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 2
      OnClick = btnStartSearchClick
    end
    object edtFileMask: TEdit
      Left = 6
      Top = 30
      Width = 203
      Height = 26
      TabOrder = 3
      Text = '*.txt'
    end
    object btnCancelSearch: TButton
      Left = 134
      Top = 62
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
      OnClick = btnCancelSearchClick
    end
  end
  object MiddlePanel: TPanel
    Left = 0
    Top = 77
    Width = 830
    Height = 401
    Align = alClient
    TabOrder = 3
    object StatsPanel: TPanel
      Left = 1
      Top = 1
      Width = 828
      Height = 32
      Align = alTop
      TabOrder = 0
      object lblCurrentThreadStat: TLabel
        Left = 12
        Top = 5
        Width = 172
        Height = 18
        Caption = 'Current threads in use:'
      end
    end
    object StringGrid: TStringGrid
      Left = 1
      Top = 33
      Width = 828
      Height = 367
      Align = alClient
      ColCount = 2
      FixedCols = 0
      RowCount = 3
      TabOrder = 1
      ColWidths = (
        251
        567)
      RowHeights = (
        24
        24
        24)
    end
  end
  object FileOpenDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 272
  end
end
