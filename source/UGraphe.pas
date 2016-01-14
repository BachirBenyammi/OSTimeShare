unit UGraphe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, TeeProcs, TeEngine, Chart, mxgraph, StdCtrls, Series, Grids,
  Buttons, ExtDlgs, inifiles,Clipbrd, ImgList, Menus;

type
  Table_Page = array [1..2,1..5]of integer;
  TFrmGraphe = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Graphe: TChart;
    SD: TSaveDialog;
    OD: TOpenDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Series1: TBarSeries;
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
    N1: TMenuItem;
    MenuQuitter: TMenuItem;
    ImageList1: TImageList;
    SpeedButton7: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Panel2: TPanel;
    SG_Res: TStringGrid;
    procedure Dessiner_Point(x,y:integer);
    procedure Dessiner_Graphe;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure ImgBordureHD3Click(Sender: TObject);
    procedure ImgBordureHD1Click(Sender: TObject);
    procedure ImgBordureHG2Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  end;

var
  FrmGraphe: TFrmGraphe;
  Tb : Table_Page;
  SourisDown: Boolean;
  SourisDown_X, SourisDown_Y: Integer;

implementation

uses UGesMem;

{$R *.DFM}

procedure TFrmGraphe.Dessiner_Point(x,y:integer);
begin
  with graphe.SeriesList.Series[0] do
    begin
      ParentChart:=graphe;
      AddXY(x,y,'',clRed );
      end;
end;

procedure TFrmGraphe.Dessiner_Graphe;
var
  i:integer;
begin
  for i:=1 to 5 do
    Dessiner_Point(StrToInt(SG_Res.Cells[1,i]), StrToInt(SG_Res.Cells[2,i]));
end;

procedure TFrmGraphe.FormCreate(Sender: TObject);

begin
  SG_Res.Cells[0,0]:= 'ESSAIS';
  SG_Res.Cells[0,1]:= '01';
  SG_Res.Cells[0,2]:= '02';
  SG_Res.Cells[0,3]:= '03';
  SG_Res.Cells[0,4]:= '04';
  SG_Res.Cells[0,5]:= '05';
  SG_Res.Cells[1,0]:= 'TAILLE';
  SG_Res.Cells[2,0]:= 'DEF_PAGE';
{  for i:=1 to 5 do
    begin
      SG_Res.cells[1,i] := '';
      SG_Res.cells[2,i] := '';
    end;
 Graphe.Series[0].Clear;}    
end;

procedure TFrmGraphe.SpeedButton3Click(Sender: TObject);
begin
graphe.CopyToClipboardBitmap;
end;

procedure TFrmGraphe.SpeedButton1Click(Sender: TObject);
begin
  Graphe.ZoomPercent(90);
end;

procedure TFrmGraphe.SpeedButton2Click(Sender: TObject);
begin
  Graphe.ZoomPercent(110);
end;

procedure TFrmGraphe.SpeedButton4Click(Sender: TObject);
var
  Bmp : TBitmap;
begin
  SD.FilterIndex := 2;
  SD.FileName := 'image.bmp';
  if SD.Execute then
    begin
      Bmp := TBitmap.Create;
        try
          Graphe.CopyToClipboardBitmap;
          Bmp.Create.Assign(Clipboard);
          Bmp.SaveToFile(SD.FileName);
        finally
          Bmp.Free;
        end;
    end;
end;

procedure TFrmGraphe.SpeedButton6Click(Sender: TObject);
var
  Fichier : TIniFile;
begin
  SD.FilterIndex := 1;
  SD.FileName := 'table.ini';
  if SD.Execute then
    begin
      Fichier := TIniFile.Create(SD.Filename);
      try
        Fichier.WriteInteger('Taille','T(1,1)',StrToInt(SG_Res.Cells[1,1]));
        Fichier.WriteInteger('Taille','T(1,2)',StrToInt(SG_Res.Cells[1,2]));
        Fichier.WriteInteger('Taille','T(1,3)',StrToInt(SG_Res.Cells[1,3]));
        Fichier.WriteInteger('Taille','T(1,4)',StrToInt(SG_Res.Cells[1,4]));
        Fichier.WriteInteger('Taille','T(1,5)',StrToInt(SG_Res.Cells[1,5]));
        Fichier.WriteInteger('Defaut','T(2,1)',StrToInt(SG_Res.Cells[2,1]));
        Fichier.WriteInteger('Defaut','T(2,2)',StrToInt(SG_Res.Cells[2,2]));
        Fichier.WriteInteger('Defaut','T(2,3)',StrToInt(SG_Res.Cells[2,3]));
        Fichier.WriteInteger('Defaut','T(2,4)',StrToInt(SG_Res.Cells[2,4]));
        Fichier.WriteInteger('Defaut','T(2,5)',StrToInt(SG_Res.Cells[2,5]));
      finally
        Fichier.Free;
      end;
    end;
end;

procedure TFrmGraphe.SpeedButton7Click(Sender: TObject);
var
  Fichier : TIniFile;
begin
  OD.FilterIndex := 1;
  if OD.Execute then
    begin
      Fichier := TIniFile.Create(OD.Filename);
      try
        SG_Res.Cells[1,1] := Fichier.ReadString('Taille','T(1,1)','0');
        SG_Res.Cells[1,2] := Fichier.ReadString('Taille','T(1,2)','0');
        SG_Res.Cells[1,3] := Fichier.ReadString('Taille','T(1,3)','0');
        SG_Res.Cells[1,4] := Fichier.ReadString('Taille','T(1,4)','0');
        SG_Res.Cells[1,5] := Fichier.ReadString('Taille','T(1,5)','0');
        SG_Res.Cells[2,1] := Fichier.ReadString('Defaut','T(2,1)','0');
        SG_Res.Cells[2,2] := Fichier.ReadString('Defaut','T(2,2)','0');
        SG_Res.Cells[2,3] := Fichier.ReadString('Defaut','T(2,3)','0');
        SG_Res.Cells[2,4] := Fichier.ReadString('Defaut','T(2,4)','0');
        SG_Res.Cells[2,5] := Fichier.ReadString('Defaut','T(2,5)','0');
      finally
        Fichier.Free;
      end;
    end;
end;

procedure TFrmGraphe.SpeedButton5Click(Sender: TObject);
begin
  Graphe.Series[0].Clear;
  Dessiner_Graphe;
end;

procedure TFrmGraphe.SpeedButton9Click(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 5 do
    begin
      SG_Res.cells[1,i] := '';
      SG_Res.cells[2,i] := '';
    end;
end;

procedure TFrmGraphe.SpeedButton10Click(Sender: TObject);
begin
  Graphe.Series[0].Clear;
end;

procedure TFrmGraphe.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := True;
  SourisDown_X := X;
  SourisDown_Y := Y;
end;

procedure TFrmGraphe.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If SourisDown=True Then
    Begin
      Left := Left + X - SourisDown_X;
      Top := Top + Y - SourisDown_Y;
    End;
end;

procedure TFrmGraphe.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := False;
end;

procedure TFrmGraphe.ImgBordureHD3Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmGraphe.ImgBordureHD1Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFrmGraphe.ImgBordureHG2Click(Sender: TObject);
begin
  PopupMenu1.Popup( Left+ImgBordureHG2.Left , Top+ImgBordureHG2.Height );
end;
end.
