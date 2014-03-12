describe "NobleCoin", ->

  beforeEach ->
    @data =
      address: "9m92Xja31Fa9wMooFrVHrUmY79sHa3rJG9"

  it "exists", ->
    NobleCoin.should.be.ok
    NobleCoin.should.be.an.Object

  it "has a code NOBL", ->
    NobleCoin.should.have.a.property "code", "NOBL"

  describe "verifyAddress", ->

    it "is a class method", ->
      NobleCoin.should.have.a.property "verifyAddress"
      NobleCoin.verifyAddress.should.be.a.Function

    errors =
      X5: "Address not base58"
      SZ: "Address not the correct size"
      CK: "Failed hash check"

    for error, reason of errors
      do (error, reason) ->
        it "can return an error '#{reason}'", ->
          address = @data.address
          Meteor.call = -> content: error

          (->
            NobleCoin.verifyAddress address
          ).should.throw reason

    it "returns false if the address is correct", ->
      Meteor.call = ->
        content: "15"
      NobleCoin.verifyAddress(@data.address).should.eql false
