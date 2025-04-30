//
//  FinanceRecordResponse.swift
//  FreeLife
//
//  Created by Jeferson Dias dos Santos on 30/04/25.
//


struct FinanceRecordResponse: Codable {
    let page: String
    let total: String
    let registros: [FinanceRecord]?
}

struct FinanceRecord: Codable {
    let idRemessa: String
    let gatewayLink: String
    let nnBoleto: String
    let boleto: String
    let dataInicial: String
    let dataFinal: String
    let estornado: String
    let id: String
    let liberado: String
    let filialId: String
    let status: String
    let dataEmissao: String
    let dataVencimento: String
    let valor: String
    let obs: String
    let valorRecebido: String
    let valorAberto: String
    let idCliente: String
    let pagamentoValor: String
    let pagamentoData: String
    let idCarteiraCobranca: String
    let creditoData: String
    let baixaData: String
    let numeroParcelaRecorrente: String
    let documento: String
    let idSaida: String
    let tipoRecebimento: String
    let tipoRenegociacao: String
    let valorCancelado: String
    let dataCancelamento: String
    let idMotCancelamento: String
    let idRenegociacao: String
    let idCobranca: String
    let previsao: String
    let idRenegociacaoNovo: String
    let liberaPeriodo: String
    let impresso: String
    let formaRecebimento: String
    let arquivoRemessaBaixado: String
    let nparcela: String
    let idNotaGeradaOpc4: String
    let statusCobranca: String
    let tipoCobranca: String
    let idContratoPrincipal: String
    let idContratoAvulso: String
    let idContrato: String
    let idNotaGerada: String
    let idImImovel: String
    let parcelaProporcional: String
    let linhaDigitavel: String
    let duplicata: String
    let tipoPagamentoCartao: String
    let idSip: String
    let tituloProtestado: String
    let descontoCondicionalValor: String
    let gerencianetToken: String
    let validadeDescontoCondicional: String
    let idConta: String
    let tituloRenegociado: String
    let motivoAlteracao: String
    let idRemessaAlteracao: String
    let cancelamentoIdOperador: String
    let baixaIdOperador: String
    let tituloImportado: String
    let origemImportacao: String
    let ultimaAtualizacao: String
    let aguardandoConfirmacaoPagamento: String
    let parceladoCartao: String
    let pixTxid: String
    let idNotaGeradaOpc2: String
    let idNotaGeradaOpc3: String
    let recebidoViaPix: String
    let idLoteGeracaoFinanceiroFatura: String

    enum CodingKeys: String, CodingKey {
        case idRemessa = "id_remessa"
        case gatewayLink = "gateway_link"
        case nnBoleto = "nn_boleto"
        case boleto
        case dataInicial = "data_inicial"
        case dataFinal = "data_final"
        case estornado
        case id
        case liberado
        case filialId = "filial_id"
        case status
        case dataEmissao = "data_emissao"
        case dataVencimento = "data_vencimento"
        case valor
        case obs
        case valorRecebido = "valor_recebido"
        case valorAberto = "valor_aberto"
        case idCliente = "id_cliente"
        case pagamentoValor = "pagamento_valor"
        case pagamentoData = "pagamento_data"
        case idCarteiraCobranca = "id_carteira_cobranca"
        case creditoData = "credito_data"
        case baixaData = "baixa_data"
        case numeroParcelaRecorrente = "numero_parcela_recorrente"
        case documento
        case idSaida = "id_saida"
        case tipoRecebimento = "tipo_recebimento"
        case tipoRenegociacao = "tipo_renegociacao"
        case valorCancelado = "valor_cancelado"
        case dataCancelamento = "data_cancelamento"
        case idMotCancelamento = "id_mot_cancelamento"
        case idRenegociacao = "id_renegociacao"
        case idCobranca = "id_cobranca"
        case previsao
        case idRenegociacaoNovo = "id_renegociacao_novo"
        case liberaPeriodo = "libera_periodo"
        case impresso
        case formaRecebimento = "forma_recebimento"
        case arquivoRemessaBaixado = "arquivo_remessa_baixado"
        case nparcela
        case idNotaGeradaOpc4 = "id_nota_gerada_opc4"
        case statusCobranca = "status_cobranca"
        case tipoCobranca = "tipo_cobranca"
        case idContratoPrincipal = "id_contrato_principal"
        case idContratoAvulso = "id_contrato_avulso"
        case idContrato = "id_contrato"
        case idNotaGerada = "id_nota_gerada"
        case idImImovel = "id_im_imovel"
        case parcelaProporcional = "parcela_proporcional"
        case linhaDigitavel = "linha_digitavel"
        case duplicata
        case tipoPagamentoCartao = "tipo_pagamento_cartao"
        case idSip = "id_sip"
        case tituloProtestado = "titulo_protestado"
        case descontoCondicionalValor = "desconto_condicional_valor"
        case gerencianetToken = "gerencianet_token"
        case validadeDescontoCondicional = "validade_desconto_condicional"
        case idConta = "id_conta"
        case tituloRenegociado = "titulo_renegociado"
        case motivoAlteracao = "motivo_alteracao"
        case idRemessaAlteracao = "id_remessa_alteracao"
        case cancelamentoIdOperador = "cancelamento_id_operador"
        case baixaIdOperador = "baixa_id_operador"
        case tituloImportado = "titulo_importado"
        case origemImportacao = "origem_importacao"
        case ultimaAtualizacao = "ultima_atualizacao"
        case aguardandoConfirmacaoPagamento = "aguardando_confirmacao_pagamento"
        case parceladoCartao = "parcelado_cartao"
        case pixTxid = "pix_txid"
        case idNotaGeradaOpc2 = "id_nota_gerada_opc2"
        case idNotaGeradaOpc3 = "id_nota_gerada_opc3"
        case recebidoViaPix = "recebido_via_pix"
        case idLoteGeracaoFinanceiroFatura = "id_lote_geracao_financeiro_fatura"
    }
}
