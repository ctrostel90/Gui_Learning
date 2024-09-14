extends Node2D
//Test
export(float) var orbitPeriod
export(float) var orbitSpeed
export(float) var xAxis
export(float) var yAxis

export(float) var bodyScale = 1

export(String) var bodyName = ""

#onready var PlanetNameLabel = $UI/Container/BodyName
onready var DrawnBody = $Shape

var orbitProgress = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#PlanetNameLabel.text = bodyName

func draw_ellipse(orbitingBody):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	for i in range(nb_points + 1):
		#var angle_point = EvaluateOrbit_Full(float(i)/float(nb_points),orbitingBody.xAxis,orbitingBody.yAxis)
		var angle_point = orbitingBody.EvaluateOrbit(float(i)/float(nb_points))
		var pos = angle_point
		points_arc.push_back(pos)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], Color.yellow)

func set_BodyScale(value):
	DrawnBody.scale.x = value
	DrawnBody.scale.y = value

func setColor(value):
	DrawnBody.modulate = value

func EvaluateOrbit(orbitPos):
	var pos = Vector2(0,0)
	var angle = deg2rad(360*orbitPos)
	pos.x = sin(angle) * xAxis
	pos.y = cos(angle) * yAxis
	return pos

func EvaluateOrbit_Full(orbitPos,x_Axis,y_Axis):
	var pos = Vector2(0,0)
	var angle = deg2rad(360*orbitPos)
	pos.x = sin(angle) * x_Axis
	pos.y = cos(angle) * y_Axis
	return pos

func _process(delta):
	return
	update()
	if orbitPeriod<0.01:
		orbitPeriod = 0.01
	orbitSpeed = 1 / orbitPeriod	
	
	orbitProgress += delta * orbitSpeed
	orbitProgress = fmod(orbitProgress,1.0)
	
	self.position = EvaluateOrbit(orbitProgress)
	

#if we're supposed to be unZoomed, we need to change the sprite and somehow make this object uneffected by the zoom...how do I do this?

