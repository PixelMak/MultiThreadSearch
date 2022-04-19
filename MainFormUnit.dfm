object MainForm: TMainForm
  Left = 411
  Top = 154
  Caption = 'Multy Thread Search App'
  ClientHeight = 636
  ClientWidth = 972
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = 18
  Font.Name = 'Verdana'
  Font.Style = []
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 18
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 972
    Height = 77
    Align = alTop
    TabOrder = 0
    DesignSize = (
      972
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
      Left = 121
      Top = 39
      Width = 842
      Height = 26
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 478
    Width = 972
    Height = 158
    Align = alBottom
    Caption = 'BottomPanel'
    TabOrder = 1
    ExplicitTop = 376
    ExplicitWidth = 885
    object pcThreadsLog: TPageControl
      Left = 1
      Top = 1
      Width = 970
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
    Left = 752
    Top = 77
    Width = 220
    Height = 401
    Align = alRight
    TabOrder = 2
    ExplicitTop = 65
    ExplicitHeight = 413
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
    end
    object speThreads: TSpinEdit
      Left = 6
      Top = 131
      Width = 99
      Height = 26
      MaxValue = 10000
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
    object btnStartSearch: TButton
      Left = 6
      Top = 62
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 2
    end
    object edtFileMask: TEdit
      Left = 6
      Top = 30
      Width = 203
      Height = 26
      TabOrder = 3
    end
    object btnCancelSearch: TButton
      Left = 134
      Top = 62
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 4
    end
  end
  object MiddlePanel: TPanel
    Left = 0
    Top = 77
    Width = 752
    Height = 401
    Align = alClient
    TabOrder = 3
    ExplicitLeft = 825
    ExplicitTop = 49
    ExplicitWidth = 41
    ExplicitHeight = 452
    object StatsPanel: TPanel
      Left = 1
      Top = 1
      Width = 750
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
    object GridData: TDBGrid
      Left = 1
      Top = 33
      Width = 750
      Height = 367
      Align = alClient
      DataSource = DataSource
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = 18
      TitleFont.Name = 'Verdana'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'FileName'
          Title.Alignment = taCenter
          Title.Caption = 'File Name'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FilePath'
          Title.Alignment = taCenter
          Title.Caption = 'Full Path'
          Width = 524
          Visible = True
        end>
    end
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 592
    Top = 157
  end
  object ClientDataSet: TClientDataSet
    PersistDataPacket.Data = {
      540000009619E0BD01000000180000000200000000000300000054000846696C
      654E616D6501004900000001000557494454480200020014000846696C655061
      746801004900000001000557494454480200020014000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 680
    Top = 157
    object ClientDataSetFileName: TStringField
      FieldName = 'FileName'
    end
    object ClientDataSetFilePath: TStringField
      FieldName = 'FilePath'
    end
  end
  object FileOpenDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 272
  end
end
