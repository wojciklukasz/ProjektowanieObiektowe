describe('Page load test', () => {
    it('Visits main page', () => {
        cy.visit('http://localhost:3000')

        cy.contains('Aplikacja na Projektowanie Obiektowe')
        cy.get('nav').should('exist')
    })
})

describe('Navigation test', () => {
    beforeEach(() => {
        cy.visit('http://localhost:3000/')
    })

    it('Clicks on Strona Główna hyperlink', () => {
        cy.get('[href="/"]').click()
        cy.url().should('eq', 'http://localhost:3000/')
    })

    it('Clicks on Usługi hyperlink', () => {
        cy.get('[href="/services/"]').click()
        cy.url().should('eq', 'http://localhost:3000/services/')
    })

    it('Clicks on Zamówienia hyperlink', () => {
        cy.get('[href="/order/"]').click()
        cy.url().should('eq', 'http://localhost:3000/order/')
    })
})