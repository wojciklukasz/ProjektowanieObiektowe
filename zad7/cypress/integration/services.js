describe('Page load test', () => {
    it('Checks if services page loads correctly', () => {
        cy.visit('http://localhost:3000/services/')
        cy.contains('Usługa')
        cy.contains('Cena')
        cy.get('nav').should('exist')
    })
})

describe('Navigation test', () => {
    beforeEach(() => {
        cy.visit('http://localhost:3000/services/')
    })

    it('Clicks on Strona Główna hyperlink', () => {
        cy.get('[href="/"]').click()
        cy.url().should('eq', 'http://localhost:3000/')
    })

    it('Clicks on Usługi hyperlink', () => {
        cy.get('[href="/services/"]').click()
        cy.url().should('eq', 'http://localhost:3000/services/')
    })

    it('Clicks on Zamówienie hyperlink', () => {
        cy.get('[href="/order/"]').click()
        cy.url().should('eq', 'http://localhost:3000/order/')
    })
})

describe('services list test', () => {
    beforeEach(() => {
        cy.visit('http://localhost:3000/services/')
    })

    it('Checks if services list is not empty', () => {
        cy.get('ul').should('have.length.gt', 0)
    })

    it('Checks if correct sample services are loaded', () => {
        cy.get(':nth-child(1) > pre').should('contain', 'Podlewanie kwiatków')
        cy.get(':nth-child(1) > pre').should('contain', '5')
        cy.get(':nth-child(1) > pre > button').should('exist')
        cy.get('ul').last().should('contain', 'Sprzątanie garażu')
        cy.get('ul').last().should('contain', '25')
        cy.get('ul').last().get('button').last().should('exist')
    })
})
