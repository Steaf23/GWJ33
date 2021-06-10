extends Node

func play(victory):
	if victory:
		$Victory.play()
	else:
		$Defeat.play()

func stop():
	$Victory.stop()
	$Defeat.stop()
