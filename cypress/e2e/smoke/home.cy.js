describe('Home Page Smoke Test', () => {
    it('loads homepage', () => {
      cy.visit('/')
      cy.contains('Example Domain')
    })
  })
  