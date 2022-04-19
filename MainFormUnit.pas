unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TMainForm = class(TForm)
    TopPanel: TPanel;
    BottomPanel: TPanel;
    RightPanel: TPanel;
    MiddlePanel: TPanel;
    StatsPanel: TPanel;
    pcThreadsLog: TPageControl;
    btnApplyThreadsCount: TButton;
    lblThreadsCount: TLabel;
    speThreads: TSpinEdit;
    btnSelectFolder: TButton;
    btnStartSearch: TButton;
    edtFilePath: TEdit;
    lblFilePath: TLabel;
    edtFileMask: TEdit;
    lblFileMask: TLabel;
    btnCancelSearch: TButton;
    GridData: TDBGrid;
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;
    ClientDataSetFileName: TStringField;
    ClientDataSetFilePath: TStringField;
    lblCurrentThreadStat: TLabel;
    shMainLog: TTabSheet;
    FileOpenDialog: TFileOpenDialog;
    procedure btnSelectFolderClick(Sender: TObject);
  private
    FFilePath: string;
    procedure SetFilePat(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    Property FilePath: string read FFilePath write SetFilePat;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnSelectFolderClick(Sender: TObject);
begin
  if FileOpenDialog.Execute(Self.Handle) then
    FilePath := FileOpenDialog.FileName;
end;

procedure TMainForm.SetFilePat(const Value: string);
begin
  FFilePath := Value;
  edtFilePath.Text := Value;
end;

end.
