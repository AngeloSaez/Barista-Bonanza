extends Node2D

# Coffee types, their recipes, and initial preparation time
var coffee_types = {
	"Espresso": ["Espresso"],
	"Double Espresso": ["Espresso", "Espresso"],
	"Red Eye": ["Espresso", "Brewed Coffee"],
	"Black Eye": ["Espresso", "Espresso", "Brewed Coffee"],
	"Americano": ["Espresso", "Water"],
	"Long Black": ["Espresso", "Water"],
	"Macchiato": ["Espresso", "Foamed Milk"],
	"Long Macchiato": ["Espresso", "Foamed Milk", "Foamed Milk"],
	"Cortado": ["Espresso", "Warm Milk"],
	"Breve": ["Espresso", "Milk", "Cream"],
	"Cappuccino": ["Espresso", "Steamed Milk", "Milk Foam"],
	"Flat White": ["Espresso", "Steamed Milk", "Microfoam"],
	"Cafe Latte": ["Espresso", "Steamed Milk", "Milk Foam"],
	"Mocha": ["Espresso", "Steamed Milk", "Milk Foam", "Chocolate"],
	"Vienna": ["Espresso", "Whipped Cream"],
	"Affogato": ["Vanilla Gelato", "Espresso"],
	"Cafe au Lait": ["Espresso", "Steamed Milk"],
	"Brewed Coffee": ["Brewed Coffee"],
	"Iced Coffee": ["Brewed Coffee", "Ice"]
}

# Ingredients currently added to the coffee
var current_recipe : Array = []

# Level system
var current_level : int = 1
var level_time_multiplier : float = 0.9  # Adjust this multiplier to increase or decrease difficulty
var orders_per_level : int = 2

# Orders display
var orders_label : Label

# Queue to manage multiple orders
var orders_queue: Array = []

func _ready():
	# Initialize the orders display
	print("Scene is ready!")
	orders_label = Label.new()
	orders_label.text = "Orders:\n"
	orders_label.modulate = Color(0, 0, 0)  # Set the text color to black
	add_child(orders_label)
	prepare_next_coffee()

func _process(delta):
	# Check if the timer is active and update orders display
	for coffee_order in orders_queue:
		if coffee_order.timer > 0.0:
			coffee_order.timer -= delta
			if coffee_order.timer <= 0.0:
				print("Time's up! Serve the next coffee.")
				prepare_next_coffee()

	update_orders_display()

func prepare_coffee(coffee_type):
	# Prepare the specified coffee type
	if coffee_type in coffee_types:
		print("Preparing", coffee_type, " - Level", current_level)
		current_recipe = []
		var timer_value = coffee_types[coffee_type].size() * (level_time_multiplier ** (current_level - 1)) * 2.0  # Increased timer
		var coffee_order = {
			"type": coffee_type,
			"recipe": coffee_types[coffee_type],
			"time": timer_value,
			"timer": timer_value
		}
		orders_queue.append(coffee_order)
	else:
		print("Unknown coffee type:", coffee_type)

func prepare_next_coffee():
	# Remove existing orders
	orders_queue.clear()

	# Prepare the next set of coffee orders for the current level
	for i in range(orders_per_level * 2):  # Larger number of orders
		var coffee_order = get_random_complex_coffee_order()
		prepare_coffee(coffee_order)

	current_level += 1


func get_random_complex_coffee_order():
	# Select random coffee types with increasing complexity as levels progress
	var coffee_order_list = get_ordered_complex_coffee_list(current_level)
	return coffee_order_list[randi_range(0, len(coffee_order_list) - 1)]


func get_ordered_complex_coffee_list(level):
	# List of all coffee types
	var all_coffee_types = [
		"Espresso",
		"Double Espresso",
		"Red Eye",
		"Black Eye",
		"Americano",
		"Long Black",
		"Macchiato",
		"Long Macchiato",
		"Cortado",
		"Breve",
		"Cappuccino",
		"Flat White",
		"Cafe Latte",
		"Mocha",
		"Vienna",
		"Affogato",
		"Cafe au Lait",
		"Brewed Coffee",
		"Iced Coffee"
		# Add more coffee types as needed
	]

	# Calculate the index to start from based on the level
	var start_index = (level - 1) % all_coffee_types.size()

	# Generate a list starting from the calculated index with an increment based on the level
	var ordered_list = []

	# Linearly increase the number of orders every 3 levels
	var orders_to_add = 1 + (level - 1) / 3
	for i in range(orders_to_add):
		ordered_list.append(all_coffee_types[(start_index + i) % all_coffee_types.size()])

	return ordered_list

# Functions to add ingredients to the current recipe
func add_ingredient(ingredient):
	current_recipe.append(ingredient)
	print("Added", ingredient, "to the recipe:", current_recipe)

# Example of handling button presses (customize based on your input system)
func _input(event):
	if event is InputEventKey:
		var key = event.scancode
		match key:
			KEY_A:
				add_ingredient("Espresso")
			KEY_B:
				add_ingredient("Milk")
			KEY_C:
				add_ingredient("Foamed Milk")
			KEY_D:
				add_ingredient("Chocolate")
			KEY_E:
				add_ingredient("Whipped Cream")
			KEY_F:
				add_ingredient("Cream")
			KEY_G:
				add_ingredient("Vanilla Gelato")
			KEY_H:
				add_ingredient("Iced Espresso")

func update_orders_display():
	var orders_text = "Orders:\n"
	for coffee_order in orders_queue:
		orders_text += "- " + coffee_order["type"] + "\n"
		# Include ingredients in the order display
		orders_text += "  Ingredients: " + str(coffee_order["recipe"]) + "\n"
	orders_label.text = orders_text

