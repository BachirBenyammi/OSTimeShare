unit UAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TFrmAbout = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Image4: TImage;
    btnFermer: TBitBtn;
    procedure Image3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure WMNCHitTest(var LeMessage: TWMNCHitTest); message wm_NCHitTest; 
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

procedure TFrmAbout.WMNCHitTest(var LeMessage: TWMNCHitTest);
begin
  inherited;
  with LeMessage do
    if Result = HTCLIENT then
      Result := htCaption;
end;

procedure TFrmAbout.Image3Click(Sender: TObject);
begin
  close
end;

procedure TFrmAbout.FormCreate(Sender: TObject);
begin
  SetWindowRgn(handle, CreateRoundRectRgn(0,0, Width, Height, 160, 160), true);
end;

end.
