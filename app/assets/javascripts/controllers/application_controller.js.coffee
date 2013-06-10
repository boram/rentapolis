Rentapolis.ApplicationController = Ember.Controller.extend
  initialize: ->
    @resetLogin()

  login: ->
    Ember.$.ajax
      url: '/api/sessions.json'
      type: 'POST'
      data:
        email: @get('email')
        password: @get('password')

      success: (json) =>
        Rentapolis.User.find(json.user.id).then (user) ->
          Rentapolis.set('currentUser', user)
          @transitionToRoute('rentals.index')

      error: (xhr) =>
        json = $.parseJSON(xhr.responseText)
        @setProperties
          email: null
          password: null
          errorMessage: json.message

  logout: ->
    Ember.$.ajax
      url: '/api/sessions.json',
      type: 'DELETE',

      success: (json) =>
        Rentapolis.set('currentUser', null)
        @resetLogin()
        @transitionToRoute('rentals')

  resetLogin: ->
    @setProperties
      email: null
      password: null
      errorMessage: null
