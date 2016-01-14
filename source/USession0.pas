unit USession;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, StdCtrls, ComCtrls, DBCtrls, ImgList,
  Menus, ExtCtrls;

type
  TFrmSession = class(TForm)
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
    PopupMenu1: TPopupMenu;
    Reduire1: TMenuItem;
    N1: TMenuItem;
    MenuQuitter: TMenuItem;
    ImageList1: TImageList;
    TC2: TTabControl;
    GB2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit_Taille: TEdit;
    CB_Type: TComboBox;
    BitBtn6: TBitBtn;
    Edit_Temps: TEdit;
    GB3: TGroupBox;
    BitBtn3: TBitBtn;
    ListReq: TListView;
    BtnOk: TBitBtn;
    BtnAnnuler: TBitBtn;
    TC1: TTabControl;
    Panel1: TPanel;
    GB1: TGroupBox;
    Edit_Compte: TEdit;
    Edit_Password: TEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    PanelBas: TPanel;
    ImgBordureBG: TImage;
    ImgBordureB: TImage;
    ImgBordureBD: TImage;
    ImgBordureG2: TImage;
    ImgBordureD: TImage;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BtnAnnulerClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
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
  FrmSession: TFrmSession;
  SourisDown: Boolean;
  SourisDown_X, SourisDown_Y: Integer;

implementation

uses UMainFrm, Math;

{$R *.dfm}

function FindKey(Compte, Password: string): boolean;
begin
  result := ((Compte = 'benbac') and (Password = 'softmicro'))
    or ((Compte = 'Fatima') and (Password = '14'))
      or ((Compte = 'Soumaya') and (Password = '10'))
end;

procedure TFrmSession.BitBtn1Click(Sender: TObject);
var
  i: integer;
begin
  if not FindKey(Edit_Compte.Text, Edit_Password.Text) then
    begin
      MessageDlg('Compte ou mot de passe incorrect, essayer de nouveau !!',
        mtInformation, [MbOk], 0);
      Edit_Compte.Clear;
      Edit_Password.Clear;
      Edit_Compte.SetFocus;
    end
  else
    begin
      {if MainForm.Etat.Value = false then
        begin
          MessageDlg('Vous avez pas le droit d''accéder au Système !!',
            mtInformation, [MbOk], 0);
          Edit_Compte.Clear;
          Edit_Password.Clear;
          Edit_Compte.SetFocus;
          exit;
        end; }
      for i:=0 to MainForm.ListUsers.Items.Count - 1 do
        if MainForm.ListUsers.Items[i].SubItems[0] = Edit_Compte.Text then
          begin
            MessageDlg('Utilisateur déja connecté, essayer de nouveau !!',
              mtInformation, [MbOk], 0);
            Edit_Compte.Clear;
            Edit_Password.Clear;
            Edit_Compte.SetFocus;
            Exit;
          end;
      TC1.Visible := false;
      TC2.Visible := true;
      Caption := 'Bienenue Mr.' + Edit_Compte.Text;
    end;
end;

procedure TFrmSession.BitBtn3Click(Sender: TObject);
begin
  if ListReq.ItemIndex = -1 then
    MessageDlg('Séléctionner une requête dabord !!', mtconfirmation, [MbOk], 0)
  else
    if MessageDlg('A ce que vous être sûr ?', mtconfirmation,
      [MbYes, MbNo], 0) = MrYes then
        ListReq.Items[ListReq.ItemIndex].Delete;
end;

procedure TFrmSession.BitBtn6Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  if (CB_Type.ItemIndex = - 1)
    or (length(Edit_Taille.Text) <= 0)
      or (length(Edit_Temps.Text) <= 0) then
    begin
      ShowMessage('Vous devez donner le type de requête et ça taille' +
        'et ça temps d''entrée !!');
      CB_Type.SetFocus;
      Exit;
    end;
  ListItem := ListReq.Items.Add;
  ListItem.Caption := CB_Type.Text;
  ListItem.SubItems.Add(Edit_Taille.Text);
  ListItem.SubItems.Add(Edit_Temps.Text);
  Edit_Taille.Clear;
  Edit_Temps.Clear;
  CB_Type.ItemIndex := - 1;
end;

procedure TFrmSession.BtnAnnulerClick(Sender: TObject);
begin
  if MessageDlg('A ce que vous être sûr d''annuler la session en cours ?',
    mtconfirmation, [MbYes, MbNo], 0) = MrYes then
      Close;
end;

procedure TFrmSession.BitBtn2Click(Sender: TObject);
begin
  close
end;

procedure TFrmSession.BtnOkClick(Sender: TObject);
begin
  if ListReq.Items.Count <= 0 then
    begin
       MessageDlg('Vous devez donner au moins une requête !!', mtconfirmation,
        [MbOk], 0);
       CB_Type.SetFocus;
       Exit;
    end
  else
    begin
      MainForm.EtablirConnection(Edit_Compte.Text, ListReq.Items);
      MainForm.Req_acc := 0;
      Close;
    end;
end;

procedure TFrmSession.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := True;
  SourisDown_X := X;
  SourisDown_Y := Y;
end;

procedure TFrmSession.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If SourisDown=True Then
    Begin
      Left := Left + X - SourisDown_X;
      Top := Top + Y - SourisDown_Y;
    End;
end;

procedure TFrmSession.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := False;
end;

procedure TFrmSession.ImgBordureHD3Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmSession.ImgBordureHD1Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFrmSession.ImgBordureHG2Click(Sender: TObject);
begin
  PopupMenu1.Popup( Left+ImgBordureHG2.Left , Top+ImgBordureHG2.Height );
end;

end.
