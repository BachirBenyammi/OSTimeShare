unit UGesMem;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, Buttons, IniFiles, ImgList, Menus ;
type
  TfrmGesMem = class(TForm)
    btnAjouter: TButton;
    btnFixer: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    btnFermer: TBitBtn;
    btnSimuler: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    gbResultats: TGroupBox;
    btnGraph: TBitBtn;
    btnRepdrendre: TBitBtn;
    GroupBox1: TGroupBox;
    St1: TStringGrid;
    btnInitial: TBitBtn;
    btnSauve: TBitBtn;
    SD: TSaveDialog;
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
    SgDP: TStringGrid;
    procedure btnAjouterClick(Sender: TObject);
    procedure btnFixerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimulerClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure btnRepdrendreClick(Sender: TObject);
    procedure btnGraphClick(Sender: TObject);
    procedure btnInitialClick(Sender: TObject);
    procedure btnSauveClick(Sender: TObject);
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
frmGesMem: TfrmGesMem;
nadr, Taille:integer;
M:array[0..4,0..8]of integer;
  SourisDown: Boolean;
  SourisDown_X, SourisDown_Y: Integer;
implementation

uses UGraphe;
{$R *.dfm}
procedure TfrmGesMem.btnAjouterClick(Sender: TObject);
begin
  if(nadr<>8)then
    begin
      nadr:=nadr+1;
      M[0,nadr]:=strtoint(edit1.Text);
      st1.Cells[nadr,0]:=edit1.Text;
    end
  else
    showmessage(' le nombre d''adresse < 8');
  Edit1.SetFocus;
  Edit1.SelectAll;
end;

procedure TfrmGesMem.btnFixerClick(Sender: TObject);
var i,j:integer;
begin
  Taille := strtoint(edit2.text);
  for i:=0 to nadr do
    begin
      M[1,i]:=M[0,i] div Taille;
      st1.Cells[i,1]:=inttostr(M[1,i])  ;
    end;
 for i:=2 to 4 do
  for j:=0 to 7 do
    st1.Cells[j,i]:='';
  btnAjouter.Enabled := False;
end;

procedure TfrmGesMem.FormCreate(Sender: TObject);
begin
 nadr:=-1;
 SgDP.Cells[0, 0] := 'Taille';
 SgDP.Cells[0, 1] := 'DP';
end;

procedure TfrmGesMem.btnSimulerClick(Sender: TObject);
label
  Cas1, Cas2, Cas3, Cas4, cas41, Cas5, cas51, cas52, cas6, cas61,
  cas62, cas63, cas64, cas65, cas7, cas71, cas72, cas73, cas74, cas75,
  cas76, cas77, cas8, cas81, cas82, cas83, cas84, cas85, cas86, cas87,
  cas88, cas9;
var
  DP, i: integer;
begin
 cas1: DP:=1;
  st1.Cells[0,5]:='DP';
  st1.Cells[0,2]:=st1.Cells[0,1]+'+'+'  <-' ;
      st1.Cells[0,5] :='DP';
 cas2:if (st1.cells[1,1]<> '') then
         begin
           if ( st1.Cells[0,1] <> st1.cells[1,1] ) then
            begin
             st1.Cells[1,2]:=st1.Cells[0,2];
              st1.Cells[1,3]:=st1.Cells[1,1]+'+' ;
               DP:=DP+1;
                 st1.Cells[1,5] :='DP';
            end
  else
    st1.Cells[1,2]:=st1.Cells[0,2];
  end;
  cas3:if (st1.cells[2,1]<> '') then
    begin
      if (st1.cells[1,1]=st1.cells[2,1])
        or (st1.cells[0,1]=st1.cells[2,1])then
          begin
            st1.Cells[2,2]:=st1.Cells[1,2] ;
            st1.Cells[2,3]:=st1.Cells[1,3] ;
             goto cas4 ;
          end ;

          if (st1.cells[1,1]<>st1.cells[2,1])
            and (st1.cells[0,1]<>st1.cells[2,1])then
             begin
              st1.Cells[2,2]:=st1.Cells[1,2] ;
              st1.Cells[2,3]:=st1.Cells[1,3] ;
              st1.Cells[2,4]:=st1.Cells[2,1]+'+';
                DP:=DP+1;
              st1.Cells[2,5]:='DP';
              goto cas41;
            end;

            end;

 cas4: if (st1.cells[3,1]<> '') then
    begin
      if (copy(st1.Cells[2,2], 0, 1)=st1.Cells[3,1])
        or (copy(st1.Cells[2,3], 0, 1)=st1.Cells[3,1]) then
            begin
              st1.Cells[3,2]:=st1.Cells[1,2];
              st1.Cells[3,3]:=st1.Cells[1,3];
                goto cas5;
              end;

       if (copy(st1.Cells[2,2], 0, 1)<>st1.Cells[3,1])
        or (copy(st1.Cells[2,3], 0, 1)<>st1.Cells[3,1]) then
            begin
              st1.Cells[3,2]:=st1.Cells[1,2];
              st1.Cells[3,3]:=st1.Cells[1,3];
              st1.Cells[3,4]:=st1.Cells[3,1]+'+';

              DP:=DP+1;
              st1.Cells[3,5]:='DP';
            goto cas51;
              end;
              end;
   cas41: if (st1.cells[3,1]<> '') then
    begin
      if (copy(st1.Cells[2,2], 0, 1)=st1.Cells[3,1])
        or (copy(st1.Cells[2,3], 0, 1)=st1.Cells[3,1])
        or   (copy(st1.Cells[2,4], 0, 1)=st1.Cells[3,1])then
          begin
            st1.Cells[3,2]:=st1.Cells[2,2];
            st1.Cells[3,3]:=st1.Cells[2,3];
            st1.Cells[3,4]:=st1.Cells[2,4];
           goto cas51;
          end;

         if (copy(st1.Cells[2,2], 0, 1)<>st1.Cells[3,1])
          and(copy(st1.Cells[2,3], 0, 1)<>st1.Cells[3,1])
           and(copy(st1.Cells[2,4], 0, 1)<>st1.Cells[3,1])then
          begin
            st1.Cells[3,2]:=st1.Cells[3,1]+'+';
            st1.Cells[3,3]:=copy(st1.Cells[2,3], 0, 1)+'-'+' <-';
            st1.Cells[3,4]:=copy(st1.Cells[2,4], 0, 1)+'-' ;

           DP:=DP+1;
           st1.Cells[3,5]:='DP';
           goto cas52;
           end;
       end;
Cas5: if (st1.cells[4,1]<> '') then
          begin
           if (st1.Cells[0,1]=st1.Cells[4,1])
            or (st1.Cells[1,1]=st1.Cells[4,1]) then
              begin
                    st1.Cells[4,2]:=st1.Cells[1,2];
                    st1.Cells[4,3]:=st1.Cells[1,3];
                   goto cas6;
              end;

         if (st1.Cells[0,1]<>st1.Cells[4,1])
            and (st1.Cells[1,1]<>st1.Cells[4,1]) then
              begin
                    st1.Cells[4,2]:=st1.Cells[1,2];
                    st1.Cells[4,3]:=st1.Cells[1,3];
                    st1.Cells[4,4]:=st1.Cells[4,1]+'+';
                DP:=DP+1;
               st1.Cells[4,5]:='DP';
                goto cas61;
                end;
Cas51: if (st1.cells[4,1]<> '') then
          begin
           if (copy(st1.Cells[3,2], 0, 1)=st1.Cells[4,1])
            or (copy(st1.Cells[3,3], 0, 1)=st1.Cells[4,1])
               or (copy(st1.Cells[3,4], 0, 1)=st1.Cells[4,1])then
              begin
                st1.Cells[4,2]:=st1.Cells[3,2];
                st1.Cells[4,3]:=st1.Cells[3,3];
                st1.Cells[4,4]:=st1.Cells[3,4];

               goto cas61;
               end;
            if (copy(st1.Cells[3,2], 0, 1)<>st1.Cells[4,1])
            and (copy(st1.Cells[3,3], 0, 1)<>st1.Cells[4,1])
               and(copy(st1.Cells[3,4], 0, 1)<>st1.Cells[4,1])then
              begin
                st1.Cells[4,2]:=st1.Cells[4,1]+'+';
                st1.Cells[4,3]:=copy(st1.Cells[3,3], 0, 1)+'-'+' <-';
                st1.Cells[4,4]:=copy(st1.Cells[3,4], 0, 1)+'-';

               DP:=DP+1;
               st1.Cells[4,5]:='DP';
               goto cas62;
               end;
   end;

 cas52: if (st1.cells[4,1]<> '') then
          begin
           if (copy(st1.Cells[3,2], 0, 1)=st1.Cells[4,1]) then
            begin
             st1.Cells[4,2]:=st1.Cells[3,2];
             st1.Cells[4,3]:=st1.Cells[3,3];
             st1.Cells[4,4]:=st1.Cells[3,4];

            goto cas62;
            end;
           if (copy(st1.Cells[3,3], 0, 1)=st1.Cells[4,1]) then
            begin
             st1.Cells[4,2]:=st1.Cells[3,2];
             st1.Cells[4,3]:=copy(st1.Cells[3,3], 0, 1)+'+'+' <-';
             st1.Cells[4,4]:=st1.Cells[3,4];

            goto cas63;
             end;
            if (copy(st1.Cells[3,4], 0, 1)=st1.Cells[4,1]) then
            begin
             st1.Cells[4,2]:=st1.Cells[3,2];
             st1.Cells[4,3]:=st1.Cells[3,3];
             st1.Cells[4,4]:=copy(st1.Cells[3,4], 0, 1)+'+';

            goto cas64;
             end;
           if (copy(st1.Cells[3,2], 0, 1)<>st1.Cells[4,1])
            and (copy(st1.Cells[3,3], 0, 1)<>st1.Cells[4,1])
               and(copy(st1.Cells[3,4], 0, 1)<>st1.Cells[4,1])then
              begin
               st1.Cells[4,2]:=st1.Cells[3,2];
               st1.Cells[4,3]:=st1.Cells[4,1]+'+';
               st1.Cells[4,4]:=copy(st1.Cells[3,4], 0, 2)+' <-';

              DP:=DP+1;
               st1.Cells[4,5]:='DP';
              goto cas65;
             end;
  end;
cas6:if (st1.cells[5,1]<> '') then
          begin
           if (copy(st1.Cells[4,2], 0,1)=st1.Cells[5,1])
            or (copy(st1.Cells[4,3], 0,1)=st1.Cells[5,1]) then
              begin
                    st1.Cells[5,2]:=st1.Cells[4,2];
                    st1.Cells[5,3]:=st1.Cells[4,3];

              goto cas7;
                end;
         if (copy(st1.Cells[4,2], 0,1)<>st1.Cells[5,1])
            and (copy(st1.Cells[4,3], 0,1)<>st1.Cells[5,1]) then
              begin
                    st1.Cells[5,2]:=st1.Cells[4,2];
                    st1.Cells[5,3]:=st1.Cells[4,3];
                    st1.Cells[5,4]:=st1.Cells[5,1]+'+';

               DP:=DP+1;
               st1.Cells[5,5]:='DP';
               goto cas71;
             end;
end;
cas61: if (st1.cells[5,1]<> '') then
          begin
           if (copy(st1.Cells[4,2], 0, 1)=st1.Cells[5,1])
            or (copy(st1.Cells[4,3], 0, 1)=st1.Cells[5,1])
               or (copy(st1.Cells[4,4], 0, 1)=st1.Cells[5,1])then
              begin
                st1.Cells[5,2]:=st1.Cells[4,2];
                st1.Cells[5,3]:=st1.Cells[4,3];
                st1.Cells[5,4]:=st1.Cells[4,4];

               goto cas71;
                end;

            if (copy(st1.Cells[4,2], 0, 1)<>st1.Cells[5,1])
            and (copy(st1.Cells[4,3], 0, 1)<>st1.Cells[5,1])
               and(copy(st1.Cells[4,4], 0, 1)<>st1.Cells[5,1])then
              begin
                st1.Cells[5,2]:=st1.Cells[5,1]+'+';
                st1.Cells[5,3]:=copy(st1.Cells[4,3], 0, 1)+'-'+' <-';
                st1.Cells[5,4]:=copy(st1.Cells[4,4], 0, 1)+'-';

               DP:=DP+1;
               st1.Cells[5,5]:='DP';
               goto cas72;
               end;
end;
cas62:  if (st1.cells[5,1]<> '') then
          begin
           if (copy(st1.Cells[4,2], 0, 1)=st1.Cells[5,1]) then
            begin
             st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=st1.Cells[4,3];
             st1.Cells[5,4]:=st1.Cells[4,4];

            goto cas72;
             end;
           if (copy(st1.Cells[4,3], 0, 1)=st1.Cells[5,1]) then
            begin
             st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=copy(st1.Cells[4,3],0,1)+'+'+' <-';
             st1.Cells[5,4]:=st1.Cells[4,4];

            goto cas73;
               end;
            if (copy(st1.Cells[4,4], 0, 1)=st1.Cells[5,1]) then
            begin
             st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=st1.Cells[4,3];
             st1.Cells[5,4]:=copy(st1.Cells[4,4], 0, 1)+'+';

            goto cas74;
              end;
           if (copy(st1.Cells[4,2], 0, 1)<>st1.Cells[5,1])
            and (copy(st1.Cells[4,3], 0, 1)<>st1.Cells[5,1])
               and(copy(st1.Cells[4,4], 0, 1)<>st1.Cells[5,1])then
              begin
               st1.Cells[5,2]:=st1.Cells[4,2];
               st1.Cells[5,3]:=st1.Cells[5,1]+'+';
               st1.Cells[5,4]:=copy(st1.Cells[4,4], 0, 2)+' <-';

              DP:=DP+1;
               st1.Cells[5,5]:='DP';
              goto cas75;
              end;
  end;
cas63: if (st1.cells[5,1]<> '') then
          begin
           if (copy(st1.Cells[4,2], 0, 1)=st1.Cells[5,1]) then
            begin
             st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=st1.Cells[4,3];
             st1.Cells[5,4]:=st1.Cells[4,4];

            goto cas73;
             end;
           if (copy(st1.Cells[4,3], 0, 1)=st1.Cells[5,1]) then
            begin
            st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=st1.Cells[4,3];
             st1.Cells[5,4]:=st1.Cells[4,4];

            goto cas73;
              end;
            if (copy(st1.Cells[4,4], 0, 1)=st1.Cells[5,1]) then
            begin
             st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=st1.Cells[4,3];
             st1.Cells[5,4]:=copy(st1.Cells[4,4], 0, 1)+'+';

            goto cas74;
              end;
           if (copy(st1.Cells[4,2], 0, 1)<>st1.Cells[5,1])
            and (copy(st1.Cells[4,3], 0, 1)<>st1.Cells[5,1])
               and(copy(st1.Cells[4,4], 0, 1)<>st1.Cells[5,1])then
              begin
               st1.Cells[5,2]:=st1.Cells[4,2]+' <-';
               st1.Cells[5,3]:=copy(st1.Cells[4,3], 0, 1)+'-';
               st1.Cells[5,4]:=st1.Cells[5,1]+'+';
              DP:=DP+1;
               st1.Cells[5,5]:='DP';
              goto cas75;
              end;
  end;
cas64:if (st1.cells[5,1]<> '') then
          begin
           if (copy(st1.Cells[4,2], 0, 1)=st1.Cells[5,1]) then
            begin
             st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=st1.Cells[4,3];
             st1.Cells[5,4]:=st1.Cells[4,4];

            goto cas76;
            end;
           if (copy(st1.Cells[4,3], 0, 1)=st1.Cells[5,1]) then
            begin
             st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=copy(st1.Cells[4,3],0,1)+'+'+' <-';
             st1.Cells[5,4]:=st1.Cells[4,4];

            goto cas74;
            end;
            if (copy(st1.Cells[4,4], 0, 1)=st1.Cells[5,1]) then
            begin
             st1.Cells[5,2]:=st1.Cells[4,2];
             st1.Cells[5,3]:=st1.Cells[4,3];
             st1.Cells[5,4]:=st1.Cells[4,4];

            goto cas76;
              end;
           if (copy(st1.Cells[4,2], 0, 1)<>st1.Cells[5,1])
            and (copy(st1.Cells[4,3], 0, 1)<>st1.Cells[5,1])
               and(copy(st1.Cells[4,4], 0, 1)<>st1.Cells[5,1])then
              begin
               st1.Cells[5,2]:=st1.Cells[4,2];
               st1.Cells[5,3]:=st1.Cells[5,1]+'+';
               st1.Cells[5,4]:=copy(st1.Cells[4,4], 0, 2)+' <-';

              DP:=DP+1;
               st1.Cells[5,5]:='DP';
                end;
              goto cas77;
  end;
  cas65:if (st1.cells[5,1]<> '') then
          begin
           if (copy(st1.Cells[4,2], 0,1)=st1.Cells[5,1])
            or (copy(st1.Cells[4,3], 0,1)=st1.Cells[5,1]) then
              begin
                    st1.Cells[5,2]:=st1.Cells[4,2];
                    st1.Cells[5,3]:=st1.Cells[4,3];
                    st1.Cells[5,4]:=st1.Cells[4,4];
              goto cas75;
               end;
            if (copy(st1.Cells[4,4], 0,1)=st1.Cells[5,1])then
                begin
                st1.Cells[5,2]:=st1.Cells[4,2];
                    st1.Cells[5,3]:=st1.Cells[4,3];
                    st1.Cells[5,4]:=copy(st1.Cells[4,4], 0, 1)+'+'+' <-';
              goto cas77;
              end;
         if (copy(st1.Cells[4,2], 0,1)<>st1.Cells[5,1])
            and (copy(st1.Cells[4,3], 0,1)<>st1.Cells[5,1])
                 and (copy(st1.Cells[4,4], 0,1)<>st1.Cells[5,1])then
              begin
                    st1.Cells[5,2]:=st1.Cells[4,2]+' <-';
                    st1.Cells[5,3]:=st1.Cells[4,3];
                    st1.Cells[5,4]:=st1.Cells[5,1]+'+';

               DP:=DP+1;
               st1.Cells[5,5]:='DP';
               goto cas71;
                end;
 end;
cas7: if (st1.cells[6,1]<> '') then
          begin
           if (copy(st1.Cells[5,2], 0,1)=st1.Cells[6,1])
            or (copy(st1.Cells[5,3], 0,1)=st1.Cells[6,1]) then
              begin
                    st1.Cells[6,2]:=st1.Cells[5,2];
                    st1.Cells[6,3]:=st1.Cells[5,3];

              goto cas8;
               end;
         if (copy(st1.Cells[5,2], 0,1)<>st1.Cells[6,1])
            and (copy(st1.Cells[5,3], 0,1)<>st1.Cells[6,1]) then
              begin
                    st1.Cells[6,2]:=st1.Cells[5,2];
                    st1.Cells[6,3]:=st1.Cells[5,3];
                    st1.Cells[6,4]:=st1.Cells[6,1]+'+';

               DP:=DP+1;
               st1.Cells[6,5]:='DP';
               goto cas81;
                end;
 end;
cas71: if (st1.cells[6,1]<> '') then
          begin
           if (copy(st1.Cells[5,2], 0, 1)=st1.Cells[6,1])
            or (copy(st1.Cells[5,3], 0, 1)=st1.Cells[6,1])
               or (copy(st1.Cells[5,4], 0, 1)=st1.Cells[6,1])then
              begin
                st1.Cells[6,2]:=st1.Cells[5,2];
                st1.Cells[6,3]:=st1.Cells[5,3];
                st1.Cells[6,4]:=st1.Cells[5,4];

               goto cas81;
               end;

            if (copy(st1.Cells[5,2], 0, 1)<>st1.Cells[6,1])
            and (copy(st1.Cells[5,3], 0, 1)<>st1.Cells[6,1])
               and(copy(st1.Cells[5,4], 0, 1)<>st1.Cells[6,1])then
              begin
                st1.Cells[6,2]:=st1.Cells[6,1]+'+';
                st1.Cells[6,3]:=copy(st1.Cells[5,3], 0, 1)+'-'+' <-';
                st1.Cells[6,4]:=copy(st1.Cells[5,4], 0, 1)+'-';

               DP:=DP+1;
               st1.Cells[6,5]:='DP';
               goto cas82;
              end;
end;
cas72:  if (st1.cells[6,1]<> '') then
          begin
           if (copy(st1.Cells[5,2], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas82;
            end;
           if (copy(st1.Cells[5,3], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=copy(st1.Cells[5,3],0,1)+'+'+' <-';
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas83;
             end;
            if (copy(st1.Cells[5,4], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=copy(st1.Cells[5,4], 0, 1)+'+';

            goto cas84;
             end;
           if (copy(st1.Cells[5,2], 0, 1)<>st1.Cells[6,1])
            and (copy(st1.Cells[5,3], 0, 1)<>st1.Cells[6,1])
               and(copy(st1.Cells[5,4], 0, 1)<>st1.Cells[6,1])then
              begin
               st1.Cells[6,2]:=st1.Cells[5,2];
               st1.Cells[6,3]:=st1.Cells[6,1]+'+';
               st1.Cells[6,4]:=copy(st1.Cells[5,4], 0, 2)+' <-';

              DP:=DP+1;
               st1.Cells[6,5]:='DP';
              goto cas85;
               end;
  end;
cas73: if (st1.cells[6,1]<> '') then
          begin
           if (copy(st1.Cells[5,2], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas83;
             end;
           if (copy(st1.Cells[5,3], 0, 1)=st1.Cells[6,1]) then
            begin
            st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,4]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas83;
             end;
            if (copy(st1.Cells[5,4], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=copy(st1.Cells[5,4], 0, 1)+'+';

            goto cas84;
            end;
           if (copy(st1.Cells[5,2], 0, 1)<>st1.Cells[6,1])
            and (copy(st1.Cells[5,3], 0, 1)<>st1.Cells[6,1])
               and(copy(st1.Cells[5,4], 0, 1)<>st1.Cells[6,1])then
              begin
               st1.Cells[6,2]:=st1.Cells[5,2]+' <-';
               st1.Cells[6,3]:=copy(st1.Cells[5,3], 0, 1)+'-';
               st1.Cells[6,4]:=copy(st1.Cells[6,1], 0, 1)+'+';

              DP:=DP+1;
               st1.Cells[6,5]:='DP';
              goto cas81;
               end;
  end;
 cas74: if (st1.cells[6,1]<> '') then
          begin
           if (copy(st1.Cells[5,2], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas84;
             end;
           if (copy(st1.Cells[5,3], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=copy(st1.Cells[5,3],0,1)+'+'+' <-';
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas86;
              end;
            if (copy(st1.Cells[5,4], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas84;
             end;
           if (copy(st1.Cells[5,2], 0, 1)<>st1.Cells[6,1])
            and (copy(st1.Cells[5,3], 0, 1)<>st1.Cells[6,1])
               and(copy(st1.Cells[5,4], 0, 1)<>st1.Cells[6,1])then
              begin
               st1.Cells[6,2]:=st1.Cells[5,2];
               st1.Cells[6,3]:=st1.Cells[6,1]+'+';
               st1.Cells[6,4]:=copy(st1.Cells[5,4], 0, 2)+' <-';

              DP:=DP+1;

               st1.Cells[6,5]:='DP';
              goto cas87;
               end;
  end;
 cas75: if (st1.cells[6,1]<> '') then
          begin
           if (copy(st1.Cells[5,2], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas85;
              end;
           if (copy(st1.Cells[5,3], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas85;
              end;
            if (copy(st1.Cells[5,4], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=copy(st1.Cells[5,4], 0, 1)+'+'+' <-';

            goto cas87;
              end;
           if (copy(st1.Cells[5,2], 0, 1)<>st1.Cells[6,1])
            and (copy(st1.Cells[5,3], 0, 1)<>st1.Cells[6,1])
               and(copy(st1.Cells[5,4], 0, 1)<>st1.Cells[6,1])then
              begin
               st1.Cells[6,2]:=st1.Cells[5,2]+' <-';
               st1.Cells[6,3]:=st1.Cells[5,3];
               st1.Cells[6,4]:=st1.Cells[6,1]+'+';

              DP:=DP+1;
               st1.Cells[6,5]:='DP';
              goto cas81;
               end;
  end;

cas76: if (st1.cells[6,1]<> '') then
          begin
           if (copy(st1.Cells[5,2], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas84;
            end;
           if (copy(st1.Cells[5,4], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
             st1.Cells[6,3]:=st1.Cells[5,3];
             st1.Cells[6,4]:=st1.Cells[5,4];

            goto cas84;
           end;
            if (copy(st1.Cells[5,3], 0, 1)=st1.Cells[6,1]) then
            begin
             st1.Cells[6,2]:=st1.Cells[5,2];
               st1.Cells[6,3]:=copy(st1.Cells[5,3], 0, 1)+'+'+' <-';
             st1.Cells[6,4]:=st1.Cells[5,4];


            goto cas9;
              end;
           if (copy(st1.Cells[5,2], 0, 1)<>st1.Cells[6,1])
            and (copy(st1.Cells[5,3], 0, 1)<>st1.Cells[6,1])
               and(copy(st1.Cells[5,4], 0, 1)<>st1.Cells[6,1])then
              begin
               st1.Cells[6,2]:=st1.Cells[5,2];
               st1.Cells[6,3]:=st1.Cells[6,1]+'+';
               st1.Cells[6,4]:=st1.Cells[5,4]+' <-';

              DP:=DP+1;
               st1.Cells[6,5]:='DP';
              goto cas87;
               end;
  end;
 cas77: if (st1.cells[6,1]<> '') then
          begin
           if (copy(st1.Cells[5,2], 0, 1)=st1.Cells[6,1])
            or (copy(st1.Cells[5,3], 0, 1)=st1.Cells[6,1])
               or (copy(st1.Cells[5,4], 0, 1)=st1.Cells[6,1])then
              begin
                st1.Cells[6,2]:=st1.Cells[5,2];
                st1.Cells[6,3]:=st1.Cells[5,3];
                st1.Cells[6,4]:=st1.Cells[5,4];

               goto cas87;
                end;
            if (copy(st1.Cells[5,2], 0, 1)<>st1.Cells[6,1])
            and (copy(st1.Cells[5,3], 0, 1)<>st1.Cells[6,1])
               and(copy(st1.Cells[5,4], 0, 1)<>st1.Cells[6,1])then
              begin
                st1.Cells[6,2]:=copy(st1.Cells[5,2], 0, 1)+'-'+' <-';
                st1.Cells[6,3]:=copy(st1.Cells[5,3], 0, 1)+'-';
                st1.Cells[6,4]:=copy(st1.Cells[6,1], 0, 1)+'+';

               DP:=DP+1;
               st1.Cells[6,5]:='DP';
               goto cas88;
               end;
end;
cas8:if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0,1)=st1.Cells[7,1])
            or (copy(st1.Cells[6,3], 0,1)=st1.Cells[7,1]) then
              begin
                    st1.Cells[7,2]:=st1.Cells[6,2];
                    st1.Cells[7,3]:=st1.Cells[6,3];

              goto cas9;
              end;
         if (copy(st1.Cells[6,2], 0,1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0,1)<>st1.Cells[7,1]) then
              begin
                    st1.Cells[7,2]:=st1.Cells[6,2];
                    st1.Cells[7,3]:=st1.Cells[6,3];
                    st1.Cells[7,4]:=st1.Cells[7,1]+'+';

               DP:=DP+1;
               st1.Cells[7,5]:='DP';
               goto cas9;
                end;
 end;
cas81: if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0, 1)=st1.Cells[7,1])
            or (copy(st1.Cells[6,3], 0, 1)=st1.Cells[7,1])
               or (copy(st1.Cells[6,4], 0, 1)=st1.Cells[7,1])then
              begin
                st1.Cells[7,2]:=st1.Cells[6,2];
                st1.Cells[7,3]:=st1.Cells[6,3];
                st1.Cells[7,4]:=st1.Cells[6,4];

               goto cas9;
             end;
            if (copy(st1.Cells[6,2], 0, 1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0, 1)<>st1.Cells[7,1])
               and(copy(st1.Cells[6,4], 0, 1)<>st1.Cells[7,1])then
              begin
                st1.Cells[7,2]:=st1.Cells[7,1]+'+';
                st1.Cells[7,3]:=copy(st1.Cells[6,3], 0, 1)+'-'+' <-';
                st1.Cells[7,4]:=copy(st1.Cells[6,4], 0, 1)+'-';

               DP:=DP+1;
               st1.Cells[7,5]:='DP';
               goto cas9;
                end;
end;
cas82:  if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,4]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
             end;
           if (copy(st1.Cells[6,3], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=copy(st1.Cells[6,3],0,1)+'+'+' <-';
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
              end;
            if (copy(st1.Cells[6,4], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=copy(st1.Cells[6,4], 0, 1)+'+';

            goto cas9;
             end;
           if (copy(st1.Cells[6,2], 0, 1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0, 1)<>st1.Cells[7,1])
               and(copy(st1.Cells[6,4], 0, 1)<>st1.Cells[7,1])then
              begin
               st1.Cells[7,2]:=st1.Cells[6,2];
               st1.Cells[7,3]:=st1.Cells[7,1]+'+';
               st1.Cells[7,4]:=copy(st1.Cells[6,4], 0, 2)+' <-';

              DP:=DP+1;
               st1.Cells[7,5]:='DP';
              goto cas9;
                end;
  end;
cas83: if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
             end;
           if (copy(st1.Cells[6,3], 0, 1)=st1.Cells[7,1]) then
            begin
            st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
            end;
            if (copy(st1.Cells[6,4], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=copy(st1.Cells[6,4], 0, 1)+'+';

            goto cas9;
            end;
           if (copy(st1.Cells[6,2], 0, 1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0, 1)<>st1.Cells[7,1])
               and(copy(st1.Cells[6,4], 0, 1)<>st1.Cells[7,1])then
              begin
               st1.Cells[7,2]:=st1.Cells[6,2]+' <-';
               st1.Cells[7,3]:=st1.Cells[6,3];
               st1.Cells[7,4]:=copy(st1.Cells[7,1], 0, 1)+'+';

              DP:=DP+1;
               st1.Cells[7,5]:='DP';
              goto cas9;
               end;
  end;
 cas84: if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,4]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
              end;
           if (copy(st1.Cells[6,3], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=copy(st1.Cells[6,3],0,1)+'+'+' <-';
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
               end;
            if (copy(st1.Cells[6,4], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];
            goto cas9;
              end;
           if (copy(st1.Cells[6,2], 0, 1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0, 1)<>st1.Cells[7,1])
               and(copy(st1.Cells[6,4], 0, 1)<>st1.Cells[7,1])then
              begin
               st1.Cells[7,2]:=st1.Cells[6,2];
               st1.Cells[7,3]:=st1.Cells[7,1]+'+';
               st1.Cells[7,4]:=copy(st1.Cells[6,4], 0, 2)+' <-';

              DP:=DP+1;
               st1.Cells[7,5]:='DP';
              goto cas9;
              end;
  end;
 cas85: if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
              end;
           if (copy(st1.Cells[6,3], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
              end;
            if (copy(st1.Cells[6,4], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=copy(st1.Cells[6,4], 0, 1)+'+'+' <-';

            goto cas9;
            end;
           if (copy(st1.Cells[6,2], 0, 1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0, 1)<>st1.Cells[7,1])
               and(copy(st1.Cells[6,4], 0, 1)<>st1.Cells[7,1])then
              begin
               st1.Cells[7,2]:=st1.Cells[6,2]+' <-';
               st1.Cells[7,3]:=st1.Cells[6,3];
               st1.Cells[7,4]:=st1.Cells[7,1]+'+';

              DP:=DP+1;
               st1.Cells[7,5]:='DP';
              goto cas9;
             end;
  end;

cas86: if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0, 1)=st1.Cells[7,1])
            or (copy(st1.Cells[6,3], 0, 1)=st1.Cells[7,1])
               or (copy(st1.Cells[6,4], 0, 1)=st1.Cells[7,1])then
              begin
                st1.Cells[7,2]:=st1.Cells[6,2];
                st1.Cells[7,3]:=st1.Cells[6,3];
                st1.Cells[7,4]:=st1.Cells[6,4];

         goto cas9;
           end;
         if (copy(st1.Cells[6,2], 0, 1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0, 1)<>st1.Cells[7,1])
               and(copy(st1.Cells[6,4], 0, 1)<>st1.Cells[7,1])then
              begin
                st1.Cells[7,2]:=st1.Cells[7,1]+'-';
                st1.Cells[7,3]:=copy(st1.Cells[6,3], 0, 1)+'+';
                st1.Cells[7,4]:=copy(st1.Cells[6,4], 0, 1)+'-'+'<-';


               DP:=DP+1;
               st1.Cells[7,5]:='DP';
               goto cas9;
                end;
end;
 cas87: if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0, 1)=st1.Cells[7,1])
            or (copy(st1.Cells[6,3], 0, 1)=st1.Cells[7,1])
               or (copy(st1.Cells[6,4], 0, 1)=st1.Cells[7,1])then
              begin
                st1.Cells[7,2]:=st1.Cells[6,2];
                st1.Cells[7,3]:=st1.Cells[6,3];
                st1.Cells[7,4]:=st1.Cells[6,4];

               goto cas9;
                 end;
            if (copy(st1.Cells[6,2], 0, 1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0, 1)<>st1.Cells[7,1])
               and(copy(st1.Cells[6,4], 0, 1)<>st1.Cells[7,1])then
              begin
                st1.Cells[7,2]:=copy(st1.Cells[6,2], 0, 1)+'-'+' <-';
                st1.Cells[7,3]:=copy(st1.Cells[6,3], 0, 1)+'-';
                st1.Cells[7,4]:=copy(st1.Cells[7,1], 0, 1)+'+';

               DP:=DP+1;
               st1.Cells[7,5]:='DP';
               goto cas9;
               end;
end;
cas88: if (st1.cells[7,1]<> '') then
          begin
           if (copy(st1.Cells[6,2], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=copy(st1.Cells[6,2], 0, 1)+'+';
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
             end;
           if (copy(st1.Cells[6,3], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=copy(st1.Cells[6,3], 0, 1)+'+';
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
              end;
            if (copy(st1.Cells[6,4], 0, 1)=st1.Cells[7,1]) then
            begin
             st1.Cells[7,2]:=st1.Cells[6,2];
             st1.Cells[7,3]:=st1.Cells[6,3];
             st1.Cells[7,4]:=st1.Cells[6,4];

            goto cas9;
             end;
           if (copy(st1.Cells[6,2], 0, 1)<>st1.Cells[7,1])
            and (copy(st1.Cells[6,3], 0, 1)<>st1.Cells[7,1])
               and(copy(st1.Cells[6,4], 0, 1)<>st1.Cells[7,1])then
              begin
               st1.Cells[7,2]:=st1.Cells[7,1]+'+';
               st1.Cells[7,3]:=st1.Cells[6,3]+' <-';
               st1.Cells[7,4]:=st1.Cells[6,4];

              DP:=DP+1;
               st1.Cells[7,5]:='DP';
              goto cas9;
              end;
  end;
end;

 cas9:for i:= 1 to 5 do
    if SgDP.Cells[i, 0] = '' then break;

  SgDP.Cells[i, 0] := IntToSTr(Taille);
  SgDP.Cells[i, 1] := IntToSTr(DP);
end;

procedure TfrmGesMem.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnAjouterClick(Nil)
end;

procedure TfrmGesMem.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnFixerClick(Nil)
end;

procedure TfrmGesMem.btnRepdrendreClick(Sender: TObject);
var
  i,j: integer;
begin
  for i:= 0 to 7 do
    for j:= 0 to 5 do
      St1.Cells[i,j] := '';
  nadr:=-1;
  Edit1.Clear;
  Edit2.Clear;
  for i:= 1 to 7 do
    for j:= 0 to 1 do
      SgDP.Cells[i,j] := '';
  btnAjouter.Enabled := True;
end;

procedure TfrmGesMem.btnGraphClick(Sender: TObject);
begin
  with FrmGraphe do
    begin
      SG_Res.Cells[1,1]:= SgDP.Cells[1, 0];
      SG_Res.Cells[1,2]:= SgDP.Cells[2, 0];
      SG_Res.Cells[1,3]:= SgDP.Cells[3, 0];
      SG_Res.Cells[1,4]:= SgDP.Cells[4, 0];
      SG_Res.Cells[1,5]:= SgDP.Cells[5, 0];
      SG_Res.Cells[2,1]:= SgDP.Cells[1, 1];
      SG_Res.Cells[2,2]:= SgDP.Cells[2, 1];
      SG_Res.Cells[2,3]:= SgDP.Cells[3, 1];
      SG_Res.Cells[2,4]:= SgDP.Cells[4, 1];
      SG_Res.Cells[2,5]:= SgDP.Cells[5, 1];
    end;
  FrmGraphe.Show
end;

procedure TfrmGesMem.btnInitialClick(Sender: TObject);
var
  i,j: integer;
begin
    for i:= 0 to 19 do
    for j:= 1 to 5 do
      St1.Cells[i,j] := '';
  Edit1.Clear;
  Edit2.Clear;
end;

procedure TfrmGesMem.btnSauveClick(Sender: TObject);
var
  Fichier : TIniFile;
begin
  if SD.Execute then
    begin
      Fichier := TIniFile.Create(SD.Filename);
      try
        Fichier.WriteInteger('Taille','T(1,1)',StrToInt(SgDP.Cells[1,0]));
        Fichier.WriteInteger('Taille','T(1,2)',StrToInt(SgDP.Cells[2,0]));
        Fichier.WriteInteger('Taille','T(1,3)',StrToInt(SgDP.Cells[3,0]));
        Fichier.WriteInteger('Taille','T(1,4)',StrToInt(SgDP.Cells[4,0]));
        Fichier.WriteInteger('Taille','T(1,5)',StrToInt(SgDP.Cells[5,0]));
        Fichier.WriteInteger('Defaut','T(2,1)',StrToInt(SgDP.Cells[1,1]));
        Fichier.WriteInteger('Defaut','T(2,2)',StrToInt(SgDP.Cells[2,1]));
        Fichier.WriteInteger('Defaut','T(2,3)',StrToInt(SgDP.Cells[3,1]));
        Fichier.WriteInteger('Defaut','T(2,4)',StrToInt(SgDP.Cells[4,1]));
        Fichier.WriteInteger('Defaut','T(2,5)',StrToInt(SgDP.Cells[5,1]));
      finally
        Fichier.Free;
      end;
    end;
end;

procedure TfrmGesMem.ImgBordureHD3Click(Sender: TObject);
begin
  Close
end;

procedure TfrmGesMem.ImgBordureHD1Click(Sender: TObject);
begin
Application.Minimize
end;

procedure TfrmGesMem.ImgBordureHG2Click(Sender: TObject);
begin
  PopupMenu1.Popup( Left+ImgBordureHG2.Left , Top+ImgBordureHG2.Height );
end;

procedure TfrmGesMem.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := True;
  SourisDown_X := X;
  SourisDown_Y := Y;
end;

procedure TfrmGesMem.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
  If SourisDown=True Then
    Begin
      Left := Left + X - SourisDown_X;
      Top := Top + Y - SourisDown_Y;
    End;
end;

procedure TfrmGesMem.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SourisDown := False;
end;
end.
