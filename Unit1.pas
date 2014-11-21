unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  QDialogs, StdCtrls, Spin, ComCtrls, ExtCtrls, Unit2;

type
  TForm1 = class(TForm)
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    Button1: TButton;
    PaintBox1: TPaintBox;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Button3: TButton;
    Edit1: TEdit;
    Label1: TLabel;

    procedure PaintBox1Paint(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.PaintBox1Paint(Sender: TObject);
var
 i,j:integer;
 rect:TRect;
begin
 PaintBox1.Canvas.Brush.Color:=clBlue;
 PaintBox1.Canvas.Brush.Style:=bsSolid;
 for i:=1 to TrackBar1.Position do
  for j:=1 to TrackBar2.Position do
   begin
    rect.Left:=(i-1)*(PaintBox1.Width div TrackBar1.Position)+1;
    rect.Right:=(i)*(PaintBox1.Width div TrackBar1.Position);
    rect.Top:=(j-1)*(PaintBox1.Height div TrackBar2.Position)+1;
    rect.Bottom:=(j)*(PaintBox1.Height div TrackBar2.Position);
    PaintBox1.Canvas.FillRect(rect);
   end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
 PaintBox1.Repaint;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
 PaintBox1.Repaint;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Form1.Hide;
 Form2.show;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Application.Terminate; 
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
 TrackBar1.Position:=length(Form1.Edit1.Text);
 TrackBar2.Position:=length(Form1.Edit1.Text);
end;

procedure TForm1.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=VK_RETURN	 then form1.Button1Click(Sender);
end;

end.
