unit formPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

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
    imgResultante: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

end.
