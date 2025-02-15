extends Node


var selected_piece: Piece
var target_piece: Piece
var tilemap_positions: Array = []
var occupied_positions: Array = []
var pieces_on_board: Array = []
var board: TileMap = null
var game_end: bool = false
var king_check: bool = false
var pieces_on_board_dict: Dictionary = {}

#TODO
#implementar tooltip

#implementar check del rey (el rey esta en check si esta al alcance de una pieza tanto en mov como en pos of)
#implementar enroque (castling)


#TODO conclusion, quedo bien lo de los efectos pero tengo que reescribir como funciona las passive skills
#para que implemente el mismo sistema que la active skill. Fue un error no armar una clase padre skill
#para que luego salgan las subclases passive skill y active skill pero bueno ahi veo que onda

#utilizar un area 2d en la pieza que debe detectar piezas a su lado es mucho mas facil

#esto podria haberme solucionado la vida para lo que seria el movimiento de piezas

#para facilitar como armar la habilidad pasiva del peon tener como opcion
#crear un efecto que accione efectos, o sea activar un efecto que su efecto
#sea agregar un efecto menor a piezas que se encuentren alrededor de la pieza que
#activo el efecto de area. De esta forma puedo crear otros efectos mas complejos
#como por ejemplo una habilidad en cadena que tome una pieza aleatoria que este cerca
#de la pieza que acciona el efecto

#TODO el dia que haga esto en serio es vital que cree un diccionario enorme o json con todo
#el texto que se muestra dentro edl juego asi puedo facilmente agregar
#distintos idiomas facilmente no solo por la facilidad de acceder a los idiomas
#sino porque puedo traducirlo rapido y sin mucho esfuerzo usando ia y asi agregar muchos
#idiomas aunque claro probablemente tenga errores a menos que conoza el idioma al nivel que
#entiendo ingles o español

#tengo que terminar de pensar como voy a trabajar lo de los states

#ultimo detalle: en lugar de agregfar el pasivo al array de piece, tengo que agregar el efecto
#cuando tengo agregado el efecto uso el metodo global del effect manager para instanciar el efecto
#agregado a la pieza y luego ya depende de como se maneje el efecto y la pasiva seria el resto
#la pasiva/habilidad lo unico que hacen es determinar de que manera agregan la "etiqueta" del efecto
#luego, con el effect manager se instancia ese efecto a partir de la etiqueta en la pieza y finalmente dependiendo
#de como funcione el efecto, va accionarse de una u otra forma.

#agregado para finalizar idea: usar un manager de efectos en donde tengo un diccionario 
#con el nombre del efecto como key y la ruta para crear una instancia del efecto
#como valor de esa forma al leer el nombre del efecto solo lo matcheo con el diccionario del manager
#y cuando es agregado al nodo efectos del jugador, se puede activar segun la conficion del efecto

#nuevo planteamiento -> tanto las habilidades activas como pasivas desencadenan efectos
#los efectos van a ser nodos que se agregan a un nodo contenedor de efectos llamado efectos
#cada efecto va a tener su state machine con sus metodos y atributos
#cada pieza deberia tener un metodo que recorra los efectos que tiene cargados y en base a eso accionarlo
#cuando muestre la barra de efectos y habilidades pasivas activas,
#primero se muestran en una row las habilidades pasivas y en una row debajo los efectos activos en la pieza
#si se hoverea la habilidad pasiva, en la descripcion va a estar subrayado o enfatizado el efecto
#y cuando se hoveree el efecto va a mostrar en rojo o verde (dependiendo si es algo bueno o malo),
#de donde proviene ese efecto, si es de una habilidad activa que afecto a la pieza o si viene de una habilidad
#pasiva de la misma pieza u otra que la afecto esto va a estar conn un asterisco debajo de la descripcion
#de la habilidad pasiva

#cada pieza debe tener un array llamado states
#al inicio de cada turno cada pieza debe correr un metodo que revise que states
#se encuentran actualmente en el array states y dependiendo de eso
#se activa el efecto del state mientras exista en el array states de la pieza
#y de esa manera manejo los estados que afectan a cada pieza
#esto sirve para ahorrar codigo ya que muchos estados pueden repetirse
#en distintas skills ya sean pasivas o activas
#cuando se implemente el metodo que aplique los estados tambien debe llamar al metodo que 
#actualiza los labels asi se refleja automaticamente en las estadisticas de la pieza

#agregar un pequeño icono que identifique que clase de pieza es cada una, una para peon, rey, reina etc
#asi es facil identificar la clase de cada pieza. quizas esto puede estar en un tooltip con el nombre de la pieza
# cuando se hoverea o hace clic derecho, puede mostrar los estados que afectan a la pieza, los stats, la habilidad
#pasiva y la habilidad activa

# limpiar el codigo y comentar mas

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func esperar(segundos: float) -> void:
	await get_tree().create_timer(segundos).timeout

func check_game_end(team):
	TurnManager.turn = "termino el juego"
	if team == "red":
		print("Gana el equipo azul")
	
	else:
		print("Gana el equipo rojo")

func exit() -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()

#mantengo diccionario actualizado con piezas y su ubicacion en el board
func update_pieces_dict() -> void:
	
	for key in pieces_on_board_dict.keys():
		if not is_instance_valid(key):
			pieces_on_board_dict.erase(key)  # Remove freed object
	
	for piece in pieces_on_board:
		if piece not in pieces_on_board_dict.keys():
			pieces_on_board_dict[piece] = Vector2(board.local_to_map(piece.position))
	
		elif Vector2(board.local_to_map(piece.position)) != pieces_on_board_dict[piece]:
			pieces_on_board_dict[piece] = Vector2(board.local_to_map(piece.position))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_pieces_dict()
			
	
	exit()
	
