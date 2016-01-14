unit UGesMem;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, Buttons ;
type
  TfrmGesMem = class(TForm)
    btnAjouter: TButton;
    btnFixer: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    btnFermer: TBitBtn;
    btnSimuler: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    gbResultats: TGroupBox;
    SgDP: TStringGrid;
    btnInitialiser: TButton;
    btnGraph: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    St1: TStringGrid;
    procedure btnAjouterClick(Sender: TObject);


    procedure btnFixerClick(Sender: TObject);
    Procedure btnFermerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSimulerClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure btnInitialiserClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;
var
frmGesMem: TfrmGesMem;
nadr, Taille:integer;
M:array[0..4,0..10]of integer;
implementation
{$R *.dfm}
procedure TfrmGesMem.btnAjouterClick(Sender: TObject);
begin
if(nadr<>10)then
begin
nadr:=nadr+1;
M[0,nadr]:=strtoint(edit1.Text);
st1.Cells[nadr,0]:=edit1.Text;
end
else
showmessage(' le nombre adresse <10');
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
  for j:=0 to 9 do
    st1.Cells[j,i]:='';
  btnAjouter.Enabled := False;
end;

procedure TfrmGesMem.btnFermerClick(Sender: TObject);
begin
close;
end;

procedure TfrmGesMem.FormCreate(Sender: TObject);
begin
 nadr:=-1;
 SgDP.Cells[0, 0] := 'Taille';
 SgDP.Cells[0, 1] := 'DP';
end;

procedure TfrmGesMem.btnSimulerClick(Sender: TObject);
label Cas1, Cas2, Cas3, Cas4, Cas5, cas6;
var DP, i:integer;
begin
 cas1: DP:=1;
  st1.Cells[0,5]:='DP';
  st1.Cells[0,2]:=st1.Cells[0,1]+'+'+'<-' ;

 cas2:if ( st1.Cells[0,1] <> st1.cells[1,1] ) then
    begin
      st1.Cells[1,2]:=st1.Cells[0,2];
      st1.Cells[1,3]:=st1.Cells[1,1]+'+' ;
      DP:=DP+1;
      st1.Cells[1,5] :='DP';
    end
  else
    st1.Cells[1,2]:=st1.Cells[0,2];

  cas3:if (st1.cells[2,1]<> '') then
    begin
    if (st1.cells[1,1]<>st1.cells[2,1])
        and (st1.cells[0,1]<>st1.cells[2,1])then
          begin
            st1.Cells[2,2]:=st1.Cells[1,2] ;
            st1.Cells[2,3]:=st1.Cells[1,3] ;
            st1.Cells[2,4]:=st1.Cells[2,1]+'+' ;
            DP:=DP+1;
            st1.Cells[2,5]:='DP';
          end
        else
          begin
            st1.Cells[2,2]:= copy(st1.Cells[1,2], 0, 2);
            st1.Cells[2,3]:=st1.Cells[1,3]+'<-' ;
          end;
    end;

 cas4: if (st1.cells[3,1]<> '') then
    begin
      if (copy(st1.Cells[2,2], 0, 1)=st1.Cells[3,1])
        or (copy(st1.Cells[2,3], 0, 1)=st1.Cells[3,1])
          or (copy(st1.Cells[2,4], 0, 1)=st1.Cells[3,1]) then
            begin
            if(st1.Cells[3,1]= copy(st1.Cells[2,2], 0, 1))then
              begin
              st1.Cells[3,2]:=copy(st1.Cells[2,2], 0, 2);
              st1.Cells[3,3]:=st1.Cells[2,3]+'<-';
              st1.Cells[3,4]:=st1.Cells[2,4];
              {goto Cas6; }
              end;

             if (copy(st1.Cells[2,3], 0, 1)=st1.Cells[3,1])
                or (copy(st1.Cells[2,4], 0, 1)=st1.Cells[3,1]) then
            begin
                st1.Cells[3,2]:=st1.Cells[2,2];
              st1.Cells[3,3]:=st1.Cells[2,3];
              st1.Cells[3,4]:=st1.Cells[2,4];
             end;

          end;
      if (st1.Cells[2,3]= '') then
        begin
          if (st1.Cells[2,1]<>st1.Cells[3,1]) then
            begin
              st1.Cells[3,3]:=st1.Cells[3,1]+ '+';
              st1.Cells[3,2]:=st1.Cells[2,2];
              DP:=DP+1;
              st1.Cells[3,5]:='DP';
            end
          else
            begin
              st1.Cells[3,2]:=st1.Cells[2,2];
              st1.Cells[3,3]:=st1.Cells[2,3];
            end;
        end
      else if (st1.Cells[2,4]='') then
        begin
          st1.Cells[3,2]:=st1.Cells[2,2];
          st1.Cells[3,3]:=st1.Cells[2,3];
          st1.Cells[3,4]:=st1.Cells[3,1]+'+' ;
          DP:=DP+1;
          st1.Cells[3,5]:='DP';
        end;

      if(st1.Cells[2,3]<>'')and(st1.Cells[2,4]<>'')then
        begin
          if (st1.Cells[3,1]<>st1.Cells[0,1])
            and (st1.Cells[3,1]<>st1.Cells[1,1])
              and (st1.Cells[3,1]<>st1.Cells[2,1]) then
                begin
                  st1.Cells[3,2]:= st1.Cells[3,1] + '+'  ;
                  st1.Cells[3,3]:=copy(st1.Cells[2,3], 0, 1) + '-'+ '<-' ;
                  st1.Cells[3,4]:=copy(st1.Cells[2,4], 0, 1) + '-';
                DP:=DP+1;
                 st1.Cells[3,5]:='DP';
                end ;
        end ;
    end;

  Cas6: if (st1.cells[4,1]<> '') then //5
          begin

              if (copy(st1.Cells[3,3], 0, 1)=st1.Cells[4,1]) then
                  begin
                    st1.Cells[4,2]:=st1.Cells[3,2];
                    st1.Cells[4,3]:=copy(st1.Cells[3,3], 0, 1)+'+';
                    st1.Cells[4,4]:=st1.Cells[3,4]+'<-';
                    goto Cas6;
                  end;
                if (copy(st1.Cells[3,2], 0, 1)=st1.Cells[4,1]) then
                  begin
                    st1.Cells[4,2]:=st1.Cells[3,2];
                    st1.Cells[4,3]:=st1.Cells[3,3];
                    st1.Cells[4,4]:=st1.Cells[3,4];

                  end;
           if (copy(st1.Cells[3,4], 0, 1)=st1.Cells[4,1]) then
                  begin
                    st1.Cells[4,2]:=st1.Cells[3,2];
                    st1.Cells[4,3]:=st1.Cells[3,3];
                    st1.Cells[4,4]:=copy(st1.Cells[3,4], 0, 1)+'+';

                  end;
              if (copy(st1.Cells[3,2], 0, 1)<>st1.Cells[4,1])
        and (copy(st1.Cells[3,3], 0, 1)<>st1.Cells[4,1])
          and (copy(st1.Cells[3,4], 0, 1)<>st1.Cells[4,1]) then
            begin
            st1.Cells[4,2]:=st1.Cells[3,2];
                    st1.Cells[4,3]:=st1.Cells[4,1]+'+';
                    st1.Cells[4,4]:=copy(st1.Cells[3,4], 0, 1)+ '-' + '<-';
                        DP:=DP+1;
                     st1.Cells[4,5]:='DP';
               end;

      st1.Cells[5,2]:=st1.Cells[4,2];
      st1.Cells[5,3]:=st1.Cells[4,3];
       st1.Cells[5,4]:=st1.Cells[4,4];
      st1.Cells[6,2]:=st1.Cells[4,2];
                    st1.Cells[6,3]:=st1.Cells[4,3]+'<-';
                    st1.Cells[6,4]:=copy(st1.Cells[4,4], 0, 1)+'+';
     st1.Cells[7,2]:=st1.Cells[4,2];
                    st1.Cells[7,3]:=st1.Cells[6,3];
                    st1.Cells[7,4]:=st1.Cells[6,4];

  end;

 for i:= 1 to 5 do
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

procedure TfrmGesMem.btnInitialiserClick(Sender: TObject);
var
  i,j: integer;
begin
  for i:= 0 to 19 do
    for j:= 1 to 5 do
      St1.Cells[i,j] := '';
  Edit1.Clear;
  Edit2.Clear;
end;

procedure TfrmGesMem.BitBtn1Click(Sender: TObject);
var
  i,j: integer;
begin
  for i:= 0 to 19 do
    for j:= 0 to 5 do
      St1.Cells[i,j] := '';
  Edit1.Clear;
  Edit2.Clear;
  for i:= 1 to 19 do
    for j:= 0 to 1 do
      SgDP.Cells[i,j] := '';
  btnAjouter.Enabled := True;
end;

end.
