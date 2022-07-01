unit formPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs, dxGDIPlusClasses, Vcl.Buttons, Data.DB, Vcl.DBGrids, Vcl.Grids,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series;

type
  TfrmPrincipal = class(TForm)
    gbImagemA: TGroupBox;
    imagemA: TImage;
    gbImagemB: TGroupBox;
    imagemB: TImage;
    gbOperacoesAritmeticas: TGroupBox;
    edtMultiplicacao: TEdit;
    edtDivisao: TEdit;
    edtBlending: TEdit;
    gbOperacoesLogicas: TGroupBox;
    gbResultante: TGroupBox;
    imagemResultante: TImage;
    abrirImagem: TOpenPictureDialog;
    btnTrocaImagem: TSpeedButton;
    btnMedia: TSpeedButton;
    btnBlending: TSpeedButton;
    btnDivisao: TSpeedButton;
    btnMultiplicacao: TSpeedButton;
    btnSubtracao: TSpeedButton;
    btnAdicao: TSpeedButton;
    btnCinza: TSpeedButton;
    btnCarregarImagemA: TSpeedButton;
    btnCarregarImagemB: TSpeedButton;
    btnAND: TSpeedButton;
    btnOR: TSpeedButton;
    btnXOR: TSpeedButton;
    btnNOT: TSpeedButton;
    btnFiltragemPorMedia: TButton;
    lMatrizRed: TStringGrid;
    lMatrizGreen: TStringGrid;
    lMatrizBlue: TStringGrid;
    btnFiltragemPorMediana: TButton;
    btnFiltragemPorMinimo: TButton;
    lMatrizAux: TStringGrid;
    btnFiltragemPorMaximo: TButton;
    btnSuavizacao: TButton;
    procedure btnCarregarImagemAClick(Sender: TObject);
    procedure btnCarregarImagemBClick(Sender: TObject);
    procedure btnCinzaClick(Sender: TObject);
    procedure btnAdicaoClick(Sender: TObject);
    procedure btnSubtracaoClick(Sender: TObject);
    procedure btnMultiplicacaoClick(Sender: TObject);
    procedure btnDivisaoClick(Sender: TObject);
    procedure btnBlendingClick(Sender: TObject);
    procedure btnMediaClick(Sender: TObject);
    procedure btnNOTClick(Sender: TObject);
    procedure btnXORClick(Sender: TObject);
    procedure btnORClick(Sender: TObject);
    procedure btnANDClick(Sender: TObject);
    procedure btnTrocaImagemClick(Sender: TObject);
    procedure btnFiltragemPorMediaClick(Sender: TObject);
    procedure btnFiltragemPorMedianaClick(Sender: TObject);
    procedure btnFiltragemPorMinimoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFiltragemPorMaximoClick(Sender: TObject);
    procedure btnSuavizacaoClick(Sender: TObject);
  private
    { Private declarations }

    procedure converterParaBinario(pImagem: TImage);

    function GetColorGreen(pColor: TColor): string;// overload;
    function GetColorBlue(pColor: TColor): string;// overload;
    function GetColorRed(pColor: TColor): string;// overload;
    function GetCor(pCor: Integer): string; overload;
    function GetCor(pCor: String): Integer; overload;

    function ValorCor(pColor: string): Integer;

    procedure mediaMatriz(pMatrizCor: TStringGrid);
    procedure minimoMatriz(pMatrizCor: TStringGrid);
    procedure maximoMatriz(pMatrizCor: TStringGrid);
    procedure medianaMatriz(pMatrizCor: TStringGrid);
    procedure SuavizacaoMatriz(pMatrizCor: TStringGrid);


    procedure ordenarValores(var pArray: array of Integer);

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  System.Math, System.StrUtils, Vcl.Imaging.jpeg, System.Types;

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

procedure TfrmPrincipal.btnANDClick(Sender: TObject);
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

    converterParaBinario(lAuxImagemA);
    converterParaBinario(lAuxImagemB);

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

        if ((lRedA > 0) and (lRedB > 0)) then
        begin
          lRedA := 255;
        end
        else
        begin
          lRedA := 0;
        end;

        if ((lGreenA > 0) and (lGreenB > 0)) then
        begin
          lGreenA := 255;
        end
        else
        begin
          lGreenA := 0;
        end;

        if ((lBlueA > 0) and (lBlueB > 0)) then
        begin
          lBlueA := 255;
        end
        else
        begin
          lBlueA := 0;
        end;

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
      end;
    end;
  finally
    FreeAndNil(lAuxImagemA);
    FreeAndNil(lAuxImagemB);
  end;
end;

procedure TfrmPrincipal.btnBlendingClick(Sender: TObject);
var
  lLargura, lAltura: Integer;
  lAuxImagemA, lAuxImagemB: TImage;
  lBlending: Currency;
  lX, lY: Integer;
  lCorPixelA, lCorPixelB: TColor;
  lRedA, lGreenA, lBlueA, lRedB, lGreenB, lBlueB: UInt8;
begin
  if Trim(edtBlending.Text) <> '' then
  begin
    lLargura := 335;
    lAltura :=  281;
    lBlending :=  StrToFloatDef(edtBlending.Text, 1);
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
            lRedA := Trunc(Min((lBlending * lRedA + (1 - lBlending) * lRedB), 255));
          if lGreenA <> lGreenB then
            lGreenA := Trunc(Min((lBlending * lGreenA + (1 - lBlending) * lGreenB), 255));
          if lBlueA <> lBlueB then
            lBlueA := Trunc(Min((lBlending * lBlueA + (1 - lBlending) * lBlueB), 255));

          imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
        end;
      end;

      //imagemResultante.Picture := lAuxImagemA.Picture;

    finally
      FreeAndNil(lAuxImagemA);
      FreeAndNil(lAuxImagemB);
    end;
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
  end;
end;

procedure TfrmPrincipal.btnCinzaClick(Sender: TObject);
var
  lLargura, lAltura: Integer;
  lAuxImagemA: TImage;
  lX: Integer;
  lY: Integer;
  lCorPixel: TColor;
  lRed, lGreen, lBlue: UInt8;
  lNivelCinza: UInt8;
begin
  lLargura := 335;
  lAltura :=  281;
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
        lCorPixel := lAuxImagemA.Canvas.Pixels[lX, lY];

        lRed := GetRValue(lCorPixel);
        lGreen := GetGValue(lCorPixel);
        lBlue := GetBValue(lCorPixel);

        lNivelCinza := Trunc(Min((lRed * 0.3) + (lGreen * 0.59) + (lBlue * 0.11), 255));

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lNivelCinza, lNivelCinza, lNivelCinza);
      end;
    end;
  finally
    FreeAndNil(lAuxImagemA);
  end;
end;

procedure TfrmPrincipal.btnDivisaoClick(Sender: TObject);
var
  lLargura, lAltura: Integer;
  lAuxImagemA: TImage;
  lDivisao: Integer;
  lX, lY: Integer;
  lCorPixelA: TColor;
  lRedA, lGreenA, lBlueA: UInt8;
begin
  if Trim(edtDivisao.Text) <> '' then
  begin
    lLargura := 335;
    lAltura :=  281;
    lDivisao :=  ifThen(StrToIntDef(edtDivisao.Text, 1) > 0, StrToIntDef(edtDivisao.Text, 1), 1);
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

          lRedA := Trunc(Max(lRedA div lDivisao, 1));
          lGreenA := Trunc(Max(lGreenA div lDivisao, 1));
          lBlueA := Trunc(Max(lBlueA div lDivisao, 1));

          imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
        end;
      end;
    finally
      FreeAndNil(lAuxImagemA);
    end;
  end;
end;

procedure TfrmPrincipal.btnFiltragemPorMaximoClick(Sender: TObject);
var
  //IMatrizRed : array[0..500, 0..500] of Integer;
  //IMatrizGreen: array[0..500, 0..500] of Integer;
  //IMatrizBlue: array[0..500, 0..500] of Integer;

  lLargura, lAltura: Integer;
  lX, lY: Integer;
  lAuxImagemA: TImage;
  lCorPixel: TColor;
  lRed, lGreen, lBlue: UInt8;

begin
  lLargura := 335;
  lAltura :=  281;
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
        lCorPixel := lAuxImagemA.Canvas.Pixels[lX, lY];

        lMatrizRed.Cells[lY, lX] := GetColorRed(lCorPixel);
        lMatrizGreen.Cells[lY, lX] := GetColorGreen(lCorPixel);
        lMatrizBlue.Cells[lY, lX] := GetColorBlue(lCorPixel);
      end;
    end;

    maximoMatriz(lMatrizRed);
    maximoMatriz(lMatrizGreen);
    maximoMatriz(lMatrizBlue);

    for lY := 0 to lAuxImagemA.Height - 1 do
    begin
      for lX := 0 to lAuxImagemA.Width - 1 do
      begin

        lRed := GetCor(lMatrizRed.Cells[lY, lX]);
        lGreen := GetCor(lMatrizGreen.Cells[lY, lX]);
        lBlue := GetCor(lMatrizBlue.Cells[lY, lX]);

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRed, lGreen, lBlue);
      end;
    end;

  finally
    FreeAndNil(lAuxImagemA);
  end;
end;

procedure TfrmPrincipal.btnFiltragemPorMediaClick(Sender: TObject);
var
  //IMatrizRed : array[0..500, 0..500] of Integer;
  //IMatrizGreen: array[0..500, 0..500] of Integer;
  //IMatrizBlue: array[0..500, 0..500] of Integer;

  lLargura, lAltura: Integer;
  lX, lY: Integer;
  lAuxImagemA: TImage;
  lCorPixel: TColor;
  lRed, lGreen, lBlue: UInt8;

begin
  lLargura := 335;
  lAltura :=  281;
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
        lCorPixel := lAuxImagemA.Canvas.Pixels[lX, lY];

        lMatrizRed.Cells[lY, lX] := GetColorRed(lCorPixel);
        lMatrizGreen.Cells[lY, lX] := GetColorGreen(lCorPixel);
        lMatrizBlue.Cells[lY, lX] := GetColorBlue(lCorPixel);
      end;
    end;

    mediaMatriz(lMatrizRed);
    mediaMatriz(lMatrizGreen);
    mediaMatriz(lMatrizBlue);

    for lY := 0 to lAuxImagemA.Height - 1 do
    begin
      for lX := 0 to lAuxImagemA.Width - 1 do
      begin

        lRed := GetCor(lMatrizRed.Cells[lY, lX]);
        lGreen := GetCor(lMatrizGreen.Cells[lY, lX]);
        lBlue := GetCor(lMatrizBlue.Cells[lY, lX]);

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRed, lGreen, lBlue);
      end;
    end;

  finally
    FreeAndNil(lAuxImagemA);
  end;
end;

procedure TfrmPrincipal.btnFiltragemPorMedianaClick(Sender: TObject);
var
  //IMatrizRed : array[0..500, 0..500] of Integer;
  //IMatrizGreen: array[0..500, 0..500] of Integer;
  //IMatrizBlue: array[0..500, 0..500] of Integer;

  lLargura, lAltura: Integer;
  lX, lY: Integer;
  lAuxImagemA: TImage;
  lCorPixel: TColor;
  lRed, lGreen, lBlue: UInt8;

begin
  lLargura := 335;
  lAltura :=  281;
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
        lCorPixel := lAuxImagemA.Canvas.Pixels[lX, lY];

        lMatrizRed.Cells[lY, lX] := GetColorRed(lCorPixel);
        lMatrizGreen.Cells[lY, lX] := GetColorGreen(lCorPixel);
        lMatrizBlue.Cells[lY, lX] := GetColorBlue(lCorPixel);
      end;
    end;

    medianaMatriz(lMatrizRed);
    medianaMatriz(lMatrizGreen);
    medianaMatriz(lMatrizBlue);

    for lY := 0 to lAuxImagemA.Height - 1 do
    begin
      for lX := 0 to lAuxImagemA.Width - 1 do
      begin

        lRed := GetCor(lMatrizRed.Cells[lY, lX]);
        lGreen := GetCor(lMatrizGreen.Cells[lY, lX]);
        lBlue := GetCor(lMatrizBlue.Cells[lY, lX]);

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRed, lGreen, lBlue);
      end;
    end;

  finally
    FreeAndNil(lAuxImagemA);
  end;
end;

procedure TfrmPrincipal.btnFiltragemPorMinimoClick(Sender: TObject);
var
  //IMatrizRed : array[0..500, 0..500] of Integer;
  //IMatrizGreen: array[0..500, 0..500] of Integer;
  //IMatrizBlue: array[0..500, 0..500] of Integer;

  lLargura, lAltura: Integer;
  lX, lY: Integer;
  lAuxImagemA: TImage;
  lCorPixel: TColor;
  lRed, lGreen, lBlue: UInt8;

begin
  lLargura := 335;
  lAltura :=  281;
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
        lCorPixel := lAuxImagemA.Canvas.Pixels[lX, lY];

        lMatrizRed.Cells[lY, lX] := GetColorRed(lCorPixel);
        lMatrizGreen.Cells[lY, lX] := GetColorGreen(lCorPixel);
        lMatrizBlue.Cells[lY, lX] := GetColorBlue(lCorPixel);
      end;
    end;

    minimoMatriz(lMatrizRed);
    minimoMatriz(lMatrizGreen);
    minimoMatriz(lMatrizBlue);

    for lY := 0 to lAuxImagemA.Height - 1 do
    begin
      for lX := 0 to lAuxImagemA.Width - 1 do
      begin

        lRed := GetCor(lMatrizRed.Cells[lY, lX]);
        lGreen := GetCor(lMatrizGreen.Cells[lY, lX]);
        lBlue := GetCor(lMatrizBlue.Cells[lY, lX]);

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRed, lGreen, lBlue);
      end;
    end;

  finally
    FreeAndNil(lAuxImagemA);
  end;
end;

procedure TfrmPrincipal.btnMediaClick(Sender: TObject);
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

        if lRedA <> lRedB then
          lRedA := Trunc(Max((lRedA + lRedB) / 2, 0));
        if lGreenA <> lGreenB then
          lGreenA := Trunc(Max((lGreenA + lGreenB) / 2, 0));
        if lBlueA <> lBlueB then
        lBlueA := Trunc(Max((lBlueA + lBlueB) / 2, 0));

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
      end;
    end;
  finally
    FreeAndNil(lAuxImagemA);
    FreeAndNil(lAuxImagemB);
  end;
end;

procedure TfrmPrincipal.btnMultiplicacaoClick(Sender: TObject);
var
  lLargura, lAltura: Integer;
  lAuxImagemA: TImage;
  lMultiplicacao: Currency;
  lX, lY: Integer;
  lCorPixelA: TColor;
  lRedA, lGreenA, lBlueA: UInt8;
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

procedure TfrmPrincipal.btnNOTClick(Sender: TObject);
var
  lLargura, lAltura: Integer;
  lAuxImagemA: TImage;

  lX, lY: Integer;
  lCorPixelA: TColor;
  lRedA, lGreenA, lBlueA: UInt8;
begin
  lLargura := 335;
  lAltura :=  281;
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

        lRedA := Trunc(Max(255 - lRedA, 0));
        lGreenA := Trunc(Max(255 - lGreenA, 0));
        lBlueA := Trunc(Max(255 - lBlueA, 0));

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
      end;
    end;
  finally
    FreeAndNil(lAuxImagemA);
  end;
end;

procedure TfrmPrincipal.btnORClick(Sender: TObject);
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

    converterParaBinario(lAuxImagemA);
    converterParaBinario(lAuxImagemB);

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

        if ((lRedA > 0) or (lRedB > 0)) then
        begin
          lRedA := 255;
        end
        else
        begin
          lRedA := 0;
        end;

        if ((lGreenA > 0) or (lGreenB > 0)) then
        begin
          lGreenA := 255;
        end
        else
        begin
          lGreenA := 0;
        end;

        if ((lBlueA > 0) or (lBlueB > 0)) then
        begin
          lBlueA := 255;
        end
        else
        begin
          lBlueA := 0;
        end;

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
      end;
    end;
  finally
    FreeAndNil(lAuxImagemA);
    FreeAndNil(lAuxImagemB);
  end;
end;

procedure TfrmPrincipal.btnSuavizacaoClick(Sender: TObject);
var
  //IMatrizRed : array[0..500, 0..500] of Integer;
  //IMatrizGreen: array[0..500, 0..500] of Integer;
  //IMatrizBlue: array[0..500, 0..500] of Integer;

  lLargura, lAltura: Integer;
  lX, lY: Integer;
  lAuxImagemA: TImage;
  lCorPixel: TColor;
  lRed, lGreen, lBlue: UInt8;

begin
  lLargura := 335;
  lAltura :=  281;
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
        lCorPixel := lAuxImagemA.Canvas.Pixels[lX, lY];

        lMatrizRed.Cells[lY, lX] := GetColorRed(lCorPixel);
        lMatrizGreen.Cells[lY, lX] := GetColorGreen(lCorPixel);
        lMatrizBlue.Cells[lY, lX] := GetColorBlue(lCorPixel);
      end;
    end;

    minimoMatriz(lMatrizRed);
    minimoMatriz(lMatrizGreen);
    minimoMatriz(lMatrizBlue);

    for lY := 0 to lAuxImagemA.Height - 1 do
    begin
      for lX := 0 to lAuxImagemA.Width - 1 do
      begin

        lRed := GetCor(lMatrizRed.Cells[lY, lX]);
        lGreen := GetCor(lMatrizGreen.Cells[lY, lX]);
        lBlue := GetCor(lMatrizBlue.Cells[lY, lX]);

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRed, lGreen, lBlue);
      end;
    end;

  finally
    FreeAndNil(lAuxImagemA);
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

procedure TfrmPrincipal.btnTrocaImagemClick(Sender: TObject);
var
  lAuxImagem: TImage;
begin
  lAuxImagem := TImage.Create(nil);
  try
    lAuxImagem.Picture := imagemA.Picture;
    imagemA.Picture := imagemB.Picture;
    imagemB.Picture := lAuxImagem.Picture;
  finally
    FreeAndNil(lAuxImagem);
  end;
end;

procedure TfrmPrincipal.btnXORClick(Sender: TObject);
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

    converterParaBinario(lAuxImagemA);
    converterParaBinario(lAuxImagemB);

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

        if ((lRedA > 0) xor (lRedB > 0)) then
        begin
          lRedA := 255;
        end
        else
        begin
          lRedA := 0;
        end;

        if ((lGreenA > 0) xor (lGreenB > 0)) then
        begin
          lGreenA := 255;
        end
        else
        begin
          lGreenA := 0;
        end;

        if ((lBlueA > 0) xor (lBlueB > 0)) then
        begin
          lBlueA := 255;
        end
        else
        begin
          lBlueA := 0;
        end;

        imagemResultante.Canvas.Pixels[lX, lY] := RGB(lRedA, lGreenA, lBlueA);
      end;
    end;
  finally
    FreeAndNil(lAuxImagemA);
    FreeAndNil(lAuxImagemB);
  end;
end;

procedure TfrmPrincipal.converterParaBinario(pImagem: TImage);
var
  lX, lY: Integer;
  lCorPixel: TColor;
  lRed, lGreen, lBlue: UInt8;
begin
  for lY := 0 to pImagem.Height - 1 do
  begin
    for lX := 0 to pImagem.Width - 1 do
    begin
      lCorPixel := pImagem.Canvas.Pixels[lX, lY];

      lRed := GetRValue(lCorPixel);
      lGreen := GetGValue(lCorPixel);
      lBlue := GetBValue(lCorPixel);

      if ((lRed >= 128) and (lGreen >= 128) and (lBlue >= 128)) then
      begin
        lRed := 255;
        lGreen := 255;
        lBlue := 255;
      end
      else
      begin
        lRed := 0;
        lGreen := 0;
        lBlue := 0;
      end;

      pImagem.Canvas.Pixels[lX, lY] := RGB(lRed, lGreen, lBlue);
    end;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  //Chart1.SeriesList.ClearValues;
  //Chart1.SeriesList.Clear;
  //Chart1.Series[0].AddY(150,'Janeiro',clteecolor);

end;

function TfrmPrincipal.GetColorBlue(pColor: TColor): string;
begin
  Result := IntToStr(GetBValue(pColor));
end;

function TfrmPrincipal.GetColorGreen(pColor: TColor): string;
begin
  Result := IntToStr(GetGValue(pColor));
end;

function TfrmPrincipal.GetColorRed(pColor: TColor): string;
begin
  Result := IntToStr(GetRValue(pColor));
end;

procedure TfrmPrincipal.medianaMatriz(pMatrizCor: TStringGrid);
var
  lContador: Integer;
  lX, lY: Integer;
  lMediaPixel: Integer;
  lXFora, lYFora: Boolean;
  lArrayMediana: Array [0..8] of Integer;
begin

  //// pegando a media
  /// TROCADO OS VALORES DE LX E LY NO FOR
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      /// Zerando Array
      for lContador := 0 to 8 Do
        lArrayMediana[lContador] := 0;

      lXFora := ((lX - 1) < 0);
      lYFora := ((lY - 1) < 0);

      // centro
      lArrayMediana[0] := ValorCor(pMatrizCor.Cells[lX, lY]);

      // acima
      if lYFora then
        lArrayMediana[1] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMediana[1] := ValorCor(pMatrizCor.Cells[lX, lY - 1]);

      // acima-esquerda
      if (lYFora or  lXFora)then
        lArrayMediana[2] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMediana[2] := ValorCor(pMatrizCor.Cells[lX - 1, lY - 1]);

      // esquerda
      if lXFora then
        lArrayMediana[3] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMediana[3] := ValorCor(pMatrizCor.Cells[lX - 1, lY]);

      lYFora := ((lY + 1) > 281);

      // esquerda-abaixo
      if (lXFora or  lYFora)then
        lArrayMediana[4] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMediana[4] := ValorCor(pMatrizCor.Cells[lX - 1, lY + 1]);

      // abaixo
      if lYFora then
        lArrayMediana[5] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMediana[5] := ValorCor(pMatrizCor.Cells[lX, lY + 1]);

      lXFora := ((lY + 1) > 281);

      // abaixo-direita
      if (lXFora or  lYFora)then
        lArrayMediana[6] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMediana[6] := ValorCor(pMatrizCor.Cells[lX + 1, lY + 1]);

      // direita
      if (lXFora)then
        lArrayMediana[7] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMediana[7] := ValorCor(pMatrizCor.Cells[lX + 1, lY]);

      lYFora := ((lY - 1) < 0);

      // direita-acima
      if (lYFora or  lXFora) then
        lArrayMediana[8] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMediana[8] := ValorCor(pMatrizCor.Cells[lX + 1, lY - 1]);


      // Ordenar valores no Array
      ordenarValores(lArrayMediana);

      // Pega o valor pixel central
      lMatrizAux.Cells[lX, lY] :=  GetCor(lArrayMediana[4]);

    end;
  end;

  /// Retornar mudança
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      pMatrizCor.Cells[lX, lY] := lMatrizAux.Cells[lX, lY];
    end;
  end;
end;

procedure TfrmPrincipal.minimoMatriz(pMatrizCor: TStringGrid);
var
  lContador: Integer;
  lX, lY: Integer;
  lMediaPixel: Integer;
  lXFora, lYFora: Boolean;
  lArrayMinimo: Array [0..8] of Integer;
begin

  //// pegando a media
  /// TROCADO OS VALORES DE LX E LY NO FOR
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      /// Zerando Array
      for lContador := 0 to 8 Do
        lArrayMinimo[lContador] := 0;

      lXFora := ((lX - 1) < 0);
      lYFora := ((lY - 1) < 0);

      // centro
      lArrayMinimo[0] := ValorCor(pMatrizCor.Cells[lX, lY]);

      // acima
      if lYFora then
        lArrayMinimo[1] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[1] := ValorCor(pMatrizCor.Cells[lX, lY - 1]);

      // acima-esquerda
      if (lYFora or  lXFora)then
        lArrayMinimo[2] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[2] := ValorCor(pMatrizCor.Cells[lX - 1, lY - 1]);

      // esquerda
      if lXFora then
        lArrayMinimo[3] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[3] := ValorCor(pMatrizCor.Cells[lX - 1, lY]);

      lYFora := ((lY + 1) > 281);

      // esquerda-abaixo
      if (lXFora or  lYFora)then
        lArrayMinimo[4] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[4] := ValorCor(pMatrizCor.Cells[lX - 1, lY + 1]);

      // abaixo
      if lYFora then
        lArrayMinimo[5] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[5] := ValorCor(pMatrizCor.Cells[lX, lY + 1]);

      lXFora := ((lY + 1) > 281);

      // abaixo-direita
      if (lXFora or  lYFora)then
        lArrayMinimo[6] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[6] := ValorCor(pMatrizCor.Cells[lX + 1, lY + 1]);

      // direita
      if (lXFora)then
        lArrayMinimo[7] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[7] := ValorCor(pMatrizCor.Cells[lX + 1, lY]);

      lYFora := ((lY - 1) < 0);

      // direita-acima
      if (lYFora or  lXFora) then
        lArrayMinimo[8] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[8] := ValorCor(pMatrizCor.Cells[lX + 1, lY - 1]);


      // Ordenar valores no Array
      ordenarValores(lArrayMinimo);

      // Pega o valor pixel central
      lMatrizAux.Cells[lX, lY] :=  GetCor(lArrayMinimo[0]);
    end;
  end;

  /// Retornar mudança
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      pMatrizCor.Cells[lX, lY] := lMatrizAux.Cells[lX, lY];
    end;
  end;
end;

procedure TfrmPrincipal.maximoMatriz(pMatrizCor: TStringGrid);
var
  lContador: Integer;
  lX, lY: Integer;
  lMediaPixel: Integer;
  lXFora, lYFora: Boolean;
  lArrayMinimo: Array [0..8] of Integer;
begin

  //// pegando a media
  /// TROCADO OS VALORES DE LX E LY NO FOR
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      /// Zerando Array
      for lContador := 0 to 8 Do
        lArrayMinimo[lContador] := 0;

      lXFora := ((lX - 1) < 0);
      lYFora := ((lY - 1) < 0);

      // centro
      lArrayMinimo[0] := ValorCor(pMatrizCor.Cells[lX, lY]);

      // acima
      if lYFora then
        lArrayMinimo[1] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[1] := ValorCor(pMatrizCor.Cells[lX, lY - 1]);

      // acima-esquerda
      if (lYFora or  lXFora)then
        lArrayMinimo[2] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[2] := ValorCor(pMatrizCor.Cells[lX - 1, lY - 1]);

      // esquerda
      if lXFora then
        lArrayMinimo[3] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[3] := ValorCor(pMatrizCor.Cells[lX - 1, lY]);

      lYFora := ((lY + 1) > 281);

      // esquerda-abaixo
      if (lXFora or  lYFora)then
        lArrayMinimo[4] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[4] := ValorCor(pMatrizCor.Cells[lX - 1, lY + 1]);

      // abaixo
      if lYFora then
        lArrayMinimo[5] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[5] := ValorCor(pMatrizCor.Cells[lX, lY + 1]);

      lXFora := ((lY + 1) > 281);

      // abaixo-direita
      if (lXFora or  lYFora)then
        lArrayMinimo[6] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[6] := ValorCor(pMatrizCor.Cells[lX + 1, lY + 1]);

      // direita
      if (lXFora)then
        lArrayMinimo[7] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[7] := ValorCor(pMatrizCor.Cells[lX + 1, lY]);

      lYFora := ((lY - 1) < 0);

      // direita-acima
      if (lYFora or  lXFora) then
        lArrayMinimo[8] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[8] := ValorCor(pMatrizCor.Cells[lX + 1, lY - 1]);


      // Ordenar valores no Array
      ordenarValores(lArrayMinimo);

      // Pega o valor pixel central
      lMatrizAux.Cells[lX, lY] :=  GetCor(lArrayMinimo[8]);
    end;
  end;

  /// Retornar mudança
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      pMatrizCor.Cells[lX, lY] := lMatrizAux.Cells[lX, lY];
    end;
  end;
end;

procedure TfrmPrincipal.mediaMatriz(pMatrizCor: TStringGrid);
var
  lX, lY: Integer;
  lMediaPixel: Integer;
  lXFora, lYFora: Boolean;
begin
  //// pegando a media
  /// TROCADO OS VALORES DE LX E LY NO FOR
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      lXFora := ((lX - 1) < 0);
      lYFora := ((lY - 1) < 0);

      // centro
      lMediaPixel := ValorCor(pMatrizCor.Cells[lX, lY]);

      // acima
      if lYFora then
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY - 1]);

      // acima-esquerda
      if (lYFora or  lXFora)then
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX - 1, lY - 1]);

      // esquerda
      if lXFora then
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX - 1, lY]);

      lYFora := ((lY + 1) > 281);

      // esquerda-abaixo
      if (lXFora or  lYFora)then
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX - 1, lY + 1]);

      // abaixo
      if lYFora then
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY + 1]);

      lXFora := ((lY + 1) > 281);

      // abaixo-direita
      if (lXFora or  lYFora)then
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX + 1, lY + 1]);

      // direita
      if (lXFora)then
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX + 1, lY]);

      lYFora := ((lY - 1) < 0);

      // direita-acima
      if (lYFora or  lXFora) then
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lMediaPixel := lMediaPixel + ValorCor(pMatrizCor.Cells[lX + 1, lY - 1]);

      /// Media e mudando o valor do pixel
      lMediaPixel := Round(lMediaPixel div 9);

      lMatrizAux.Cells[lX, lY] :=  GetCor(lMediaPixel);

    end;
  end;

  /// Retornar mudança
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      pMatrizCor.Cells[lX, lY] := lMatrizAux.Cells[lX, lY];
    end;
  end;
end;

procedure TfrmPrincipal.ordenarValores(var pArray: array of Integer);
var
  auxiliar, externo, interno: Integer;
begin
  for externo := 0 to 7 do
  begin
    for interno := externo + 1 to 8 do
	begin
	  if pArray[externo] > pArray[interno] then
	  begin
	    auxiliar := pArray[externo];

		  pArray[externo] := pArray[interno];
		  pArray[interno] := auxiliar;
	  end;
	end;
  end;
end;

procedure TfrmPrincipal.SuavizacaoMatriz(pMatrizCor: TStringGrid);
var
  lContador: Integer;
  lX, lY: Integer;
  lMediaPixel: Integer;
  lXFora, lYFora: Boolean;
  lArrayMinimo: Array [0..8] of Integer;
  lPixelCentral, lPixelMenor, lPixelMaior: Integer;
begin

  //// pegando a media
  /// TROCADO OS VALORES DE LX E LY NO FOR
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      /// Zerando Array
      for lContador := 0 to 8 Do
        lArrayMinimo[lContador] := 0;

      lXFora := ((lX - 1) < 0);
      lYFora := ((lY - 1) < 0);

      // centro
      lArrayMinimo[0] := ValorCor(pMatrizCor.Cells[lX, lY]);

      // acima
      if lYFora then
        lArrayMinimo[1] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[1] := ValorCor(pMatrizCor.Cells[lX, lY - 1]);

      // acima-esquerda
      if (lYFora or  lXFora)then
        lArrayMinimo[2] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[2] := ValorCor(pMatrizCor.Cells[lX - 1, lY - 1]);

      // esquerda
      if lXFora then
        lArrayMinimo[3] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[3] := ValorCor(pMatrizCor.Cells[lX - 1, lY]);

      lYFora := ((lY + 1) > 281);

      // esquerda-abaixo
      if (lXFora or  lYFora)then
        lArrayMinimo[4] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[4] := ValorCor(pMatrizCor.Cells[lX - 1, lY + 1]);

      // abaixo
      if lYFora then
        lArrayMinimo[5] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[5] := ValorCor(pMatrizCor.Cells[lX, lY + 1]);

      lXFora := ((lY + 1) > 281);

      // abaixo-direita
      if (lXFora or  lYFora)then
        lArrayMinimo[6] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[6] := ValorCor(pMatrizCor.Cells[lX + 1, lY + 1]);

      // direita
      if (lXFora)then
        lArrayMinimo[7] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[7] := ValorCor(pMatrizCor.Cells[lX + 1, lY]);

      lYFora := ((lY - 1) < 0);

      // direita-acima
      if (lYFora or  lXFora) then
        lArrayMinimo[8] := ValorCor(pMatrizCor.Cells[lX, lY])
      else
        lArrayMinimo[8] := ValorCor(pMatrizCor.Cells[lX + 1, lY - 1]);

      // Registrando pixel central
      lPixelCentral := lArrayMinimo[0];
      lArrayMinimo[0] := lArrayMinimo[1];

      // Ordenar valores no Array
      ordenarValores(lArrayMinimo);

      // Pega o valor pixel menor e maior
      lPixelMenor := lArrayMinimo[0];
      lPixelMaior := lArrayMinimo[8];

      if lPixelCentral < lPixelMenor then
        lMatrizAux.Cells[lX, lY] :=  GetCor(lPixelMenor)
      else if lPixelCentral > lPixelMaior then
        lMatrizAux.Cells[lX, lY] :=  GetCor(lPixelMaior)
      else
        lMatrizAux.Cells[lX, lY] :=  GetCor(lPixelCentral);

    end;
  end;

  /// Retornar mudança
  for lX := 0 to 281 do
  begin
    for lY := 0 to 335 do
    begin
      pMatrizCor.Cells[lX, lY] := lMatrizAux.Cells[lX, lY];
    end;
  end;
end;

function TfrmPrincipal.GetCor(pCor: Integer): string;
begin
  Result := IntToStr(pCor);
end;

function TfrmPrincipal.GetCor(pCor: String): Integer;
begin
  Result := StrToInt(pCor);
end;

function TfrmPrincipal.ValorCor(pColor: string): Integer;
begin
  Result := StrToIntDef(pColor, 0);
end;

end.
