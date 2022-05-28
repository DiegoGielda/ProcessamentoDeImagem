program ProcessamentoDeImagem;

uses
  Vcl.Forms,
  formPrincipal in '..\Formularios\formPrincipal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
