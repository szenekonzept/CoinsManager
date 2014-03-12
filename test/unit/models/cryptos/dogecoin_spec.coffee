describe "Dogecoin", ->

  beforeEach ->
    @data =
      address: "DCMWPxrhrj12RhvqXTsT1NeM9TLYutdwV2"

  it "exists", ->
    Dogecoin.should.be.ok
    Dogecoin.should.be.an.Object

  it "has a code DOGE", ->
    Dogecoin.should.have.a.property "code", "DOGE"

  describe "verifyAddress", ->

    it "is a class method", ->
      Dogecoin.should.have.a.property "verifyAddress"
      Dogecoin.verifyAddress.should.be.a.Function

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
            Dogecoin.verifyAddress address
          ).should.throw reason

    it "returns false if the address is correct", ->
      Meteor.call = ->
        content: "1E"
      Dogecoin.verifyAddress(@data.address).should.eql false
