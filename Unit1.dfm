object Form1: TForm1
  Left = 156
  Top = 103
  Width = 280
  Height = 386
  Caption = 'Balda Menu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 8
    Top = 32
    Width = 225
    Height = 225
    OnPaint = PaintBox1Paint
  end
  object Label1: TLabel
    Left = 16
    Top = 288
    Width = 33
    Height = 16
    Caption = 'Word'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object TrackBar1: TTrackBar
    Left = 0
    Top = 0
    Width = 241
    Height = 25
    Min = 4
    PageSize = 1
    Position = 5
    TabOrder = 0
    TickStyle = tsNone
    OnChange = TrackBar1Change
  end
  object TrackBar2: TTrackBar
    Left = 240
    Top = 24
    Width = 25
    Height = 241
    Min = 4
    Orientation = trVertical
    PageSize = 1
    Position = 5
    TabOrder = 1
    TickMarks = tmTopLeft
    TickStyle = tsNone
    OnChange = TrackBar2Change
  end
  object Button1: TButton
    Left = 192
    Top = 288
    Width = 73
    Height = 25
    Caption = 'New game'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 320
    Width = 73
    Height = 25
    Caption = 'Exit'
    TabOrder = 3
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 264
    Width = 65
    Height = 17
    AllowGrayed = True
    Caption = 'Player1'
    Checked = True
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    State = cbChecked
    TabOrder = 4
  end
  object CheckBox2: TCheckBox
    Left = 72
    Top = 264
    Width = 65
    Height = 17
    AllowGrayed = True
    Caption = 'Player2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbGrayed
    TabOrder = 5
  end
  object CheckBox3: TCheckBox
    Left = 136
    Top = 264
    Width = 65
    Height = 17
    AllowGrayed = True
    Caption = 'Player3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object CheckBox4: TCheckBox
    Left = 200
    Top = 264
    Width = 65
    Height = 17
    AllowGrayed = True
    Caption = 'Player4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object Button3: TButton
    Left = 8
    Top = 320
    Width = 57
    Height = 25
    Caption = 'Help'
    TabOrder = 8
  end
  object Edit1: TEdit
    Tag = 1
    Left = 56
    Top = 288
    Width = 121
    Height = 21
    AutoSize = False
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 9
    OnChange = Edit1Change
    OnKeyUp = Edit1KeyUp
  end
end
