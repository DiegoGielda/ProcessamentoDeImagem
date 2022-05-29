program ProcessamentoDeImagem;

uses
  Vcl.Forms,
  formPrincipal in '..\Formularios\formPrincipal.pas' {frmPrincipal},
  Vcl.Styles,
  Vcl.Themes;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
