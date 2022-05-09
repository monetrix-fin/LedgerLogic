import Foundation

class LegderObject {
    var installmentNumber: Int
    var emi: Double
    var interest: Double
    var principal: Double
    var balancePrincipal: Double
    
    init(installmentNumber: Int, emi: Double, interest: Double, principal: Double, balancePrincipal: Double) {
        self.installmentNumber = installmentNumber
        self.emi = emi
        self.interest = interest
        self.principal = principal
        self.balancePrincipal = balancePrincipal
    }
}

class Monetrix {
    let roi: Double = 3.5
    let tenure = 25
    let principal: Double = 800000
    var updatedPricipal: Double = 800000
    let investmentROI: Double = 8.54
    let monthlyInvestment: Double = 380
    var totalInvestment: Double = 0
    var numberOfInstallmentsSaved: Int = 0
    
    var legder: [(Int, Double, Double, Double, Double)] = []
    
    init() {
    }
    
    func getInterest() -> Double {
        return getMonthlyInterestRate()*updatedPricipal
    }
    
    func getNumberOfPayments() -> Int {
        return tenure*12
    }
    
    func getMonthlyInterestRate() -> Double {
        return ((roi/100)/12)
    }
    
    func getCompundRate() -> Double {
        let rate = 1 + getMonthlyInterestRate()
        return pow(rate, Double(getNumberOfPayments()))
    }
    
    func getEMIRate() -> Double {
        return (getCompundRate()/(getCompundRate()-1))
    }
    
    func getEMI() -> Double {
        return getEMIRate()*principal*getMonthlyInterestRate()
    }
    
    func getDeductedPrincipal() -> Double {
        return getEMI()-getInterest()
    }
    
    func getBalancePrincipal() -> Double {
        updatedPricipal = updatedPricipal-getDeductedPrincipal()
        return updatedPricipal
    }
    
    func getLedger() {
        for i in 1...getNumberOfPayments() {
            legder.append((i, getEMI().rounded(), getInterest().rounded(), getDeductedPrincipal().rounded(), getBalancePrincipal().rounded()))
        }
    }
    
    func getMonthlyInvestmentRate() -> Double {
        return ((investmentROI/12)/100)
    }
    
    func getInvestment() {
        for i in legder {
            if totalInvestment < i.4 {
                let sum = (totalInvestment+monthlyInvestment)*(1+getMonthlyInvestmentRate())
                totalInvestment = sum
            } else {
                numberOfInstallmentsSaved = (getNumberOfPayments() - i.0) + 1
                break
            }
        }
    }
    
    func getMoneySaved() -> Double {
        return Double(numberOfInstallmentsSaved)*getEMI().rounded()
    }
}

let user1 = Monetrix()

user1.getLedger()
user1.getInvestment()

//print(user1.getEMI())
//print(user1.legder)
//
print(user1.totalInvestment)
print(user1.getMoneySaved())
print(user1.numberOfInstallmentsSaved)
//print(user1.legder)



