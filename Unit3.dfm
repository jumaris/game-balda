object OKBottomDlg: TOKBottomDlg
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 124
  ClientWidth = 313
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 297
    Height = 65
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 281
    Height = 49
    AutoSize = False
  end
  object OKBtn: TButton
    Left = 79
    Top = 92
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 159
    Top = 92
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = CancelBtnClick
  end
end
