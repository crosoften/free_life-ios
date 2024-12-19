//
//  CurrentPlanManager.swift
//  ClickParts
//
//  Created by Rafaella Rodrigues Santos on 19/09/24.
//

import Foundation

class PlanManager {
    
    private let currentPlanKey = "currentPlan"
    
    // Salvar o plano atual
    func saveCurrentPlan(_ plan: PlansEnum) {
        UserDefaults.standard.set(plan.rawValue, forKey: currentPlanKey)
    }
    
    // Retornar o plano atual
    func getCurrentPlan() -> PlansEnum {
        if let savedPlan = UserDefaults.standard.string(forKey: currentPlanKey),
           let plan = PlansEnum(rawValue: savedPlan) {
            return plan
        }
        return .free // Valor padrão caso não tenha um plano salvo
    }
}
