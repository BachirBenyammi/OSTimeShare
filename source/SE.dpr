program SE;

uses
  Forms,
  UMain in 'UMain.pas' {MainF},
  UGraphe in 'UGraphe.pas' {FrmGraphe},
  UMainFrm in 'UMainFrm.pas' {MainForm},
  USession in 'USession.pas' {FrmSession},
  UUsers in 'UUsers.pas' {FrmUsers},
  UAbout in 'UAbout.pas' {FrmAbout},
  UGesMem in 'UGesMem.pas' {frmGesMem};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Mini-Projet - Simulation du System Temps Partagé';
  Application.CreateForm(TMainF, MainF);
  Application.CreateForm(TFrmGraphe, FrmGraphe);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFrmSession, FrmSession);
  Application.CreateForm(TfrmGesMem, frmGesMem);
  Application.Run;
end.
