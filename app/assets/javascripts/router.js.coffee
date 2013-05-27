Rentapolis.Router.reopen
  location: 'history'

Rentapolis.Router.map (match) ->
  @resource 'rentals', { path: '/' }, ->
    @resource 'rental', { path: 'rentals/:rental_id' }
  @resource 'home'
  @resource 'neighborhoods'
  @resource 'prospects'
  @resource 'account'

Rentapolis.IndexRoute = Em.Route.extend
  redirect: ->
    @transitionTo 'rentals'

Rentapolis.RentalsRoute = Em.Route.extend
  model: ->
    Rentapolis.Rental.find()

Rentapolis.RentalRoute = Em.Route.extend
  model: (params) ->
    Rentapolis.Rental.find(params.rental_id)
