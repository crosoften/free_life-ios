//
//  AccountsPayableResponse.swift
//  FreeLife
//
//  Created by Rafaella Rodrigues Santos on 19/12/24.
//

import Foundation

struct AccountsPayableResponse: Codable {
    let data: ResultData
    
    struct ResultData: Codable {
        let page: String
        let total: String
        let registros: [Registro]
    }
    
    struct Registro: Codable {
        let tipoPix: String
        let idDadoBancario: String
        let id: String
        let liberado: String
        let filialID: String
        let status: String
        let dataEmissao: String
        let dataVencimento: String
        let valor: String
        let valorAberto: String
        let valorPago: String
        let dataPagamento: String
        let idFornecedor: String
        let valorTotalPago: String
        let debitoData: String
        let statusAuditoria: String
        let estornado: String
        let obs: String
        let documento: String
        let numeroNota: String
        let idEntrada: String
        let tipoPagamento: String
        let previsao: String
        let codigoBarras: String
        let idConta: String
        let duplicata: String
        let lote: String
        let idContas: String
        let valorCancelado: String
        let idMotCancelamento: String
        let dataCancelamento: String
        let chavePix: String
        let ehDespesaVeiculo: String
        let idLotePagamento: String
        let comunicado: String
        
        enum CodingKeys: String, CodingKey {
            case tipoPix = "tipo_pix"
            case idDadoBancario = "id_dado_bancario"
            case id, liberado
            case filialID = "filial_id"
            case status
            case dataEmissao = "data_emissao"
            case dataVencimento = "data_vencimento"
            case valor
            case valorAberto = "valor_aberto"
            case valorPago = "valor_pago"
            case dataPagamento = "data_pagamento"
            case idFornecedor = "id_fornecedor"
            case valorTotalPago = "valor_total_pago"
            case debitoData = "debito_data"
            case statusAuditoria = "status_auditoria"
            case estornado, obs, documento
            case numeroNota = "numero_nota"
            case idEntrada = "id_entrada"
            case tipoPagamento = "tipo_pagamento"
            case previsao
            case codigoBarras = "codigo_barras"
            case idConta = "id_conta"
            case duplicata, lote
            case idContas = "id_contas"
            case valorCancelado = "valor_cancelado"
            case idMotCancelamento = "id_mot_cancelamento"
            case dataCancelamento = "data_cancelamento"
            case chavePix = "chave_pix"
            case ehDespesaVeiculo = "eh_despesa_veiculo"
            case idLotePagamento = "id_lote_pagamento"
            case comunicado
        }
    }
}

