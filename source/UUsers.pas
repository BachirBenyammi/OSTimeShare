unit UUsers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, StdCtrls, msxmldom, XMLDoc, ExtCtrls, ComCtrls,
  Buttons, ImgList, Menus;

type
  TfrmUsers = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lvUsers: TListView;
    btnFermer: TBitBtn;
    btnSupp: TBitBtn;
    btnNouv: TBitBtn;
    btnModif: TBitBtn;
    btnAjout: TBitBtn;
    btnAnnuler: TBitBtn;
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
    Edit_Email: TEdit;
    Edit_Prenom: TEdit;
    Edit_Nom: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    cb_Etat: TCheckBox;
    Label6: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Edit_Compte: TEdit;
    Edit_Motdepasse: TEdit;
    XMLDoc: TXMLDocument;
    procedure lvUsersClick(Sender: TObject);
    procedure btnNouvClick(Sender: TObject);
    procedure btnAjoutClick(Sender: TObject);
    procedure btnSuppClick(Sender: TObject);
    procedure btnModifClick(Sender: TObject);
    procedure btnAnnulerClick(Sender: TObject);
    procedure ImgBordureHD3Click(Sender: TObject);
    procedure ImgBordureHD1Click(Sender: TObject);
    procedure ImgBordureHG2Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  public
    procedure Clear;
    procedure AddUser(ListItem: TListItem);
    procedure LoadXMLFile;    
  end;

var
  frmUsers: TfrmUsers;
  SourisDown: Boolean;
  SourisDown_X, SourisDown_Y: Integer;

implementation

uses UMain;

{$R *.dfm}

procedure TfrmUsers.Clear;
begin
  Edit_Compte.Clear;
  Edit_Motdepasse.Clear;
  Edit_Nom.Clear;
  Edit_Prenom.Clear;
  Edit_Email.Clear;
  cb_Etat.Checked := False;
end;

procedure TfrmUsers.AddUser(ListItem: TListItem);
begin
  with XMLDoc do
    begin
      Version := '1.0';
      Encoding := 'ISO-8859-1';
      With ChildNodes['users'] do
        with AddChild('user') do
          with ListItem do
          begin
            AddChild('nom').Text := Caption;
            AddChild('prenom').Text := SubItems[0];
            AddChild('compte').Text := SubItems[1];
            AddChild('motdepasse').Text := SubItems[2];
            AddChild('email').Text := SubItems[3];
            AddChild('etat').Text := SubItems[4];
        end;
      SaveToFile(MainF.XMLFileName);
    end;
end;

procedure TfrmUsers.lvUsersClick(Sender: TObject);
begin
  if lvUsers.ItemIndex <> -1 then
    with lvUsers.Items[lvUsers.ItemIndex] do
      begin
        Edit_Nom.Text := Caption;
        Edit_Prenom.Text := SubItems[0];
        Edit_Compte.Text := SubItems[1];
        Edit_Motdepasse.Text := SubItems[2];
        Edit_Email.Text := SubItems[3];
        cb_Etat.Checked := StrToBool(SubItems[4]);
      end;
end;

procedure TfrmUsers.btnNouvClick(Sender: TObject);
begin
  btnNouv.Enabled := False;
  btnAjout.Enabled := True;
  btnModif.Enabled := False;
  btnSupp.Enabled := False;
  Edit_Compte.ReadOnly := False;
  Edit_Compte.Color := clSkyBlue;
  Clear;
end;

procedure TfrmUsers.btnAjoutClick(Sender: TObject);
var
  ListItem : TListItem;
begin
  if (length(Edit_Compte.Text) = 0) or (Length(Edit_Motdepasse.Text) = 0) then
    begin
      MessageDlg('Remplir le compte et le mot de passe d''abord !!', mtInformation,
        [mbOk], 0);
      Exit;
    end;

  ListItem := lvUsers.Items.Add;
  with ListItem do
    begin
       Caption := Edit_Nom.Text;
       SubItems.Add(Edit_Prenom.Text);       
       SubItems.Add(Edit_Compte.Text);
       SubItems.Add(Edit_Motdepasse.Text);
       SubItems.Add(Edit_Email.Text);
       SubItems.Add(BoolToStr(cb_Etat.Checked));
    end;
  AddUser(ListItem);
  Clear;
  Edit_Compte.ReadOnly := True;
  Edit_Compte.Color := clSilver;
  btnNouv.Enabled := True;
  btnAjout.Enabled := False;
  btnModif.Enabled := True;
  btnSupp.Enabled := True;  
end;

procedure TfrmUsers.btnSuppClick(Sender: TObject);
var
  i: integer;
begin
  if lvUsers.ItemIndex = -1 then
    begin
      MessageDlg('Sélectionner un utilisateur d''abord !!', mtInformation,
        [mbOk], 0);
      Exit;
    end;

  if MessageDlg('A ce que vous être sure ?', mtConfirmation, [mbYes, MbCancel],
    0) = mrCancel then Exit;

  with XMLDoc.ChildNodes['users'] do
    with lvUsers.Items[lvUsers.ItemIndex] do
      for  i:= 0 to ChildNodes.Count -1 do
        if ChildNodes[i].ChildNodes['compte'].Text = SubItems[1] then
          begin
            Delete;
            ChildNodes.Remove(ChildNodes[i]);
            XMLDoc.SaveToFile(MainF.XMLFileName);
            LoadXMLFile;
            Break;
          end;
  Clear;
  Edit_Compte.ReadOnly := True;
  Edit_Compte.Color := clSilver;
end;

procedure TfrmUsers.btnModifClick(Sender: TObject);
var
  i: integer;
begin
  if lvUsers.ItemIndex = -1 then
    begin
      MessageDlg('Sélectionner un utilisateur d''abord !!', mtInformation,
        [mbOk], 0);
      Exit;
    end;

  if MessageDlg('A ce que vous être sure ?', mtConfirmation, [mbYes, MbCancel],
    0) = mrCancel then Exit;

  with XMLDoc.ChildNodes['users'] do
    with lvUsers.Items[lvUsers.ItemIndex] do
      for  i:= 0 to ChildNodes.Count -1 do
        if ChildNodes[i].ChildNodes['compte'].Text = SubItems[1] then
          begin
            ChildNodes[i].ChildNodes['nom'].Text := Edit_Nom.Text;
            ChildNodes[i].ChildNodes['prenom'].Text := Edit_Prenom.Text;
            ChildNodes[i].ChildNodes['compte'].Text := Edit_Compte.Text;
            ChildNodes[i].ChildNodes['motdepasse'].Text := Edit_Motdepasse.Text;
            ChildNodes[i].ChildNodes['email'].Text := Edit_Email.Text;
            ChildNodes[i].ChildNodes['etat'].Text := BoolToStr(cb_Etat.Checked);
            XMLDoc.SaveToFile(MainF.XMLFileName);
            LoadXMLFile;
            Break;
          end;
  Clear;
  Edit_Compte.ReadOnly := True;
  Edit_Compte.Color := clSilver;  
end;

procedure TfrmUsers.btnAnnulerClick(Sender: TObject);
begin
  if MessageDlg('A ce que vous être sure ?', mtConfirmation, [mbYes, MbCancel],
    0) = mrCancel then Exit;
  Edit_Compte.ReadOnly := True;
  Edit_Compte.Color := clSilver;
  Clear;
  btnNouv.Enabled := True;  
  btnAjout.Enabled := False;
  btnModif.Enabled := True;
  btnSupp.Enabled := True;     
end;

procedure TfrmUsers.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := True;
  SourisDown_X := X;
  SourisDown_Y := Y;
end;

procedure TfrmUsers.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If SourisDown=True Then
    Begin
      Left := Left + X - SourisDown_X;
      Top := Top + Y - SourisDown_Y;
    End;
end;

procedure TfrmUsers.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := False;
end;

procedure TfrmUsers.ImgBordureHD3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsers.ImgBordureHD1Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfrmUsers.ImgBordureHG2Click(Sender: TObject);
begin
  PopupMenu1.Popup( Left+ImgBordureHG2.Left , Top+ImgBordureHG2.Height );
end;

procedure TfrmUsers.LoadXMLFile;
var
  i: integer;
  ListItem : TListItem;
begin
  lvUsers.Items.Clear;
  XMLDoc.ChildNodes.Clear;
  XMLDoc.LoadFromFile(MainF.XMLFileName);
  with XMLDoc.ChildNodes.Nodes['users'] do
    with ChildNodes do
      for i := 0 to ChildNodes.Count - 1 do
        with Nodes[i].ChildNodes do
      with ListItem do
          begin
            ListItem := lvUsers.Items.Add;
            Caption := Nodes['nom'].Text;
            SubItems.Add(Nodes['prenom'].Text);
            SubItems.Add(Nodes['compte'].Text);
            SubItems.Add(Nodes['motdepasse'].Text);
            SubItems.Add(Nodes['email'].Text);
            SubItems.Add(Nodes['etat'].Text);
          end;
end;
procedure TfrmUsers.FormCreate(Sender: TObject);
begin
  LoadXMLFile;
end;

end.
