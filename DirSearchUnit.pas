unit DirSearchUnit;

{
sources:
https://delphisources.ru/pages/faq/base/recursion_dir_class.html
}

interface

uses
  System.SysUtils, Classes, masks;

type
  PUpdateThreadsCount = procedure(ThreadCount: integer) of object;
  PNewDir = procedure(Sender: TThread; Dir: string; deep: integer; Out KeepSearch: boolean) of object;
  PThreadEnd = procedure(Sender: TThread; PathList: TStringList) of object;
  PGlobalListUpdate = procedure(Sender: TThread; PathList: TStringList) of object;

  //Менеджер для управления потоками
  //Поток сообщает менеджеру, если нашёл дирректорию
  //Менеджер отвечает созданием потока, если есть свободные
  //                                    если нет свободных, то продолжить выполнение
  //Если поток завершился, то менеджер освобождает место для нового
  TTreadManager = class(TThread)
    private
      FThreadCount: integer;       //Количество доступных потоков
      FActiveThreadCount: integer; //Количество активных потоков
      FSearhing: boolean;          //Статус, если True, то идёт поиск
      FThreadList: TList;          //Список со ссылками на все потоки
      FLock: TMultiReadExclusiveWriteSynchronizer;
      FPath: string;
      FGlobalListBuffer: TStringList;
      Fmask: string;
      procedure SetSearhing(const Value: boolean);
    public
      property ThreadCount: integer read FThreadCount write FThreadCount default 1;
      property Searhing: boolean read FSearhing write SetSearhing;
      property path: string read FPath write FPath;
      property mask: string read Fmask write Fmask;
      procedure Execute; override;

      procedure DropResults;
      procedure UpdateIndicators;
      procedure NewDir(Sender: TThread; Dir: string; deep: integer; Out KeepSearch: boolean);
      procedure EndOfThread(Sender: TThread; PathList: TStringList);
      procedure CreateNewThread(Dir: string; deep: integer);
      procedure UpdateInterfaceList;
    public
      OnUpdateThreadscount: PUpdateThreadsCount;
      OnGlobalListUpdate: PGlobalListUpdate;
  end;

  TDirSearch = class(TThread)
    private
      FPath: string;
      currName: string;
      threadNum: integer;
      FDirList: TStringList;
      Fdeep: integer;
      Fmask: string;
      procedure FindNextDir(dir: string; deep: integer);
      procedure Stat;
    public
      procedure Search(dir: string; mask: string);
      procedure Execute; override;

      property path: string read FPath write FPath;
      property deep: integer read Fdeep write Fdeep;
      property mask: string read Fmask write Fmask;
    public
      OnNewDir: PNewDir;
      OnThreadEnd: PThreadEnd;
  end;

implementation

{ TDirSearch }

procedure TDirSearch.Execute;
begin
  inherited;
  FDirList := TStringList.Create;
  Search('','');

  if @OnThreadEnd <> nil then
    OnThreadEnd(Self, FDirList);
end;

procedure TDirSearch.FindNextDir(dir: string; deep: integer);
var
  F: TSearchRec;
  R: Integer;
  search: TDirSearch;
  KeepSearch: boolean;
  str: string;
begin
  if deep > 512 then
    raise Exception.Create('Max deep of dir!');

  R := FindFirst(dir + '*.*', faAnyFile, F);
  while R = 0 do
  begin
    currName := F.Name;

    
    if MatchesMask(F.Name, mask) then
    begin
      str := F.Name + '|' + dir + F.Name;
      FDirList.Add(str);
    end;

    if (F.Attr and faDirectory <> 0)
      and (F.Name <> '.') and (F.Name <> '..')
       then
      begin
      OnNewDir(self, dir + F.Name + '\', deep + 1, KeepSearch);

      if KeepSearch then
        FindNextDir(dir + F.Name + '\', deep + 1);

      end;
    R := FindNext(F);
  end;
  FindClose(F);
end;

procedure TDirSearch.Search(dir, mask: string);
begin
  FindNextDir(path,deep);
end;

procedure TDirSearch.Stat;
begin

end;

{ TTreadManager }

procedure TTreadManager.CreateNewThread(Dir: string; deep: integer);
var
  search: TDirSearch;
begin
  FLock.BeginWrite;
  try
    Inc(FActiveThreadCount);
    search := TDirSearch.Create(True);
    search.Priority := tpNormal;
    search.path := dir;
    search.deep := deep;
    search.OnThreadEnd := EndOfThread;
    search.OnNewDir := NewDir;
    search.mask := mask;
    search.Start;

  finally
    FLock.EndWrite;
  end;
end;

procedure TTreadManager.DropResults;
begin

end;

procedure TTreadManager.EndOfThread(Sender: TThread; PathList: TStringList);
var
  str: string;
begin
  Sleep(10);
  FLock.BeginWrite;
  try
    Dec(FActiveThreadCount);
    if FActiveThreadCount = 0 then
      FSearhing := False;

      for str in PathList do
        FGlobalListBuffer.Add(str); 
  finally
    FLock.EndWrite;
  end;
end;

procedure TTreadManager.Execute;
var
  UpdateCntr: integer;
begin
  inherited;
  FThreadList := TList.Create;
  FGlobalListBuffer := TStringList.Create;
  FLock := TMultiReadExclusiveWriteSynchronizer.Create;

  while not Terminated do
  try
    if FSearhing then
    begin
      if FActiveThreadCount = 0 then
        CreateNewThread(path, 0);
      Sleep(100);
    end else
      Sleep(100);

    
    inc(UpdateCntr);
    if UpdateCntr = 6 then
    begin
      Synchronize(UpdateIndicators);
      Synchronize(UpdateInterfaceList);
      UpdateCntr := 0;
    end;
  except
    DropResults;
    raise Exception.Create('Thread manager got Error');
  end;

  DropResults;
end;

procedure TTreadManager.NewDir(Sender: TThread; Dir: string; deep: integer; Out KeepSearch: boolean);
begin
  FLock.BeginWrite;
  try
    KeepSearch := False;

    if FActiveThreadCount < FThreadCount then
      CreateNewThread(Dir, deep)
    else
      KeepSearch := True;
  finally
     FLock.EndWrite;
  end;
end;

procedure TTreadManager.SetSearhing(const Value: boolean);
begin
  if Value then
    DropResults;

  FSearhing := Value;
end;

procedure TTreadManager.UpdateIndicators;
begin
  OnUpdateThreadscount(FActiveThreadCount);
end;

procedure TTreadManager.UpdateInterfaceList;
begin
  OnGlobalListUpdate(Self, FGlobalListBuffer);
  FGlobalListBuffer.Clear;
end;

end.
