class Menu
  constructor: ->
    @display()

  drinks: [
    "Latte"
    "Mocha"
    "Cappuccino"
  ]

  extras: [
    "Espresso Shot"
    "Vanilla Syrup"
    "Cinnamon"
  ]

  sizes: [
    "Tall"
    "Grande"
    "Venti"
  ]

  display: =>
    unless $('#menu').length > 0
      $('#content').append("<div id='menu' class='row'></div>")
    @displaySubMenu @drinks, 'drink'
    @displaySubMenu @extras, 'extra'
    @displaySubMenu @sizes, 'size'

  displaySubMenu: (list, name) ->
    unless $("##{name}s").length > 0
      menuTitle = name[0].toUpperCase() + name[1..] + 's'
      $('#content #menu').append "<div id='#{name}s' class='span4'>
        <div class='well'>
        <h2>#{menuTitle}</h2>
        <ul id='#{name}_list'>
        </ul>
        </div>
        </div>"
      $("##{name}_list").append "<li>#{item}</li>" for item in list

class Coffee
  constructor: (@tray, @size, @drink, @extras = []) ->
    @display()

  addedExtras: =>
    if @extras.length > 0
      "with #{@extras.join(' &amp; ')}"
    else
      ""

  display: =>
    @tray.append "<li class='coffee'>
      #{@size} #{@drink} #{@addedExtras()}
      </li>"

class Customer
  constructor: (@menu)->
    @drowsy = yes
    @tray = @buildTray()

  buildTray: =>
    $('#content').append "<div id='tray' class='row'>" unless $('#tray').length > 0
    $('#tray').html "<h3>Coffee Tray</h3>
      <ul>
      </ul>"
    $('#tray')

  order: =>
    size = @menu.sizes.sample()
    drink = @menu.drinks.sample()
    n = [0..3].sample()
    extras = if n > 0 then @menu.extras.sample() for x in [1..n] else []
    coffee = new Coffee(@tray,size,drink,extras)
    @consume()

  consume: =>
    @drowsy = no if Math.random() > 0.9

  wakeUp: =>
    @order() while @drowsy

class Application
  constructor: ->
    @menu = new Menu()
    $('#new_customer_button').on 'click', @generateCustomer

  generateCustomer: (e) =>
    e.preventDefault()
    customer = new Customer(@menu)
    customer.wakeUp()

$ ->
  Array::sample = ->
    @sort -> 0.5 - Math.random()
    @[0]
  app = new Application()






















