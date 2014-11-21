object Form2: TForm2
  Left = 482
  Top = 48
  Width = 510
  Height = 433
  Caption = 'Balda'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 8
    Top = 8
    Width = 353
    Height = 353
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
    OnPaint = PaintBox1Paint
  end
  object CurPlaLab: TShape
    Left = 368
    Top = 48
    Width = 65
    Height = 57
    Shape = stCircle
  end
  object ProgressBar1: TProgressBar
    Left = 368
    Top = 12
    Width = 121
    Height = 33
    DragMode = dmAutomatic
    Max = 200
    Smooth = True
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 8
    Top = 368
    Width = 353
    Height = 21
    TabStop = False
    AutoSize = False
    BevelOuter = bvSpace
    CharCase = ecUpperCase
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyUp = Edit1KeyUp
  end
  object Memo1: TMemo
    Tag = -1
    Left = 368
    Top = 112
    Width = 121
    Height = 281
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
