unit Unit3;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TOKBottomDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
   Chose:boolean;
    { Public declarations }
  end;

var
  OKBottomDlg: TOKBottomDlg;

implementation

uses Unit2;

{$R *.dfm}

procedure TOKBottomDlg.OKBtnClick(Sender: TObject);
begin
 OKBottomDlg.Hide;
 Chose:=true;

end;

procedure TOKBottomDlg.CancelBtnClick(Sender: TObject);
begin
 OKBottomDlg.Hide;
end;

procedure TOKBottomDlg.FormHide(Sender: TObject);
begin
 form2.Enabled:=true;
end;

procedure TOKBottomDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 form2.Enabled:=true;
end;

procedure TOKBottomDlg.FormShow(Sender: TObject);
begin
 chose:=false;
end;

end.
