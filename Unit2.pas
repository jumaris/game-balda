unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  QDialogs,StdCtrls, ComCtrls, ExtCtrls;


type
  tarraymaskstring = array [0..200000] of string;
  tarraymaskinteger = array [0..200000] of byte;
  ta255=array of string;
  TPlayer = record
   s:array [0..99] of string;
   si:integer;
   enable:boolean;
   computer:boolean;
  end;
  TDictionary = class
   public
   data:array [0..60] of ta255;
   procedure open;
   procedure save;
   procedure add(ins:string);
   procedure Delete(ins:string);
   function Searching(ins:string; var i:integer):string;
  end;

  TPlayers = class
   public
   Current:integer;
   Player:array [0..5] of TPlayer;
   procedure start;
   function turn(ins,char:string;a,b:integer):boolean;
  end;

  TPoleWord = class
   constructor create;
   public
   pole:array [1..10,1..10] of string[1];
   x,y:byte;
  end;

  TMaskWord = class
   constructor create;
   public
   s:tarraymaskstring;
   x,y:tarraymaskinteger;
   count:integer;
   procedure Refresh(inPoleWord:TPoleWord);
   function Searching(ins:string;first:integer):integer;
  end;


  TForm2 = class(TForm)
    ProgressBar1: TProgressBar;
    PaintBox1: TPaintBox;
    Edit1: TEdit;
    CurPlaLab: TShape;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
   { Private declarations }
  public
   { Public declarations }
   CompI:Integer;
   TempPoleWord:array [1..10,1..10] of string[1];
   MaskWord:TMaskWord;
   PoleWord:TPoleWord;
   Players:TPlayers;
   Dictionary:TDictionary;
   procedure MyIdle(Sender: TObject; var Done: Boolean);

  end;

var
  Form2: TForm2;

implementation

uses Unit1, Unit3;

{$R *.dfm}

constructor TPoleWord.create;
var
 i,j:integer;
begin
 for i:=1 to 10 do  for j:=1 to 10 do Pole[i,j]:='_';
end;

constructor TMaskWord.create;
var
 i:integer;
begin
 for i:=0 to sizeof(x)-1 do
 begin
  x[i]:=0;
  y[i]:=0;
 end;
end;

procedure TMaskWord.Refresh;
type
 tmask=array [1..10,1..10] of bytebool;
var
 maxlength:integer;
procedure Recur(a,b,c,d:integer;xs:string;mask:tmask);
 var
  i,j:integer;
 begin
  mask[a,b]:=false;
  xs:=xs+InPoleWord.Pole[a,b];
  j:=0;
  for i:=1 to length(xs) do if xs[i]='_' then j:=j+1;
  if j<2 then
  begin
   if j=1 then
   begin

    s[count]:=xs;
    if c=0 then
     begin
      c:=a;
      d:=b;
     end;
    x[count]:=c;
    y[count]:=d;
    if length(xs)>1 then
    begin
     count:=count+1;
     if maxlength<length(xs) then  maxlength:=length(xs);
    end;
   end;
   if (a<InPoleWord.x) and mask[a+1,b] then recur(a+1,b,c,d,xs,mask);
   if (a>1) and mask[a-1,b] then recur(a-1,b,c,d,xs,mask);
   if (b<InPoleWord.y) and mask[a,b+1] then recur(a,b+1,c,d,xs,mask);
   if (b>1) and mask[a,b-1] then recur(a,b-1,c,d,xs,mask);
  end;
end;
var
 i,j,k:integer;
 mask:tmask;
 temps:tarraymaskstring;
 tempx,tempy:tarraymaskinteger;
begin
 count:=0;
 maxlength:=0;
 for i:=1 to 10 do for j:=1 to 10 do mask[i,j]:=true;
 for i:=1 to InPoleWord.x do
 for j:=1 to InPoleWord.y do
  begin
   recur(i,j,0,0,'',mask);
   Form2.ProgressBar1.Position:=
    round(((i-1)*InPoleWord.y+j)/(InPoleWord.x*InPoleWord.y));
  end;
  k:=0;
  for i:=maxlength downto 2 do
   for j:=0 to count do
    if length(s[j])=i then
     begin
      temps[k]:=s[j];
      tempx[k]:=x[j];
      tempy[k]:=y[j];
      k:=k+1;
      s[j]:='';
     end;
  s:=temps;
  x:=tempx;
  y:=tempy;
end;

function TMaskWord.Searching;
var
 i,j,k:integer;
begin
 i:=first;
 k:=0;
 repeat
  if length(s[i])=length(ins) then
   begin
    k:=0;
    for j:=1 to length(ins) do
     if ins[j]<>s[i][j] then k:=k+1;
   end;
 i:=i+1;
 until (k=1) or (i>count);
 if i>count then i:=0;
 Result:=i-1;
end;



procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if ord(MessageDlg('Сохронить словарь?',mtConfirmation ,
                         [mbYes, mbNo],0))=3 then form2.Dictionary.save;

 Application.Terminate;
end;

procedure TForm2.PaintBox1Paint(Sender: TObject);
var
 i,j:integer;
 rect:TRect;
begin

 PaintBox1.Canvas.Brush.Color:=clBlue;
 PaintBox1.Canvas.Brush.Style:=bsSolid;
 for i:=1 to PoleWord.x do
  for j:=1 to PoleWord.y do
   begin
    rect.Left:=(i-1)*(PaintBox1.Width div PoleWord.x)+1;
    rect.Right:=(i)*(PaintBox1.Width div PoleWord.x);
    rect.Top:=(j-1)*(PaintBox1.Height div PoleWord.y)+1;
    rect.Bottom:=(j)*(PaintBox1.Height div PoleWord.y);
    PaintBox1.Canvas.FillRect(rect);
    PaintBox1.Canvas.Font.Size:=22;
    if PoleWord.pole[i,j]<>'_' then
    PaintBox1.Canvas.TextOut((i-1)*(PaintBox1.Width div PoleWord.x)+1,
                             (j-1)*(PaintBox1.Height div PoleWord.y)+1,
                             PoleWord.pole[i,j]);

   end;

 PaintBox1.Canvas.Brush.Color:=clRed;

 for i:=1 to 10 do for j:=1 to 10 do temppoleword[i,j]:='';
 i:=0;
 if length(Edit1.Text)>1 then
 repeat
  i:=MaskWord.Searching(Edit1.Text,i);
  if i>=0 then
   begin
    j:=1;
    while Edit1.Text[j]=MaskWord.s[i][j] do j:=j+1;
    rect.Left:=(maskword.x[i]-1)*(PaintBox1.Width div PoleWord.x)+1;
    rect.Right:=(maskword.x[i])*(PaintBox1.Width div PoleWord.x);
    rect.Top:=(maskword.y[i]-1)*(PaintBox1.Height div PoleWord.y)+1;
    rect.Bottom:=(maskword.y[i])*(PaintBox1.Height div PoleWord.y);
    PaintBox1.Canvas.FillRect(rect);
    temppoleword[maskword.x[i],maskword.y[i]]:=Edit1.Text[j];
    PaintBox1.Canvas.Font.Size:=20;
    PaintBox1.Canvas.TextOut((maskword.x[i]-1)*(PaintBox1.Width div PoleWord.x)+1,
                            (maskword.y[i]-1)*(PaintBox1.Height div PoleWord.y)+1,
                             Edit1.Text[j]);

   end;
  i:=i+1
 until i=0;


end;


procedure TForm2.FormCreate(Sender: TObject);
begin

 Application.OnIdle:=MyIdle;
 PoleWord:=TPoleWord.Create;            {Test}
 Dictionary:=TDictionary.Create;
 MaskWord:=TMaskWord.Create;
 Players:=TPlayers.Create;
end;


procedure TForm2.Edit1Change(Sender: TObject);
begin
 PaintBox1.repaint;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
 PoleWord.x:=form1.TrackBar1.Position;
 PoleWord.y:=form1.TrackBar2.Position;
 Players.start;
end;


procedure TForm2.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin

end;

{ TPlayers }

procedure TPlayers.start;
var
 i:integer;
begin
 Form2.Dictionary.open;

 i:=0;
 if form2.Dictionary.Searching(form1.Edit1.Text,i)<>form1.Edit1.Text then
  if ord(MessageDlg('Добавить слово '+form1.Edit1.Text+' в словарь?',mtConfirmation ,
                         [mbYes, mbNo],0))=3 then form2.Dictionary.add(form1.Edit1.Text);

 if Length(form1.Edit1.Text)<4 then form1.Edit1.Text:='Привет';
 for i:=1 to length(form1.Edit1.Text) do
     Form2.PoleWord.pole[i,(length(form1.Edit1.Text) div 2)+1]:=form1.Edit1.Text[i];

 form2.maskword.Refresh(Form2.PoleWord);
 Player[1].enable:=Form1.CheckBox1.State<>cbUnchecked;
 Player[1].computer:=Form1.CheckBox1.State=cbGrayed;
 Player[1].si:=0;

 Player[2].enable:=Form1.CheckBox2.State<>cbUnchecked;
 Player[2].computer:=Form1.CheckBox2.State=cbGrayed;
 Player[2].si:=0;

 Player[3].enable:=Form1.CheckBox3.State<>cbUnchecked;
 Player[3].computer:=Form1.CheckBox3.State=cbGrayed;
 Player[3].si:=0;

 Player[4].enable:=Form1.CheckBox4.State<>cbUnchecked;
 Player[4].computer:=Form1.CheckBox4.State=cbGrayed;
 Player[4].si:=0;


 if Player[4].enable then current:=4;
 if Player[3].enable then current:=3;
 if Player[2].enable then current:=2;
 if Player[1].enable then current:=1;
 if current=1 then  Form2.CurPlaLab.Brush.Color:=clBlue;
 if current=2 then  Form2.CurPlaLab.Brush.Color:=clGreen;
 if current=3 then  Form2.CurPlaLab.Brush.Color:=clRed;
 if current=4 then  Form2.CurPlaLab.Brush.Color:=clBlack;

end;

function TPlayers.turn;
var
 offturn:boolean;
 i,j:integer;
begin
 offturn:=false;
 for i:=1 to 4 do
  for j:=0 to Player[i].si-1 do
   if Player[i].s[j]=ins then offturn:=true;
 if ins=form1.Edit1.Text then offturn:=true;

 if ins='Game Over' then
  begin
   offturn:=true;
   Form2.Hide;
   Form1.Show;
   Form1.Edit1.Text:='No word:-('
  end;

 if not (offturn) then
 begin
 if(Player[current].computer) then
 begin
  if ord(MessageDlg('Можно сходить словом '+ins+'?',mtConfirmation ,
                         [mbYes, mbNo],0))<>3 then
                                               begin
                                                Offturn:=true;
                                                Form2.Dictionary.Delete(ins);
                                               end
 end
 else
 begin
  i:=0;
  if form2.Dictionary.Searching(ins,i)<>ins then
  if ord(MessageDlg('Добавить слово '+ins+' в словарь?',mtConfirmation ,
                         [mbYes, mbNo],0))=3 then form2.Dictionary.add(ins);
 end
 end;
 if not offturn then
 begin
  Form2.PoleWord.Pole[a,b]:=char;
  Form2.MaskWord.Refresh(Form2.PoleWord);
  Form2.Edit1.Text:='';

  Player[current].s[Player[current].si]:=ins;
  form2.Memo1.Lines.Add( 'Player '+InttoStr(Current)+' :'
                          +ins+'-'+IntToStr(length(Ins)) );

  Player[current].si:=Player[current].si+1;
  current:=current+1;
  if current=5 then current:=1;
  while not Player[current].enable do
   if current=4 then current:=1 else Current:=Current+1;
  if current=1 then  Form2.CurPlaLab.Brush.Color:=clBlue;
  if current=2 then  Form2.CurPlaLab.Brush.Color:=clGreen;
  if current=3 then  Form2.CurPlaLab.Brush.Color:=clRed;
  if current=4 then  Form2.CurPlaLab.Brush.Color:=clBlack;
  if Player[current].computer then Form2.Edit1.Hide else Form2.Edit1.Show;
  Form2.CompI:=0;
  Form2.PaintBox1.Repaint;
 end;
 result:=not offturn;
end;

{ TDictionary }

procedure TDictionary.add(ins: string);
var
 len,lins,temp:integer;
begin
 temp:=0;
 if searching(ins,temp)<>ins then
 begin
  lins:=length(ins);
  len:=length(data[lins]);
  SetLength(data[lins],len+1);
  data[lins,len]:=ins;
 end;
end;

procedure TDictionary.Delete(ins: string);
var
 lendata,lins,i,j:integer;
 s:string;
begin
 lins:=length(ins);
 lendata:=length(data[lins]);
 i:=0;
 s:=Searching(ins,i);
 if s=ins then
  begin
   for j:=i to lendata-2 do data[lins,j]:=data[lins,j+1];
   setlength(data[lins],lendata-1);
  end;

end;

procedure TDictionary.open;
var
 f:text;
 s:string;
begin
 assign(f,'Dic.dat');
 reset(f);
 while not eof(f) do
 begin
  readln(f,s);
  form2.Dictionary.add(s);
 end;
 close(f);


end;

procedure TDictionary.save;
var
 f:text;
 i,j:integer;
begin
 assign(f,'Dic.dat');
 rewrite(f);
 for i:=0 to 60 do
  if length(data[i])>0 then
    for j:=0 to length(data[i])-1 do writeln(f,data[i,j]);
 close(f);
end;

function TDictionary.Searching(ins: string; var i:integer): string;
var
 lendata,lins,j,k:integer;
begin
 lins:=length(ins);
 lendata:=length(data[lins]);

 k:=2;
 if (lendata>0) and (i<lendata) then
 repeat
   k:=0;
   for j:=1 to lins do if data[lins,i,j]<>ins[j] then k:=k+1;
   i:=i+1;
 until (i=lendata) or (k<2);

 if (k<2) and (lendata>0) then
 begin
  i:=i-1;
  result:=data[lins,i]
 end
 else result:='';
end;

procedure TForm2.MyIdle(Sender: TObject; var Done: Boolean);
var
 ts:string;
 i,j,k:integer;
 b:boolean;
begin
 if form2.Visible and (Players.Player[Players.Current].computer) then
 begin
  i:=compI;
  compI:=compI+1;
  if I=100000 then Players.turn('Game Over','',0,0);;
  k:=0;
  repeat
  ts:=Dictionary.Searching(Maskword.s[I],k);
  b:=false;
  if ts<>'' then
  begin
   j:=1;
   while ts[j]=MaskWord.s[i][j] do j:=j+1;
   b:=Players.turn(ts,ts[j],MaskWord.x[i],MaskWord.y[i]);
  end;
  k:=k+1;
  until (ts='') or b;
  done:=false;

 end
 else  done:=true;

end;

procedure TForm2.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

var
 x1,y1:integer;
begin
  if ssLeft in Shift  then
  begin
   x1:=(X div (PaintBox1.Width div PoleWord.x))+1;
   y1:=(Y div (PaintBox1.Height div PoleWord.y))+1;
   if TempPoleWord[x1,y1]<>'' then
    begin
     Players.turn(Edit1.Text,TempPoleWord[x1,y1],x1,y1);
    end;
  end;

end;

procedure TForm2.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 x,y,i,j,k:integer;
 s:string[1];

begin
 if key=VK_RETURN	 then
 begin
 k:=0;
 for i:=1 to form2.PoleWord.x do for j:=1 to form2.PoleWord.y do
 if TempPoleWord[i,j]<>'' then
  begin
   s:=TempPoleWord[i,j];
   x:=i;
   y:=j;
   k:=k+1;
  end;
 if k=1 then Players.turn(Edit1.Text,s,x,y);
 end;

end;

end.
