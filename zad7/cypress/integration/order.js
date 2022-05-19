describe('Page load test', () => {
    it('Checks if order page loads correctly', () => {
        cy.visit('http://localhost:3000/order/')
        cy.contains('Usługa')
        cy.contains('Cena')
        cy.contains('Do kasy')
        cy.get('nav').should('exist')
    })

    it('Checks if initial order is empty', () => {
        cy.contains('Do zapłaty: 0')
    })
})

describe('Navigation test', () => {
    beforeEach(() => {
        cy.visit('http://localhost:3000/order/')
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

    it('Clicks on Do kasy hyperlink', () => {
        cy.get('[href="/payment/"]').click()
        cy.url().should('eq', 'http://localhost:3000/payment/')
    })
})

describe('order functionality test', () => {
    it('Adds Podlewanie kwiatków and checks if it has been added correctly', () => {
        cy.visit('http://localhost:3000/services/')
        cy.get(':nth-child(1) > pre > button').click()
        cy.get('[href="/order/"]').click()
        cy.get('ul').children().should('have.length.gt', 0)
        cy.get('ul').children().first().should('contain', 'Podlewanie kwiatków')
        cy.get('.service').should('contain', 'Do zapłaty: 5')
    })

    it('Removes Podlewanie kwiatków from order', () => {
        cy.get('ul').children().first().get('button').click()
        cy.get('.service').should('contain', 'Do zapłaty: 0')
    })
})
