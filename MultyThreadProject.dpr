program MultyThreadProject;

uses
  Vcl.Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  DirSearchUnit in 'DirSearchUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
