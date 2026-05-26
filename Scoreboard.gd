extends Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize scores to "0" when the game starts
	# Get the label nodes by their names (assuming they are siblings or accessible via relative path)
	var scoreLeftLabel = get_node("../ScoreLeft")
	var scoreRightLabel = get_node("../ScoreRight")

	if scoreLeftLabel:
		scoreLeftLabel.text = "0"
	if scoreRightLabel:
		scoreRightLabel.text = "0"

func pointEarned(point: int, player: int) -> void:
	# Check which player scored
	if player == 1:
		var scoreLabel = get_node("../ScoreLeft") # Get reference to ScoreLeft label
		if scoreLabel:
			var currentScore = int(scoreLabel.text) # Convert current text to integer
			currentScore += point                  # Add points
			scoreLabel.text = str(currentScore)   # Convert back to string and set

	elif player == 2:
		var scoreLabel = get_node("../ScoreRight") # Get reference to ScoreRight label
		if scoreLabel:
			var currentScore = int(scoreLabel.text) # Convert current text to integer
			currentScore += point                  # Add points
			scoreLabel.text = str(currentScore)   # Convert back to string and set


func _process(delta: float) -> void:
	pass
	
	
