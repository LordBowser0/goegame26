extends CanvasLayer

signal event_chosen
signal go_back

var valid: Array[bool] = []
var current_event: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	valid = [true, false, false, false]
	$"option 1".pivot_offset = $"option 1".size / 2
	$"option 2".pivot_offset = $"option 2".size / 2
	$"option 3".pivot_offset = $"option 3".size / 2
	$"option 4".pivot_offset = $"option 4".size / 2


## todo remove
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			visible = !visible


func _on_textbox_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Rich text clicked")

var scaling = 1.05

func _on_option_1_mouse_entered() -> void:
	if valid[0]:
		$"option 1".scale *= scaling


func _on_option_1_mouse_exited() -> void:
	$"option 1".scale = Vector2.ONE


func _on_option_2_mouse_entered() -> void:
	if valid[1]:
		$"option 2".scale *= scaling


func _on_option_2_mouse_exited() -> void:
	$"option 2".scale = Vector2.ONE


func _on_option_3_mouse_entered() -> void:
	if valid[2]:
		$"option 3".scale *= scaling


func _on_option_3_mouse_exited() -> void:
	$"option 3".scale = Vector2.ONE


func _on_option_4_mouse_entered() -> void:
	if valid[3]:
		$"option 4".scale *= scaling


func _on_option_4_mouse_exited() -> void:
	$"option 4".scale = Vector2.ONE


func _on_option_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and valid[0]:
			print("Option 1")
			visible = false
			match current_event:
				Main.LocationEvents.GOOSE:
					Globals.next_event = Main.Followups.GOOSE_1
				Main.LocationEvents.ALLEY:
					Globals.next_event = Main.Followups.SW_SLAP
				Main.LocationEvents.ROSE_BUSH:
					Globals.next_event = Main.Followups.SLEEP_SLAP
				Main.LocationEvents.GRANDMA or Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_AGAIN:
					Globals.next_event = Main.Followups.GRANDMA_ABOUT
				Main.LocationEvents.COUNT + Main.FigureEvents.FROG:
					if Globals.get_flag(Main.FlagIndices.FROG_GOOSE) or Globals.get_flag(Main.FlagIndices.FROG_WOLF):
						Globals.give_item(Main.ItemIndices.HAS_SEAL_ALBRECHT)
					else:
						go_back.emit()
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GOOSE_1:
					Globals.next_event = Main.Followups.GOOSE_2
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.FOUND_CLUB:
					Globals.set_flag(Main.FlagIndices.FOUND_CLUB)
					Globals.give_item(Main.ItemIndices.HAS_CLUB)
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_ABOUT:
					pass # end dialogue
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_RED:
					pass # end dialogue
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_WINE:
					if Globals.get_flag(Main.FlagIndices.DEFEATED_WOLF):
						Globals.give_item(Main.ItemIndices.HAS_SEAL_GERVINUS)
					else:
						Globals.next_event = Main.Followups.DEATH
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.SW_SLAP:
					Globals.next_event = Main.Followups.SW_KISS
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.SW_KISS:
					Globals.next_event = Main.Followups.SW_SLAP
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.SLEEP_SLAP:
					Globals.next_event = Main.Followups.SLEEP_KISS
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.SLEEP_KISS:
					Globals.next_event = Main.Followups.SLEEP_SLAP
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_CLUB:
					Globals.next_event = Main.Followups.GRANDMA_SUCCESS
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_HUNTER:
					Globals.next_event = Main.Followups.GRANDMA_SUCCESS
				Main.LocationEvents.RED:
					Globals.next_event = Main.Followups.RED_ABOUT
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.RED_ABOUT:
					Globals.next_event = Main.Followups.RED_AGAIN
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.RED_AGAIN:
					Globals.next_event = Main.Followups.RED_ABOUT
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.RED_LEAVE:
					Globals.give_item(Main.ItemIndices.HAS_GHOST)
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GHOST_EXITS_BOTTLE:
					Globals.next_event = Main.Followups.GHOST_DEATH
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GHOST_DEATH:
					Globals.get_item(Main.ItemIndices.HAS_SEAL_EWALD)
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GHOST_FIGHT:
					Globals.next_event = Main.Followups.DEATH
			event_chosen.emit()


func _on_option_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and valid[1]:
			print("Option 2")
			visible = false
			match current_event:
				Main.LocationEvents.TAVERN:
					Globals.next_event = Main.Followups.FOUND_SACK
				Main.LocationEvents.ALLEY:
					Globals.next_event = Main.Followups.SW_KISS
				Main.LocationEvents.ROSE_BUSH:
					Globals.next_event = Main.Followups.SLEEP_KISS
				Main.LocationEvents.GRANDMA or Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_AGAIN:
					Globals.next_event = Main.Followups.GRANDMA_RED
				Main.LocationEvents.COUNT + Main.FigureEvents.FROG:
					Globals.next_event = Main.Followups.FROG_FIGHT
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.FOUND_SACK:
					Globals.next_event = Main.Followups.FOUND_CLUB
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GOOSE_2:
					Globals.give_item(Main.ItemIndices.HAS_BREADCRUMBS)
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_ABOUT:	
					Globals.next_event = Main.Followups.GRANDMA_AGAIN
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_RED:
					Globals.next_event = Main.Followups.GRANDMA_AGAIN
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_WINE:
					Globals.next_event = Main.Followups.GRANDMA_CLUB
				Main.LocationEvents.RED:
					Globals.next_event = Main.Followups.RED_LEAVE
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.RED_AGAIN:
					Globals.next_event = Main.Followups.RED_LEAVE
				Main.LocationEvents.COUNT + Main.FigureEvents.HUNTSMAN:
					Globals.next_event = Main.Followups.HUNTER_ABOUT
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GHOST_EXITS_BOTTLE:
					Globals.next_event = Main.Followups.GHOST_FIGHT
			event_chosen.emit()


func _on_option_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and valid[2]:
			print("Option 3")
			visible = false
			match current_event:
				Main.LocationEvents.ALLEY:
					pass # end dialogue
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GOOSE_2:
					Globals.set_flag(Main.FlagIndices.FROG_GOOSE)
				Main.LocationEvents.GRANDMA or Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_AGAIN:
					Globals.next_event = Main.Followups.GHOST_EXITS_BOTTLE
				Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_WINE:
					Globals.next_event = Main.Followups.GRANDMA_HUNTER
			event_chosen.emit()


func _on_option_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and valid[3]:
			print("Option 4")
			visible = false
			match current_event:
				Main.LocationEvents.GRANDMA or Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_AGAIN:
					Globals.next_event = Main.Followups.GRANDMA_WINE
			event_chosen.emit()


# when an event is triggered
func trigger(event: int) -> void:
	$"option 1".visible = false
	$"option 2".visible = false
	$"option 3".visible = false
	$"option 4".visible = false
	valid.fill(false)
	current_event = event
	Globals.next_event = Main.Followups.NONE
	match event:
		Main.LocationEvents.NONE:
			return
		Main.LocationEvents.WINE_CELLAR:
			pass
		Main.LocationEvents.TAVERN: # tavern
			$textbox.text = "You arrive at an abandoned tavern. It is a lost place, an old, empty building."
			$"option 1".text = "You leave this place, as quickly as possible."
			$"option 1".visible = true
			valid[0] = true
			if not Globals.flags[Main.FlagIndices.FOUND_CLUB]:
				$"option 2".text = "Search the tavern, maybe something useful is here?"
				$"option 2".visible = true
				valid[1] = true
		Main.LocationEvents.GRANDMA:
			$textbox.text = "A sweet old lady, sitting in a cozy little house, surrounded by a lifetime of experience and collected treasures. She smiles, as she sees you.
'Come in, dear. I am so lonely here, my last visitor left two whole hours ago. Take a cookie, sweetie. Or maybe five.'"
			$"option 1".text = "Ask about her"
			$"option 1".visible = true
			valid[0] = true
			if Globals.get_flag(Main.FlagIndices.MET_RED):
				$"option 2".text = "Ask about Red Riding Hood"
				$"option 2".visible = true
				valid[1] = true
			else:
				$"option 2".text = "???"
				$"option 2".visible = true
			if Globals.get_item(Main.ItemIndices.HAS_GHOST):
				$"option 3".text = "Give her the wine from Red Riding Hood"
				$"option 3".visible = true
				valid[2] = true
			else:
				$"option 3".text = "???"
				$"option 3".visible = true
			if Globals.get_item(Main.ItemIndices.HAS_WINE):
				$"option 4".text = "Give her the wine you found in the cellar"
				$"option 4".visible = true
				valid[3] = true
			else:
				$"option 4".text = "???"
				$"option 4".visible = true
		Main.LocationEvents.ROSE_BUSH:
			Globals.set_flag(Main.FlagIndices.FOUND_SW)
			$textbox.text = "As you walk down the street, you notice something. A hand hangs out of the shrubbery beside the road.
Investigating the hand, you find a whole sleeping woman in the greenery, a woman of staggering beauty.  Quite the sight, but you are a bit concerned, as she doesn't seem to wake up."
			$"option 1".text = "Slap her"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Kiss her"
			$"option 2".visible = true
			valid[1] = true
			$"option 3".text = "Leave"
			$"option 3".visible = true
			valid[2] = true
		Main.LocationEvents.ALLEY:
			Globals.set_flag(Main.FlagIndices.FOUND_SW)
			$textbox.text = "Passing a dark alleyway, you see someone lying on the ground. A girl, very black hair, but unhealthy looking white skin. Beside her, there is an apple on the ground, with a big bite taken out of it. The girl doesn't move and doesn't wake up, so you take the apple."
			$"option 1".text = "Slap her"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Kiss her"
			$"option 2".visible = true
			valid[1] = true
			$"option 3".text = "Leave"
			$"option 3".visible = true
			valid[2] = true
		Main.LocationEvents.DWARVES:
			pass
		Main.LocationEvents.WELL:
			return
		Main.LocationEvents.GOOSE:
			$textbox.text = "A young woman sits on the sidewalk, surrounded by geese. She looks very nice and comforting. She looks up to you
'Oh, hello kind Sir, how can I help you?'"
			$"option 1".text = "Ask about her"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.RED:
			$textbox.text = "'Eeeey... maaaan...'
The Girl in the red hood looks at you, eyes easily as red as her clothing. In her hand she holds a flask, emitting fine white vapor.
'Whazzup...?'"
			$"option 1".text = "About you"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Leave"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT: # should not be called
			print_debug("Location count or figure none was called. This should probably not happen")
			return
		Main.LocationEvents.COUNT + Main.FigureEvents.WOLF:
			pass
		Main.LocationEvents.COUNT + Main.FigureEvents.FROG:
			Globals.set_flag(Main.FlagIndices.MET_FROG)
			if Globals.get_flag(Main.FlagIndices.FROG_WOLF):
				$textbox.text = "As you arrive, the wolf is already here, talking to to the king, sitting on his big paw. You can't here their dialogue, but the frog seems to be nervous. Then, you see the wolfs slowly lifting the frog to his mouth, and gently kissing the frog. A thick cloud of fog materializes around the two, you heare harps. Then the fog lifts. Holding his paws, in front of the wolf you see a prince. Then, before anyone can say anything, the prince opens his eyes, sees the wolf, blushes, and faints. 
The wolf looks to the prince on the floor, then to you. He smiles, shrugs, and walks away.
As you too walk away, you notice something on the ground."
				$"option 1".text = "It's the Seal of Albrecht! The prince must have lost it. You got another seal!"
				$"option 1".visible = true
				valid[0] = true
			elif Globals.get_flag(Main.FlagIndices.FROG_GOOSE):
				$textbox.text = "You got here before her, but not long. Under the quacking of her geese, Gänseliesl approaches the king of the frogs, completly unbothered by the ungodly stench of his fishy skin.
'Ey, you old perv!', she screams, 'You wanna kiss me, fucker?!'
'Gah!', the king quacks, as Gänseliels grabs him, lifts him ab, and kisses him like a method of torture.

With a loud poof, Gänseliesl and the king getting obscured by a cloud of smoke. You can hear harps. As the fog lifts, Gänseliesl is still standing there, her hand tightly grabbing the throat of a slightly green and wet prince.
'So, hat do you say, asshole?' If you didn't know any better, Gänseliesl looks content with herself.
'What do I say?!What was that, you crazy bitch, you trying to kill me?! I could put you to death for this!' 'You weird fuck wanted to kiss me!'
As their screaming get louder, you decide that your job here is done. As you walk away, you notice something on the ground."
				$"option 1".text = "It's the Seal of Albrecht! The prince must have lost it. You got another seal!"
				$"option 1".visible = true
				valid[0] = true
			else:
				$textbox.text = "A menacing sight, the king of the frogs cowers above the street, blocking your path. It smells like fish and rotting plants. His crown is rusted and jagged, as if designed to stab insubordinates, not to distinguish royality. You should keep your distance. This path is blocked for you. Do not try to fight it."
				$"option 1".text = "Go Away"
				$"option 1".visible = true
				valid[0] = true
				$"option 2".text = "Attack"
				$"option 2".visible = true
				valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.RAVEN:
			pass
		Main.LocationEvents.COUNT + Main.FigureEvents.PRINCE:
			pass
		Main.LocationEvents.COUNT + Main.FigureEvents.HUNTSMAN:
			pass
		Main.LocationEvents.COUNT + Main.FigureEvents.SISTER:
			pass
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.NONE:
			print_debug("Figure count was called. This should probably not happen")
			return
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.FOUND_SACK:
			$textbox.text = "You find a shaking sack.
Best leave it, who knows what is inside?"
			$"option 1".text = "Leave it"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Open it"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.FOUND_CLUB:
			$textbox.text = "Inside the sack is a magical club."
			$"option 1".text = "Take it with you"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Put it back"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.FROG_FIGHT:
			$textbox.text = "You approach the frog. Your fear is overwhelming, but there is no other way. With all your strength, all your heart, and all your might, you raise your foot, and squash all of His Majesties majestic 7 inches of body length under your foot. 'Ahh nah nah mah... ', the king says. 'Ah jahst wanna samane ta kiss mah...' Quietly he drags himself away."
			$"option 1".text = "You shall pass"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GOOSE_1:
			$textbox.text = "The geese look up to you.
'Me? I'm just a humble little bird, may I ask your...'
'Ey, who the fuck are you talking to?', the woman screams, and the goose shrinks away.
'Why are ya talking to my bird ya fucker?!' That one was for you. Her voice sounds like some kind of bird.
'Who the fuck is asking who I am, why don't you fuck off and mind your own goddamn business'"
			$"option 1".text = "Ask about her again"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GOOSE_2:
			$textbox.text = "'Grimm, what a stupid old name for an old fucker. I'm Gänseliesl.'
The first goose looks like she wants to say something, but Gänseliesl pushes her away. 'Shut up, fowl. And you, fuck off!'
She throws Breadcrumbs at you until you leave.'"
			$"option 1".text = "Leave"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Take some breadcrumbs with you"
			$"option 2".visible = true
			valid[1] = true
			if Globals.get_flag(Main.FlagIndices.MET_FROG) and not Globals.get_flag(Main.FlagIndices.FROG_WOLF):
				$"option 3".text = "Tell her about the frog king's desire for a kiss"
				$"option 3".visible = true
				valid[2] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GOOSE_KISS:
			$textbox.text = "The geese start to chatter.
'What? A King? I, oh my, I never expected that we would be a fit for royality...'
'Who the fuck asked you', she interrupts the goose, than looks at you with contempt.
'Some highborn asshole thinks he can have Gänseliesl as his fucking little plaything? I'll show him!'
She grabs one of the geese by the neck and runs off.'"
			$"option 1".text = "Follow her"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_ABOUT:
			$textbox.text = "'Oh, what about me? I'm just a silly old lady'
The silly old lady smiles, takes a cookie herself and looks at it, like at a first born child."
			$"option 1".text = "Leave"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Talk some more"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_RED:
			$textbox.text = "'Oh, dear, Little Red sent you' She smiles, but she seems to be a bit sad.
'Red is a good girl, she is just a bit too...' She leaves the sentence unfinished. Quiet for one second. Then she smiles.
'But she is a good girl, believe me. She is caring and sweet, and always thinks of her dear old grandma'"
			$"option 1".text = "Leave"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Talk some more"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GHOST_EXITS_BOTTLE:
			$textbox.text = "You take out Red's bottle of whine, and Grandmas eyes go bright.
'Ah, my sweet child, she always remembers me. Grandma loves a little glass of wine from time to time. Go ahead, open it up!'
You squeeze the Cork, twist the bottle, and with a loud Bang, the bottle explodes, spraying everything with fine glass powder. Grandma cowers behind her chair. Above the table, a towering figure floats.
A  ghost!

The ghost is looking down on you, with hatred burning in his eyes.
'Mortal!', he announces, 'Thank you for freeing me from my prison! As a reward, I shall grant you the choice on how you want to die!'"
			$"option 1".text = "Wish for death"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Attack the ghost"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_WINE:
			$textbox.text = "You pull out the bottle of wine and Grandmas eyes go bright.
'Ah, my sweet child, she always remembers me. Grandma loves a little glass of wine from time to time. Go ahead, open it up'.
You squeeze the Cork, twist the bottle, and pour a bit of the red liquid in Grandmas glass. She takes a sip and smiles."

			if Globals.get_flag(Main.FlagIndices.DEFEATED_WOLF):
				$textbox.text += "\n\n'Oh, thank you dear, that was wonderful' Grandma smiles, and your heart gets warm. She is so sweet.
'Here, my dear, take this. Take this'
She hands you, you almost can't believe it, the Seal of Gervinus!"
				$"option 1".text = "You got another seal!"
				$"option 1".visible = true
				valid[0] = true
			else:
				$textbox.text += "Suddenly, again, glass explodes, this time the window. The Big Bad Wolf jumps into grandmas living room and knocks her over, she goes down with a small scream. 
The Wolf towers over both of you, drivel runs from his jaws. You have to be nuts to fight him."
				$"option 1".text = "Fight!"
				$"option 1".visible = true
				valid[0] = true
				if Globals.get_item(Main.ItemIndices.HAS_CLUB):
					$"option 2".text = "Use the club"
					$"option 2".visible = true
					valid[1] = true
				else:
					$"option 2".text = "???"
					$"option 2".visible = true
				if Globals.get_flag(Main.FlagIndices.FOUND_WOODSMAN):
					$"option 3".text = "Call for help"
					$"option 3".visible = true
					valid[2] = true
				else:
					$"option 3".text = "???"
					$"option 3".visible = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GHOST_DEATH:
			$textbox.text = "You state your preferred way to die. You thought about it a lot, and now is the time.
The Ghost nods, and you die. In about 50 years, in bed, surrounded by your loved ones.
Content with his work, the ghost vanishes. He leaves something on the ground."
			$"option 1".text = "It is the Seal of Ewald! You take it"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_AGAIN:
			$textbox.text = "A sweet old lady, sitting in a cozy little house, surrounded by a lifetime of experience and collected treasures. She smiles, as she sees you.
'Come in, dear. I am so lonely here, my last visitor left two whole hours ago. Take a cookie, sweetie. Or maybe five.'"
			$"option 1".text = "About"
			$"option 1".visible = true
			valid[0] = true
			if Globals.get_flag(Main.FlagIndices.MET_RED):
				$"option 2".text = "About Red Riding Hood"
				$"option 2".visible = true
				valid[1] = true
			else:
				$"option 2".text = "???"
				$"option 2".visible = true
			if Globals.get_item(Main.ItemIndices.HAS_GHOST):
				$"option 3".text = "Give her the wine from Red Riding Hood"
				$"option 3".visible = true
				valid[2] = true
			else:
				$"option 3".text = "???"
				$"option 3".visible = true
			if Globals.get_item(Main.ItemIndices.HAS_WINE):
				$"option 4".text = "Give her the wine you found in the cellar"
				$"option 4".visible = true
				valid[3] = true
			else:
				$"option 4".text = "???"
				$"option 4".visible = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.SW_SLAP:
			$textbox.text = "You slap her. But she doesn't wake up. And now you feel like a dick."
			$"option 1".text = "Kiss her"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Leave"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.SW_KISS:
			$textbox.text = "Better not. That is a privilige of princes and perverts."
			$"option 1".text = "Slap her"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Leave"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.SLEEP_SLAP:
			$textbox.text = "You slap her. But she doesn't wake up. And now you feel like a dick."
			$"option 1".text = "Kiss her"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Leave"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.SLEEP_KISS:
			$textbox.text = "Better not. That is a privilige of princes and perverts."
			$"option 1".text = "Slap her"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Leave"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_SUCCESS:
			$textbox.text = "'Oh, thank you dear, that was wonderful' Grandma smiles, and your heart gets warm. She is so sweet.
'Here, my dear, take this. Take this'
She hands you, you almost can't believe it, the Seal of Gervinus!"
			$"option 1".text = "You got another seal!"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_CLUB:
			$textbox.text = "Club jumps out of his sack and throuws himself onto the wolf. The wolf realizes too late what is about to happen, a gets a bad hit on the nose. He tries to bite into the club, but club whirls around him and deals severe punches.
Under the relentless pressure of wooden brutality, the wolf runs away."
			$"option 1".text = "You help Grandma get up"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GRANDMA_HUNTER:
			$textbox.text = "Your cry for help, not very good for your dignity, even though it surprises everyone here, echoes a bit through the room, then dies down. The wolf seems surprised for a second, but then draws closer.
Suddenly! The second window of the living room explodes, and the wolfs natural enemy, the woodsman, jumps in. He screams and swings his axe, knocks over some of grandmas beloved souveniers. The wolf cringes back, snaps at the woodsman, then jumps out of the broken window, the woodsman behind him. They both vanish in the darkness."
			$"option 1".text = "You help Grandma get up"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.RED_AGAIN:
			$textbox.text = "'Eeeey... maaaan...'
The Girl in the red hood looks at you, eyes easily as red as her clothing. In her hand she holds a flask, emitting fine white vapor.
'Whazzup...?'"
			$"option 1".text = "About you"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "Leave"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.RED_LEAVE:
			$textbox.text = "Suddely alive, she grabs your shulder.
'Ey, ma... ma man... can you do something for me...?'
As you don't seem to say no, she hands you a bottle. You have to grab it quckly, because her fingers open a good cubit in front of your hand.
'Can... can you bring this to my granny? Shees... She's lonely, I think, can you give it to her'"
			$"option 1".text = "You take the bottle"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.RED_ABOUT:
			$textbox.text = "'Heheeee... huh? What about me?', she asks, her eyes drifting between you and the sky. 'Im Red Riding Hood, man. I mean... Whaaaaaaat?'"
			$"option 1".text = "You don't think she has a very good grasp on the situation."
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.HUNTSMAN:
			$textbox.text = "It is a strange sight indeed, and a quite sad one. A woodsman without wood. A man of the forest, trapped in the city. A smiling jester on the outside, what must be a hollow shell on the inside. You feel a strange connection to this man, and want to cheer him up.
'Hello, my friend', the woodsman greets you, 'Why the sad face on such a great day?'"
			$"option 1".text = "Leave"
			$"option 1".visible = true
			valid[0] = true
			$"option 2".text = "About you"
			$"option 2".visible = true
			valid[1] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.HUNTER_ABOUT:
			$textbox.text = "'My friend, what is there to tell about me? I'm a woodsman, a simple craftsman, but with a very high mission'
He comes closer and lowers his voice, as if telling you a secret.
'I'm not just a simple man of felled timber, you have to imagine. I am on the holy quest to slay my arch nemesis, the Big Bad Wolf. Rumor has it, that he is somewhere here in the city. And I will find him, believe me'
He steps away from you, and smiles.
'So for now I must bide you farewell, my friend. But if you meet the wolf, give ma a call. I have a sharp axe, that is waiting for him.'"
			$"option 1".text = "Leave"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.GHOST_FIGHT:
			$textbox.text = "You take a swing at the ghost, but your fist passes right through him. He is a ghost, silly, what did you think"
			$"option 1".text = "The ghost attacks you!"
			$"option 1".visible = true
			valid[0] = true
		Main.LocationEvents.COUNT + Main.FigureEvents.COUNT + Main.Followups.COUNT:
			print_debug("Followups count was called. This should definitely not happen")
	
	
	visible = true
