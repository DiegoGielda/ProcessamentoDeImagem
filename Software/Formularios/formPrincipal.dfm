object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Opera'#231#245'es Aritm'#233'ticas e L'#243'gicas em Imagens'
  ClientHeight = 378
  ClientWidth = 1344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gbImagemA: TGroupBox
    Left = 8
    Top = 7
    Width = 353
    Height = 305
    Caption = 'Imagem A'
    TabOrder = 0
    object imagemA: TImage
      Left = 8
      Top = 16
      Width = 335
      Height = 281
      Center = True
      Stretch = True
    end
  end
  object gbImagemB: TGroupBox
    Left = 407
    Top = 7
    Width = 353
    Height = 305
    Caption = 'Imagem B'
    TabOrder = 1
    object imagemB: TImage
      Left = 8
      Top = 16
      Width = 335
      Height = 281
      Center = True
      Stretch = True
    end
  end
  object btnCarregarImagemA: TButton
    Left = 87
    Top = 318
    Width = 145
    Height = 49
    Caption = 'Carregar imagem A'
    TabOrder = 2
  end
  object btnCarregarImagemB: TButton
    Left = 495
    Top = 318
    Width = 145
    Height = 49
    Caption = 'Carregar imagem B'
    TabOrder = 3
  end
  object gbOperacoesAritmeticas: TGroupBox
    Left = 766
    Top = 8
    Width = 193
    Height = 202
    Caption = 'Opera'#231#245'es Aritim'#233'ticas'
    TabOrder = 4
    object btnAdicao: TButton
      Left = 14
      Top = 16
      Width = 96
      Height = 25
      Caption = 'Adi'#231#227'o'
      TabOrder = 0
    end
    object btnSubtracao: TButton
      Left = 14
      Top = 47
      Width = 96
      Height = 25
      Caption = 'Subtra'#231#227'o'
      TabOrder = 1
    end
    object btnMultiplicacao: TButton
      Left = 14
      Top = 78
      Width = 96
      Height = 25
      Caption = 'Multiplica'#231#227'o'
      TabOrder = 2
    end
    object btnDivisao: TButton
      Left = 14
      Top = 109
      Width = 96
      Height = 25
      Caption = 'Divis'#227'o'
      TabOrder = 3
    end
    object btnMedia: TButton
      Left = 14
      Top = 140
      Width = 96
      Height = 25
      Caption = 'M'#233'dia'
      TabOrder = 4
    end
    object btnBlending: TButton
      Left = 14
      Top = 171
      Width = 96
      Height = 25
      Caption = 'Blending'
      TabOrder = 5
    end
    object edtMultiplicacao: TEdit
      Left = 116
      Top = 78
      Width = 69
      Height = 21
      TabOrder = 6
    end
    object edtDivisao: TEdit
      Left = 116
      Top = 109
      Width = 69
      Height = 21
      TabOrder = 7
    end
    object edtBlending: TEdit
      Left = 116
      Top = 171
      Width = 69
      Height = 21
      TabOrder = 8
    end
    object btnCinza: TButton
      Left = 115
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Cinza'
      TabOrder = 9
    end
  end
  object gbOperacoesLogicas: TGroupBox
    Left = 766
    Top = 224
    Width = 193
    Height = 146
    Caption = 'Opera'#231#245'es L'#243'gicas'
    TabOrder = 5
    object btnAND: TButton
      Left = 16
      Top = 18
      Width = 161
      Height = 25
      Caption = 'AND'
      TabOrder = 0
    end
    object btnOR: TButton
      Left = 16
      Top = 49
      Width = 161
      Height = 25
      Caption = 'OR'
      TabOrder = 1
    end
    object btnXOR: TButton
      Left = 16
      Top = 80
      Width = 161
      Height = 25
      Caption = 'XOR'
      TabOrder = 2
    end
    object btnNOT: TButton
      Left = 16
      Top = 111
      Width = 161
      Height = 25
      Caption = 'NOT'
      TabOrder = 3
    end
  end
  object gbResultante: TGroupBox
    Left = 966
    Top = 7
    Width = 353
    Height = 305
    Caption = 'Imagem Resultante:'
    TabOrder = 6
    object imgResultante: TImage
      Left = 9
      Top = 16
      Width = 335
      Height = 281
      Center = True
      Stretch = True
    end
  end
end
