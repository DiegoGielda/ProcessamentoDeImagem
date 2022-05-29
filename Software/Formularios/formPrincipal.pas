unit formPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs, dxGDIPlusClasses;

type
  TfrmPrincipal = class(TForm)
    gbImagemA: TGroupBox;
    imagemA: TImage;
    gbImagemB: TGroupBox;
    imagemB: TImage;
    btnCarregarImagemA: TButton;
    btnCarregarImagemB: TButton;
    gbOperacoesAritmeticas: TGroupBox;
    btnAdicao: TButton;
    btnSubtracao: TButton;
    btnMultiplicacao: TButton;
    btnDivisao: TButton;
    btnMedia: TButton;
    btnBlending: TButton;
    edtMultiplicacao: TEdit;
    edtDivisao: TEdit;
    edtBlending: TEdit;
    btnCinza: TButton;
    gbOperacoesLogicas: TGroupBox;
    btnAND: TButton;
    btnOR: TButton;
    btnXOR: TButton;
    btnNOT: TButton;
    gbResultante: TGroupBox;
    imagemResultante: TImage;
    abrirImagem: TOpenPictureDialog;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure btnCarregarImagemAClick(Sender: TObject);
    procedure btnCarregarImagemBClick(Sender: TObject);
    procedure btnCinzaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicaoClick(Sender: TObject);
    procedure btnSubtracaoClick(Sender: TObject);
    procedure btnMultiplicacaoClick(Sender: TObject);
  private
    { Private declarations }
    FImagemA: TWICImage;
    FImagemB: TWICImage;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  System.Math, System.StrUtils, Vcl.Imaging.jpeg;

procedure TfrmPrincipal.btnAdicaoClick(Sender: TObject);
var
  lLargura, lAltura: Integer;
  lAuxImagemA, lAuxImagemB: TImage;

  lX, lY: Integer;
  lCorPixelA, lCorPixelB: TColor;
  lRedA, lGreenA, lBlueA, lRedB, lGreenB, lBlueB: UInt8;
begin
  lLargura := 335;
  lAltura :=  281;
  try
    lAuxImagemA := TImage.Create(nil);
    lAuxImagemB := TImage.Create(nil);

    lAuxImagemA.Width := lLargura;
    lAuxImagemA.Height := lAltura;
    lAuxImagemB.Width := lLargura;
    lAuxImagemB.Height := lAltura;

    // Ajusta o tamanho das imagens
    lAuxImagemA.Canvas.StretchDraw(lAuxImagemA.Canvas.ClipRect, imagemA.Picture.Graphic);
    lAuxImagemB.Canvas.StretchDraw(lAuxImagemB.Canvas.ClipRect, imagemB.Picture.Graphic);

    for lY := 0 to lAuxImagemA.Height - 1 do
    begin
      for lX := 0 to lAuxImagemA.Width - 1 do
      begin
        lCorPixelA := lAuxImagemA.Canvas.Pixels[lX, lY];
        lCorPixelB := lAuxImagemB.Canvas.Pixels[lX, lY];

        lRedA := GetRValue(lCorPixelA);
        lGreenA := GetGValue(lCorPixelA);
        lBlueA := GetBValue(lCorPixelA);

        lRedB := GetRValue(lCorPixelB);
        lGreenB := GetGValue(lCorPixelB);
        lBlueB := GetBValue(lCorPixelB);

        //// REUTILIZA VARIAVEL
        if lRedA <> lRedB then
          lRedA := Trunc(Min(lRedA + lRedB, 255));
        if lGreenA <> lGreenB then
          lGreenA := Trunc(Min(lGreenA + lGreenB, 255));
        if lBlueA <> lBlueB then
          lBlueA := Trunc(Min(lBlueA + lBlueB, 255));

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
      end;
    end;

    //imagemResultante.Picture := lAuxImagemA.Picture;

  finally
    FreeAndNil(lAuxImagemA);
    FreeAndNil(lAuxImagemB);
  end;
end;

procedure TfrmPrincipal.btnCarregarImagemAClick(Sender: TObject);
var
  lCaminhoImagem: string;
begin
  if abrirImagem.Execute then
  begin
    lCaminhoImagem := abrirImagem.FileName;
    imagemA.Picture.LoadFromFile(lCaminhoImagem);

    /// IMAGEM A
    FImagemA.LoadFromFile(lCaminhoImagem);
  end;
end;

procedure TfrmPrincipal.btnCarregarImagemBClick(Sender: TObject);
var
  lCaminhoImagem: string;
begin
  if abrirImagem.Execute then
  begin
    lCaminhoImagem := abrirImagem.FileName;
    imagemB.Picture.LoadFromFile(lCaminhoImagem);

    /// IMAGEM B
    FImagemB.LoadFromFile(lCaminhoImagem);
  end;
end;

procedure TfrmPrincipal.btnCinzaClick(Sender: TObject);
var
  lX: Integer;
  lY: Integer;
  lCorPixel: TColor;
  lR: UInt8;
  lG: UInt8;
  lB: UInt8;
  lNivelCinza: UInt8;
begin
  imagemResultante.Height := imagemA.Height;
  imagemResultante.Width := imagemA.Width;

  for lY := 0 to imagemA.Height - 1 do
  begin
    for lX := 0 to imagemA.Width - 1 do
    begin
      lCorPixel := imagemA.Canvas.Pixels[lX, lY];

      lR := GetRValue(lCorPixel);
      lG := GetGValue(lCorPixel);
      lB := GetBValue(lCorPixel);

      lNivelCinza := Trunc(Min((lR * 0.3) + (lG * 0.59) + (lB * 0.11), 255));

      imagemResultante.Canvas.Pixels[lX, lY] := RGB(lNivelCinza, lNivelCinza, lNivelCinza);
    end;
  end;
end;

procedure TfrmPrincipal.btnMultiplicacaoClick(Sender: TObject);
var
  lLargura, lAltura: Integer;
  lAuxImagemA: TImage;
  lMultiplicacao: Currency;
  lX, lY: Integer;
  lCorPixelA, lCorPixelB: TColor;
  lRedA, lGreenA, lBlueA, lRedB, lGreenB, lBlueB: UInt8;
begin
  if Trim(edtMultiplicacao.Text) <> '' then
  begin
    lLargura := 335;
    lAltura :=  281;
    lMultiplicacao :=  StrToCurrDef(edtMultiplicacao.Text, 1);
    try
      lAuxImagemA := TImage.Create(nil);

      lAuxImagemA.Width := lLargura;
      lAuxImagemA.Height := lAltura;

      // Ajusta o tamanho das imagens
      lAuxImagemA.Canvas.StretchDraw(lAuxImagemA.Canvas.ClipRect, imagemA.Picture.Graphic);

      for lY := 0 to lAuxImagemA.Height - 1 do
      begin
        for lX := 0 to lAuxImagemA.Width - 1 do
        begin
          lCorPixelA := lAuxImagemA.Canvas.Pixels[lX, lY];

          lRedA := GetRValue(lCorPixelA);
          lGreenA := GetGValue(lCorPixelA);
          lBlueA := GetBValue(lCorPixelA);

          lRedA := Trunc(Min(lRedA * lMultiplicacao, 255));
          lGreenA := Trunc(Min(lGreenA * lMultiplicacao, 255));
          lBlueA := Trunc(Min(lBlueA * lMultiplicacao, 255));

          imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
        end;
      end;

      //imagemResultante.Picture := lAuxImagemA.Picture;
    finally
      FreeAndNil(lAuxImagemA);
    end;
  end;
end;

procedure TfrmPrincipal.btnSubtracaoClick(Sender: TObject);
var
  lLargura, lAltura: Integer;
  lAuxImagemA, lAuxImagemB: TImage;

  lX, lY: Integer;
  lCorPixelA, lCorPixelB: TColor;
  lRedA, lGreenA, lBlueA, lRedB, lGreenB, lBlueB: UInt8;
begin
  lLargura := 335;
  lAltura :=  281;
  try
    lAuxImagemA := TImage.Create(nil);
    lAuxImagemB := TImage.Create(nil);

    lAuxImagemA.Width := lLargura;
    lAuxImagemA.Height := lAltura;
    lAuxImagemB.Width := lLargura;
    lAuxImagemB.Height := lAltura;

    // Ajusta o tamanho das imagens
    lAuxImagemA.Canvas.StretchDraw(lAuxImagemA.Canvas.ClipRect, imagemA.Picture.Graphic);
    lAuxImagemB.Canvas.StretchDraw(lAuxImagemB.Canvas.ClipRect, imagemB.Picture.Graphic);

    for lY := 0 to lAuxImagemA.Height - 1 do
    begin
      for lX := 0 to lAuxImagemA.Width - 1 do
      begin
        lCorPixelA := lAuxImagemA.Canvas.Pixels[lX, lY];
        lCorPixelB := lAuxImagemB.Canvas.Pixels[lX, lY];

        lRedA := GetRValue(lCorPixelA);
        lGreenA := GetGValue(lCorPixelA);
        lBlueA := GetBValue(lCorPixelA);

        lRedB := GetRValue(lCorPixelB);
        lGreenB := GetGValue(lCorPixelB);
        lBlueB := GetBValue(lCorPixelB);

        //// REUTILIZA VARIAVEL
        if lRedA <> lRedB then
          lRedA := Trunc(Max(lRedA - lRedB, 0));
        if lGreenA <> lGreenB then
          lGreenA := Trunc(Max(lGreenA - lGreenB, 0));
        if lBlueA <> lBlueB then
          lBlueA := Trunc(Max(lBlueA - lBlueB, 0));

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
      end;
    end;

    //imagemResultante.Picture := lAuxImagemA.Picture;

  finally
    FreeAndNil(lAuxImagemA);
    FreeAndNil(lAuxImagemB);
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FImagemA := TWICImage.Create;
  FImagemB := TWICImage.Create;
end;

end.
