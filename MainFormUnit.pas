unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Samples.Spin,
  DirSearchUnit;

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
    lblCurrentThreadStat: TLabel;
    shMainLog: TTabSheet;
    FileOpenDialog: TFileOpenDialog;
    StringGrid: TStringGrid;
    procedure btnSelectFolderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnApplyThreadsCountClick(Sender: TObject);
    procedure btnStartSearchClick(Sender: TObject);
    procedure btnCancelSearchClick(Sender: TObject);
  private
    FFilePath: string;
    ThreadManager: TTreadManager;
    procedure SetFilePat(const Value: string);
    procedure UpdateThreadsCount(ThreadCount: integer);
    procedure UpdateGlobalList(Sender: TThread; PathList: TStringList);
    { Private declarations }
  public
    { Public declarations }
    Property FilePath: string read FFilePath write SetFilePat;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnApplyThreadsCountClick(Sender: TObject);
begin
  ThreadManager.ThreadCount := speThreads.Value;
end;

procedure TMainForm.btnCancelSearchClick(Sender: TObject);
begin
  ThreadManager.Searhing := False;
end;

procedure TMainForm.btnSelectFolderClick(Sender: TObject);
begin
  if FileOpenDialog.Execute(Self.Handle) then
    FilePath := FileOpenDialog.FileName;
end;

procedure TMainForm.btnStartSearchClick(Sender: TObject);
begin
  StringGrid.RowCount := 0;

  ThreadManager.path := edtFilePath.Text;
  ThreadManager.Searhing := True;
  ThreadManager.mask := edtFileMask.Text;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin


  ThreadManager := TTreadManager.Create(True);
  ThreadManager.FreeOnTerminate := True;
  ThreadManager.OnUpdateThreadscount := UpdateThreadsCount;
  ThreadManager.OnGlobalListUpdate := UpdateGlobalList;
  ThreadManager.ThreadCount := speThreads.Value;
  ThreadManager.Start;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ThreadManager.Terminate;
end;

procedure TMainForm.SetFilePat(const Value: string);
begin
  FFilePath := Value;
  edtFilePath.Text := Value;
end;

procedure TMainForm.UpdateGlobalList(Sender: TThread; PathList: TStringList);
var
  str, buff: string;
  i: integer;
begin
  for str in PathList do
  begin
    StringGrid.RowCount := StringGrid.RowCount + 1;
    buff := '';
    for i := 1 to str.Length do
      if str[i] = '|' then
      begin
        StringGrid.Cells[1,StringGrid.RowCount ] := Copy(str, i+1, str.Length - i);
        break;
      end else
        buff := buff + str[i];

      StringGrid.Cells[0,StringGrid.RowCount ] := buff;
  end;
end;

procedure TMainForm.UpdateThreadsCount(ThreadCount: integer);
begin
  lblCurrentThreadStat.Caption := 'Current threads in use: ' + ThreadCount.ToString;
end;

end.
