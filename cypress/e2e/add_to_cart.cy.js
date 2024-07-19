const { INTERNAL } = require("@rails/actioncable")
const configYargs = require("webpack-cli/bin/config/config-yargs")

describe('Cart', () => {
  it('Visits the home page and adds item to cart', () => {
    cy.visit('http://localhost:3000'); 
    cy.log('Visited the home page');

    //products should be visible
    cy.get(".products article").should("be.visible");
    cy.log('Products are visible');

    //verify initial state of cart is at 0
    cy.contains("My Cart (0)").should("be.visible");
    cy.log('Cart is initially empty');

    //find first article and click add to cart
    cy.get("article").first().contains("Add").click();
    cy.log('Clicked on Add to Cart button');

    //number in cart should increase by 1
    cy.contains("My Cart (1)").should("be.visible");
    cy.log('Cart count increased by 1');
  });
});