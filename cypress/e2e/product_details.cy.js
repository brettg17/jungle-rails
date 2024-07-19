const { INTERNAL } = require("@rails/actioncable")
const configYargs = require("webpack-cli/bin/config/config-yargs")

describe('Products Page', () => {
  it('should visit the home page', () => {
    cy.visit('/');
  });

  it('There are products on the page', () => {
    cy.visit('/')
    cy.get('.products article').should('be.visible');
  });

  it('There is 2 products on the page', () => {
    cy.visit('/')
    cy.get('.products article').should('have.length', 2);
  });

  it('lets you visit the selected product detail page', () => {
    cy.visit('/');
    cy.get('.products article').first().find('a').first().click();
    cy.url().should('include', '/products/'); 
  });
});