extends RichTextLabel

var gameTimeInSeconds = 0

func _ready():
	pass # Replace with function body.


func _on_GameTimer_timeout():
	gameTimeInSeconds +=1
	var minutes = gameTimeInSeconds/60
	var seconds = gameTimeInSeconds%60

	if seconds < 10:
		self.text = "Time: " + str(minutes) + ":0" + str(seconds)
	else:
		self.text = "Time: " + str(minutes) + ":" + str(seconds)

func fetchGameTime():
	return gameTimeInSeconds 
