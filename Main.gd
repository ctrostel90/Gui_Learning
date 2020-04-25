extends Node

var screen_size = OS.get_screen_size()
var window_size = OS.get_window_size()

onready var origin = $SysOrigin
onready var numPlanets = $UI/TabContainer/VBoxContainer/NumPlanets/niNumPlanets

var xOffset = 50

var BaseMesh = preload("res://BaseMesh.tscn")
var PlanetInfoUI = preload("res://scenes//ui//PlanetInfoUI.tscn")

func _ready():
	#For some reason godot doesn't start the window in the center of the screen, this solves that
	OS.set_window_position(screen_size*0.5 - window_size*0.5)	


func _on_GenerateSystem_pressed():
	#Clear the existing planets
	clearGeneratedSystem()
	#Create a new system
	GenerateSystem()

func clearGeneratedSystem():
	for child in origin.get_children():
		origin.remove_child(child)

func GenerateSystem():
	
	#Generate a star type
	var Star = GenerateStar()
	#Generate the orbital bodies
	var numBodies = randi()%5+1
	for i in range(numBodies):
		GenerateOrbitalBody(Star,i)
	#updateOrbitals()
	
func GenerateStar():
	#Determine the size (random)
	var Star = BaseMesh.instance()
	origin.add_child(Star)
	Star.set_BodyScale(rand_range(0.1,2.5))
	Star.set_name("Star")
	return Star
	
func GenerateOrbitalBody(Star,index):
	var Planet = BaseMesh.instance()
	Star.add_child(Planet)
	Planet.position.x = (index +1) * xOffset + 100
	#determine the size
	Planet.set_BodyScale(rand_range(0.01,1.5))
	Planet.set_name("Planet_" + str(index))
	Planet.bodyName = "Planet " + str(index)
	
	Planet.setColor(Color(rand_range(0,1),rand_range(0,1),rand_range(0,1),1.0))
