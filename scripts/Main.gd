extends Node


var collected_stars = 0


func _ready():
	for star in $Stars.get_children():
		star.connect("collected", self, "_on_collected_star")

func _process(_delta):
	$Status/LabelLifes.text = str($Player.lifes)

func _on_collected_star():
	collected_stars += 1
	$Status/Label.text = str(collected_stars)
