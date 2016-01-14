{
  afficher les infos d'utilisateur à la fin du simulation
  effacer l'étoile à la fin
}
unit UMainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, ComCtrls, Grids, DBGrids, Spin, ExtCtrls,
  Menus, Buttons, ImgList;

type
  TMainForm = class(TForm)
    Timer_Sum: TTimer;
    Timer_Interval: TSpinEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Btn_Pause: TButton;
    GB_Reel: TGroupBox;
    Page_Sum: TPageControl;
    TabUsers: TTabSheet;
    ListUsers: TListView;
    TabRequete: TTabSheet;
    ListReq: TListView;
    TabCPU: TTabSheet;
    ListCPU: TListView;
    Label2: TLabel;
    Lab_Temp_Total: TLabel;
    TabE_S: TTabSheet;
    ListE_S: TListView;
    Btn_Connect: TBitBtn;
    Btn_Deconnect: TBitBtn;
    Btn_Sum: TBitBtn;
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
    procedure Btn_ConnectClick(Sender: TObject);
    procedure Timer_IntervalChange(Sender: TObject);
    procedure Btn_SumClick(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Utilisateurs2Click(Sender: TObject);
    procedure Requtes1Click(Sender: TObject);
    procedure CPU1Click(Sender: TObject);
    procedure Btn_PauseClick(Sender: TObject);
    procedure Timer_SumTimer(Sender: TObject);
    procedure ES1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ImgBordureHD3Click(Sender: TObject);
    procedure ImgBordureHD1Click(Sender: TObject);
    procedure ImgBordureHG2Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    Compteur,  Req_acc : integer;
    procedure EtablirConnection(Compte: string; List_Req:TListItems);
    function ExecuteRequeteCPU: Boolean;
    procedure ExecuteRequetesE_S;
    procedure ExecutionRequete;
    function ExistReqCPU: Boolean;
  end;

var
  MainForm: TMainForm;
  SourisDown: Boolean;
  SourisDown_X, SourisDown_Y: Integer;

implementation

uses   USession;

{$R *.dfm}

procedure MettreUnPoint(List: TListView; col, index: integer; Point: char);
begin
  List.Items[index].SubItems[col] := Point;
end;

procedure MettrePoint(List: TListView; col, index: integer; Point: char);
var
  i: integer;
begin
  for i:= 0 to List.Items.Count - 1 do
    if i <> index then
      List.Items[i].SubItems[col] := '';
  List.Items[index].SubItems[col] := Point;
end;

procedure FindKey(ListSrc, ListDist: TListView; var index: integer);
var
  j: integer;
begin
  for j := 0 to ListDist.Items.Count - 1 do
    if ListDist.Items[j].Caption = ListSrc.Items[index].Caption then break;
  index := j;
end;

procedure FindUser(ListSrc, ListDist: TListView; var index: integer);
var
  j: integer;
begin
  for j := 0 to ListDist.Items.Count - 1 do
    if ListDist.Items[j].SubItems[0] = ListSrc.Items[index].SubItems[8] then break;
  index := j;
end;

procedure TMainForm.ExecuteRequetesE_S;
var
  i, j: integer;
begin
  for i:= 0 to ListReq.Items.Count -1 do
    with ListReq.Items[i] do
      if (subItems[0] = 'E/S') then
        if (StrToInt(subItems[2]) <= Compteur) then
          begin
            // Recuperer le n° de la requete
            j := i; FindKey(ListReq, ListE_S, j);

            if (StrToInt(subItems[5]) < StrToInt(subItems[1])) then
                begin

                  // Marquer la requete
                  MettreUnPoint(ListReq, 9, i, '°');
                  MettreUnPoint(ListE_S, 5, j, '°');

                  //inc la duree d'exe des requetes E/S
                  subItems[5] := IntToStr(StrToInt(subItems[5]) + 1);
                  ListE_S.Items[j].subItems[2] := subItems[5];

                  //calculer le temps total des requetes E/S
                  subItems[6] := IntToStr(StrToInt(subItems[5]) +
                    StrToInt(subItems[2]));
                  ListE_S.Items[j].subItems[3] := subItems[6];
                end
            else
                begin

                  // Marquer la fin de la requete
                  MettreUnPoint(ListReq, 9, i, '.');
                  MettreUnPoint(ListE_S, 5, j, '.');
                end;
          end
end;

function TMainForm.ExecuteRequeteCPU: boolean;
var
  Taille, Temps_Occup, Temps_attente, Temps_Entre, Temps_Total,
    Duree_Exe, i, j, k, somme :integer;
  Taux : real;
begin
  Result := True;
  with ListReq.Items[Req_acc] do
    begin
      Taille := StrToInt(subItems[1]);
      Temps_Entre := StrToInt(subItems[2]);
      Temps_Occup := StrToInt(subItems[3]);
      Temps_attente := StrToInt(subItems[4]);

      if Temps_Entre <= Compteur then
        if Temps_Occup < Taille then
          begin
            for i:= 0 to ListReq.Items.Count -1 do
              with ListReq.Items[i] do
                if (Caption <> ListReq.Items[Req_acc].Caption)
                  and (subItems[0] = 'CPU')
                    and (StrToInt(subItems[2]) <= Compteur)
                      and (StrToInt(subItems[3]) < StrToInt(subItems[1])) then
                          begin
                            // Recuperer le n° de requete CPU
                            j := i; FindKey(ListReq, ListCPU, j);

                            // Marquer la requete currente
                            MettrePoint(ListReq, 9, i, ' ');
                            MettrePoint(ListCPU, 8, j, ' ');

                            // Inc le temps d'attente des autres requetes CPU
                            subItems[4] := IntToStr(StrToInt(subItems[4]) + 1);
                            ListCPU.Items[j].subItems[3] := subItems[4];

                            // Calculer la durée d'execution des autres requetes CPU
                            subItems[5] := IntToStr(StrToInt(subItems[3]) +
                              StrToInt(subItems[4]));
                            ListCPU.Items[j].subItems[4] := subItems[5];

                            // Calculer le temps total des autres requetes CPU
                            subItems[6] := IntToStr(StrToInt(subItems[5]) +
                              StrToInt(subItems[2]));
                            ListCPU.Items[j].subItems[5] := subItems[6];
                          end;

            // Recuperer le n° de requete CPU et le n° de l'utilisateur
            j := Req_acc; FindKey(ListReq, ListCPU, j);
            k := Req_acc; FindUser(ListReq, ListUsers, k);

            // Marquer la requete currente
            MettreUnPoint(ListReq, 9, Req_acc, '*');
            MettreUnPoint(ListCPU, 8, j, '*');
            MettrePoint(ListUsers, 8, k, '*');

            //Inc le temps d'occupation du requete currente
            Inc(Temps_Occup);
            subItems[3] := IntToStr(Temps_Occup); // occup
            ListCPU.Items[j].subItems[2] := subItems[3];

            //calculer la duree d'exe du requete currente
            Duree_Exe := Temps_Occup + Temps_attente;
            subItems[5] := IntToStr(Duree_Exe);   // duree
            ListCPU.Items[j].subItems[4] := subItems[5];

            //calculer le temps total du requete currente
            Temps_Total := Duree_Exe + Temps_Entre;
            subItems[6] := IntToStr(Temps_Total); // total
            ListCPU.Items[j].subItems[5] := subItems[6];

            //Calculer la somme des temps d'occupation de tous les requetes
            somme := 0;
            for i:= 0 to ListReq.Items.Count -1 do
              if ListReq.Items[i].subItems[0] = 'CPU' then
                somme := somme + StrToInt(ListReq.Items[i].subItems[3]);
            if somme < 1 then somme := 1;

            for i:= 0 to ListReq.Items.Count -1 do
              with ListReq.Items[i] do
                if (subItems[0] = 'CPU')
                  and (StrToInt(subItems[2]) <= Compteur) then
                    begin
                      // Recuperer le n° de requete CPU
                      j := i; FindKey(ListReq, ListCPU, j);

                      //Calculer le taux d'occupation du requete currente
                      Taux := StrToInt(subItems[3]) * 100 / somme;
                      subItems[7] := FormatFloat('#.##', Taux);
                      ListCPU.Items[j].subItems[6] := subItems[7];
                    end
          end
        else
          begin
            Result := False;

            // Recuperer le n° de requete CPU et le n° de l'utilisateur
            j := Req_acc; FindKey(ListReq, ListCPU, j);
            k := Req_acc; FindUser(ListReq, ListUsers, k);

            // Marquer la fin le la requete
            MettreUnPoint(ListReq, 9, Req_acc, '.');
            MettreUnPoint(ListCPU, 8, j, '.');
            MettreUnPoint(ListUsers, 8, k, '.');
          end
        else
          Result := False;
  end;
end;

procedure TMainForm.EtablirConnection(Compte: string; List_Req:TListItems);
var
  ListItem: TListItem;
  i, Nbr_Requetes, Taille_Req, Temps_Entre: integer;
  Type_Req: string;
begin
  Nbr_Requetes := ListReq.Items.Count;
  Taille_Req := 0;
  Temps_Entre := StrToInt(List_Req[0].SubItems[1]);

  for i:= 0 to List_Req.Count -1 do
    begin
      Type_Req := List_Req[i].Caption;
      Inc(Taille_Req, StrToInt(List_Req[i].SubItems[0]));
      if StrToInt(List_Req[i].SubItems[1]) < Temps_Entre then
        Temps_Entre := StrToInt(List_Req[i].SubItems[1]);
      Inc(Nbr_Requetes);

      ListItem := ListReq.Items.Add;
      ListItem.Caption := IntToStr(Nbr_Requetes);
      ListItem.SubItems.Add(Type_Req);
      ListItem.SubItems.Add(List_Req[i].SubItems[0]);
      ListItem.SubItems.Add(List_Req[i].SubItems[1]);
      ListItem.SubItems.Add('0');
      ListItem.SubItems.Add('0');
      ListItem.SubItems.Add('0');
      ListItem.SubItems.Add('0');
      LIstItem.SubItems.Add('0');
      LIstItem.SubItems.Add(Compte);
      LIstItem.SubItems.Add('');

      if Type_Req = 'CPU' then
        begin
          ListItem := ListCPU.Items.Add;
          ListItem.Caption := IntToStr(Nbr_Requetes);
          ListItem.SubItems.Add(List_Req[i].SubItems[0]);
          ListItem.SubItems.Add(List_Req[i].SubItems[1]);
          ListItem.SubItems.Add('0');
          ListItem.SubItems.Add('0');
          ListItem.SubItems.Add('0');
          ListItem.SubItems.Add('0');
          LIstItem.SubItems.Add('0');
          LIstItem.SubItems.Add(Compte);
          LIstItem.SubItems.Add('');
        end

      else if Type_Req = 'E/S' then
        begin
          ListItem := ListE_S.Items.Add;
          ListItem.Caption := IntToStr(Nbr_Requetes);
          ListItem.SubItems.Add(List_Req[i].SubItems[0]);
          ListItem.SubItems.Add(List_Req[i].SubItems[1]);
          ListItem.SubItems.Add('0');
          LIstItem.SubItems.Add('0');
          LIstItem.SubItems.Add(Compte);
          LIstItem.SubItems.Add('');
        end;
    end;

  ListItem := ListUsers.Items.Add;
  ListItem.Caption := IntToStr(ListUsers.Items.Count);
  LIstItem.SubItems.Add(Compte);
  ListItem.SubItems.Add(IntToStr(Taille_Req));
  ListItem.SubItems.Add(IntToStr(Temps_Entre));
  ListItem.SubItems.Add('0');
  ListItem.SubItems.Add('0');
  LIstItem.SubItems.Add('0');
  ListItem.SubItems.Add('0');
  LIstItem.SubItems.Add('0');
  LIstItem.SubItems.Add('');
end;

procedure TMainForm.Btn_ConnectClick(Sender: TObject);
begin
  FrmSession := TFrmSession.Create(Application);
  try
    FrmSession.ShowModal;
  finally
    FrmSession.Free
  end;
end;

procedure TMainForm.Timer_IntervalChange(Sender: TObject);
begin
  Timer_Sum.Interval := Timer_Interval.Value;
end;

procedure TMainForm.Btn_SumClick(Sender: TObject);
begin
  if Btn_Sum.Caption = '&Démmarer' then
    begin
     if ListUsers.Items.Count = -1 then
      begin
       MessageDlg('Aucun utilisateur est trouvé dans la liste !!', mtwarning, [MbOk],0);
       Exit;
      end;
      Compteur := 0;
      Req_acc := 0;
      Lab_Temp_Total.Caption := '0';
      Nomform.Caption := 'Simulation Temps Partagé [Simulation en cours ...]';
      Btn_Pause.Caption := '&Suspondu';
     // Menu_Suspondu.Caption := '&Suspondu';
      Btn_Sum.Caption := '&Annuler';
      //Menu_Sum.Caption := '&Annuler';
      Timer_Sum.Enabled := true;
    end
  else
  if Btn_Sum.Caption = '&Annuler' then
    begin
      if MessageDlg('A ce que vous être sure !!', mtconfirmation,
        [MbYes, MbCancel],0) = mrCancel then
          Exit;
      Timer_Sum.Enabled := False;
      Compteur := 0;
      Req_acc := 0;
      Lab_Temp_Total.Caption := '0';
      Nomform.Caption := 'Simulation Temps Partagé [Simulation annuler ...]';
      ListUsers.Clear;
      ListReq.Clear;
      ListCPU.Clear;
      ListE_S.Clear;
      Btn_Pause.Caption := '&Suspondu';
     // Menu_Suspondu.Caption := '&Suspondu';
      Btn_Sum.Caption := '&Démmarer';
     // Menu_Sum.Caption := '&Démmarer';
    end;
  if Btn_Sum.Caption = '&Terminer' then
    begin
      Compteur := 0;
      Req_acc := 0;
      Lab_Temp_Total.Caption := '0';
      Nomform.Caption := 'Simulation Temps Partagé';
      ListUsers.Clear;
      ListReq.Clear;
      ListCPU.Clear;
      ListE_S.Clear;
      Btn_Pause.Caption := '&Suspondu';
     // Menu_Suspondu.Caption := '&Suspondu';
      Btn_Sum.Caption := '&Démmarer';
     // Menu_Sum.Caption := '&Démmarer';
    end;
end;

procedure TMainForm.Quitter1Click(Sender: TObject);
begin
  Close
end;

procedure TMainForm.Utilisateurs2Click(Sender: TObject);
begin
  TabUsers.Show;
end;

procedure TMainForm.Requtes1Click(Sender: TObject);
begin
  TabRequete.Show
end;

procedure TMainForm.CPU1Click(Sender: TObject);
begin
  TabCPU.Show
end;

procedure TMainForm.Btn_PauseClick(Sender: TObject);
begin
  if Btn_Pause.Caption = '&Suspondu' then
    begin
      Nomform.Caption := 'Simulation Temps Partagé [Simulation suspondu ...]';
      Btn_Pause.Caption := '&Continue';
     // Menu_Suspondu.Caption := '&Continue';
      Timer_Sum.Enabled := false;
    end
  else
    begin
      Nomform.Caption := 'Simulation Temps Partagé [Simulation en cours ...]';
      Btn_Pause.Caption := '&Suspondu';
     // Menu_Suspondu.Caption := '&Suspondu';
      Timer_Sum.Enabled := True;
    end;
end;

function TMainForm.ExistReqCPU: Boolean;
var
  i: integer;
begin
  result := False;
  if ListCPU.Items.Count < -1 then exit;
  for i:= 0 to ListCPU.Items.Count -1 do
    if (ListCPU.Items[i].subItems[8]) = '*' then
      begin
        result := True;
        Exit;
      end;
end;

procedure TMainForm.ExecutionRequete;
var
  CPU: boolean;
  TypeReq, Point: String;
begin
  CPU := False;

  // Execution de la requete
  Repeat
    TypeReq := ListReq.Items[Req_acc].SubItems[0];
    Point :=  ListReq.Items[Req_acc].SubItems[9];
    if Point <> '.' then
    if TypeReq = 'CPU' then
      CPU := ExecuteRequeteCPU;
    ExecuteRequetesE_S;

    // Passer à la requete suivante
    if Req_acc < ListReq.Items.Count -1 then
      Inc(Req_acc)
    else
      Req_acc := 0;
  Until Not ExistReqCPU or CPU = True
end;

procedure TMainForm.Timer_SumTimer(Sender: TObject);
var
  Temps_Occp, Temps_Attente, Duree_Exe, Temps_Total, i, j: integer;
  ExistPoint: boolean;
  Compte: String;
  Taux: real;
begin

  Timer_Sum.Enabled := false;

  // A ce que la sumilation est terminée ? => existance des ponts
  ExistPoint := True;
  for i:= 0 to ListReq.Items.Count - 1 do
    if ListReq.Items[i].SubItems[9] <> '.' then
      begin
        ExistPoint := False;
        Break;
      end;
  if ExistPoint then
    begin
      for i := 0 to ListUsers.Items.Count - 1 do
        with ListUsers.Items[i] do
          begin
            Temps_Occp := 0;
            Temps_Attente := 0;
            Duree_Exe := 0;
            Temps_Total := 0;
            Taux := 0;
            Compte := SubItems[0];
            for j := 0 to ListReq.Items.Count - 1 do
              with ListReq.Items[j] do
                if SubItems[8] = Compte then
                  begin
                    Inc(Temps_Occp, StrToInt(SubItems[3]));
                    Inc(Temps_Attente, StrToInt(SubItems[4]));
                    Inc(Duree_Exe, StrToInt(SubItems[5]));
                    Inc(Temps_Total, StrToInt(SubItems[6]));
                    Taux := Taux + StrToFloat(SubItems[7]);
                  end;
           SubItems[3] := IntToStr(Temps_Occp);
           SubItems[4] := IntToStr(Temps_Attente);
           SubItems[5] := IntToStr(Duree_Exe);
           SubItems[6] := IntToStr(Temps_Total);
           SubItems[7] := FloatToStr(Taux);
          end;
      Btn_Sum.Caption := '&Terminer';
      //Menu_Sum.Caption := '&Terminer';
      Btn_Pause.Caption := '&Suspondu';
     // Menu_Suspondu.Caption := '&Suspondu';
      Nomform.Caption := 'Simulation Temps Partagé [Simulation Terminée]';
      MessageDlg('Simulation Terminée' + #13 +
        '   Nbr d''utilisateurs : ' + IntToStr(ListUsers.Items.Count) + #13 +
        '   Nbr de requêtes     : ' + IntToStr(ListReq.Items.Count) + #13 +
        '   Nbr de req. CPU     : ' + IntToStr(ListCPU.Items.Count) + #13 +
        '   Nbr de req. E/S     : ' + IntToStr(ListE_S.Items.Count) + #13 +
        '   Temps Total         : ' + Lab_Temp_Total.Caption + ' seconde(s)',
          mtInformation, [MbOk], 0);
      Exit;
    end;

  // Inc et afficher le compteur
  Inc(Compteur);
  Lab_Temp_Total.Caption := IntToStr(Compteur);

  // Executer la requete
  ExecutionRequete;

  Timer_Sum.Enabled := true;
end;

procedure TMainForm.ES1Click(Sender: TObject);
begin
  TabE_S.Show;
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
Label
  First, Second, Third;
var
  bool: boolean;
  i: integer;
  Compte : String;
begin
  bool := Timer_Sum.Enabled;
  if ListUsers.ItemIndex = -1 then
    MessageDlg('Vous devez séléctionner un utilisateur dabord !!', mtconfirmation, [MbOk],0)
  else
    if MessageDlg('A ce que vous être sûr ?', mtconfirmation, [MbYes, MbNo],0) = MrYes then
      begin
        Timer_Sum.Enabled := False;
        Compte := ListUsers.Items[ListUsers.ItemIndex].SubItems[0];
        ListUsers.Items[ListUsers.ItemIndex].Delete;
First:  for i:= 0 to ListReq.Items.Count - 1 do
          if ListReq.Items[i].SubItems[8] = Compte then
            begin
              ListReq.Items[i].Delete;
              goto First;
            end;
Second: for i:= 0 to ListCPU.Items.Count - 1 do
          if ListCPU.Items[i].SubItems[7] = Compte then
            begin
              ListCPU.Items[i].Delete;
              goto Second;
            end;
Third:  for i:= 0 to ListE_S.Items.Count - 1 do
          if ListE_S.Items[i].SubItems[4] = Compte then
            begin
              ListE_S.Items[i].Delete;
              goto Third;
            end;
        end;
  Timer_Sum.Enabled := bool;
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := True;
  SourisDown_X := X;
  SourisDown_Y := Y;
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If SourisDown=True Then
    Begin
      Left := Left + X - SourisDown_X;
      Top := Top + Y - SourisDown_Y;
    End;
end;

procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := False;
end;

procedure TMainForm.ImgBordureHD3Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ImgBordureHD1Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.ImgBordureHG2Click(Sender: TObject);
begin
  PopupMenu1.Popup( Left+ImgBordureHG2.Left , Top+ImgBordureHG2.Height );
end;
end.



