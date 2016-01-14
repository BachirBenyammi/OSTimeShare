unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList, xmldom,
  XMLIntf, msxmldom, XMLDoc;

type
  TMainF = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ImgBordureG2: TImage;
    ImgBordureD: TImage;
    Panel1: TPanel;
    PanelHaut: TPanel;
    ImgbordureHG1: TImage;
    ImgBordureHG2: TImage;
    ImgBordureHG3: TImage;
    ImgBordureHG4: TImage;
    ImgBordureHD1: TImage;
    ImgBordureHD2: TImage;
    ImgBordureHD3: TImage;
    ImgbordureHD4: TImage;
    ImgbordureH: TImage;
    Nomform: TLabel;
    PanelBas: TPanel;
    ImgBordureBG: TImage;
    ImgBordureB: TImage;
    ImgBordureBD: TImage;
    PopupMenu1: TPopupMenu;
    Reduire1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuQuitter: TMenuItem;
    ImageList1: TImageList;
    XMLDoc: TXMLDocument;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Quitter1Click(Sender: TObject);
    procedure Gestiondelammoire1Click(Sender: TObject);
    procedure Gestiondesprocesus1Click(Sender: TObject);
    procedure ReprsentationGraphique1Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
    procedure Gestiondesutiliateurs1Click(Sender: TObject);
    procedure ImgBordureHG2Click(Sender: TObject);
    procedure ImgBordureHD1Click(Sender: TObject);
    procedure ImgBordureHD3Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  Public
    XMLFileName: String;
    procedure CreateXMLFile;
  end;

var
  MainF: TMainF;
  SourisDown: Boolean;
  SourisDown_X, SourisDown_Y: Integer;

    
implementation

uses UGraphe, UMainFrm, UAbout, UUsers, UGesMem;

{$R *.dfm}

procedure TMainF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if MessageDlg('A ce que vous être sur ?', mtConfirmation,
    [mbOk, mbCancel], 0) = mrCancel then
     CanClose := False;
end;

procedure TMainF.Quitter1Click(Sender: TObject);
begin
  close
end;

procedure TMainF.Gestiondelammoire1Click(Sender: TObject);
begin
  frmGesMem.ShowModal
end;

procedure TMainF.Gestiondesprocesus1Click(Sender: TObject);
begin
  MainForm.ShowModal
end;

procedure TMainF.ReprsentationGraphique1Click(Sender: TObject);
begin
  FrmGraphe.ShowModal
end;

procedure TMainF.Apropos1Click(Sender: TObject);
begin
  FrmAbout := TFrmAbout.Create(Application);
  try
    FrmAbout.ShowModal
  finally
    FrmAbout.Free
  end;
end;

procedure TMainF.Gestiondesutiliateurs1Click(Sender: TObject);
begin
  FrmUsers := TFrmUsers.Create(Application);
  try
    FrmUsers.ShowModal;
  finally
    FrmUsers.Free
  end;
end;

procedure TMainF.ImgBordureHG2Click(Sender: TObject);
begin
PopupMenu1.Popup( Left+ImgBordureHG2.Left , Top+ImgBordureHG2.Height );
end;

procedure TMainF.ImgBordureHD1Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainF.ImgBordureHD3Click(Sender: TObject);
begin
  Close;
end;

procedure TMainF.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := True;
  SourisDown_X := X;
  SourisDown_Y := Y;
end;

procedure TMainF.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If SourisDown=True Then
    Begin
      Left := Left + X - SourisDown_X;
      Top := Top + Y - SourisDown_Y;
    End;
end;

procedure TMainF.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := False;
end;

procedure TMainF.FormCreate(Sender: TObject);
begin
  XMLFileName := ExtractFileDir(Application.ExeName);
  if XMLFileName[length(XMLFileName)] <> '\' then
    XMLFileName := XMLFileName + '\';
  XMLFileName := XMLFileName + 'users.xml';
  if not FileExists(XMLFileName) then
    CreateXMLFile;
end;

procedure TMainF.CreateXMLFile;
begin
  with XMLDoc do
    begin
      //ChildNodes.Clear;
      Version := '1.0';
      Encoding := 'ISO-8859-1';
      With AddChild('users') do
        with AddChild('user') do
          begin
            AddChild('nom').Text := 'BENYAMMI';
            AddChild('prenom').Text := 'Bachir';
            AddChild('compte').Text := 'benbac';
            AddChild('motdepasse').Text := 'softmicro';
            AddChild('email').Text := 'benbac20@hotmail.com';
            AddChild('etat').Text := BoolToStr(True);
        end;
      SaveToFile(XMLFileName);
    end;
end;

end.
