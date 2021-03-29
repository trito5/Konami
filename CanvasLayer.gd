extends CanvasLayer

func _ready():
	#$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	#$HTTPRequest.request("http://localhost:8080/highscores")
	pass

func _on_request_completed(result, response_code, headers, body):
	pass
	#var json = JSON.parse(body.get_string_from_utf8())
	#print(json.result)

func post_scores(scores):
	print("in post scores")
	# Convert data to json string:
	var requestObject ={
	"name": "arrow test",
	"score": scores
	}
	var query = JSON.print(requestObject)
	# Add 'Content-Type' header:
	var use_ssl = false
	var url = "http://localhost:8080/highscores/add"
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)
