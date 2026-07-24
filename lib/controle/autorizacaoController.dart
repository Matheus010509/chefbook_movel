import 'dart:convert';

import 'package:login/modelo/classes/autorizacao.dart';
import 'package:login/modelo/classes/receita.dart';
import 'package:login/modelo/LocalStorageService.dart';


class AutorizaController{

  static Future<void> gravaAutorizacao(String usuario, String token) async{
    Autorizacao auth = new Autorizacao(usuario: usuario, senha: '', token_autorizacao: token);
    //salvando receita na lista persistida
    await LocalStorageService.salvarAutorizacao(auth);
  }
  static Future<void> desgravaAutorizacao() async{
    await LocalStorageService.desgravarAutorizacao();
  }

  /**
   * função fake de autenticação na api de forma positiva
   */
  static Future <bool> verificaAutorizacaoOnline(Autorizacao auth) async{
    //faço a chamada à API enviando o json do meu objeto de autorizacao
    //envio este json para a API para obter o token
    //json.encode(auth.toMap());

    //simula o retorno da api
    if(auth.usuario=='matheus@gmail' && auth.senha=='123456') {
      Autorizacao authApiRetorno = Autorizacao(
          usuario: "matheus",
          senha: '',
          token_autorizacao: "çalskdfsoiu23j́bdçvocuiyvhkjqerb-iudfhnsbdkljqghoi"
      );
      gravaAutorizacao(
          authApiRetorno.usuario, authApiRetorno.token_autorizacao);
      return true;
    }else{
      return false;
    }
  }

  static Future <bool> verificaAutorizacaoOffline() async{
    Autorizacao? auth =  await LocalStorageService.carregarAutorizacao();
    if(auth==null) return false;
    return true;
  }

}