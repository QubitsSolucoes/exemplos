unit uZeroConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  storeware.idZeroConf, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FZeroConfClient: TIdZeroConfClient;
  public
    { Public declarations }
    procedure DoReceberDados(Sender: TObject; AMessage: String);
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FormCreate(Sender: TObject);
begin

  // incia o cliente
  // -------------------------------------------------
  FZeroConfClient := TIdZeroConfClient.create(self);
  FZeroConfClient.OnResponseEvent := DoReceberDados;

end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  if not FZeroConfClient.active then
    FZeroConfClient.active := true;
  Memo1.Lines.Add('Envia comando de procurar servidor ('+FormatdateTime('hh:mm:ss',now)+')');
  FZeroConfClient.BroadcastIP := '';//'192.168.56.1';
  FZeroConfClient.Send;
end;

procedure TForm4.DoReceberDados(Sender: TObject; AMessage: String);
begin
  // AMessage - retorna o JSON com os dados do servidor
  Memo1.Lines.Add('Resposta('+FormatdateTime('hh:mm:ss',now)+'):'+AMessage);
  Memo1.Lines.Add('');
//  FZeroConfClient.Active := false; // desliga
end;


end.
