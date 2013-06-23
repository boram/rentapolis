Ember.Application.initializer
  name: 'currentUser',

  initialize: (container) ->
    if window.current_user
      id = window.current_user.id
      userJson = { user: { email: window.current_user.email } }

      store = DS.get('defaultStore')
      adapter = store.adapterForType(Rentapolis.User)
      adapter.didFindRecord(store, Rentapolis.User, userJson, id)

      user = Rentapolis.User.find(id)
      Rentapolis.set('currentUser', user)

