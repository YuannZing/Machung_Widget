<?php
require 'vendor/autoload.php';

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;
use Ratchet\Server\IoServer;
use Ratchet\Http\HttpServer;
use Ratchet\WebSocket\WsServer;

class WebSocketServer implements MessageComponentInterface {
    protected $clients;
    protected $users; // Simpan user_id yang terhubung

    public function __construct() {
        $this->clients = new \SplObjectStorage;
        $this->users = [];
    }

    public function onOpen(ConnectionInterface $conn) {
        $this->clients->attach($conn);
        echo "New connection ({$conn->resourceId})\n";
    }

    public function onMessage(ConnectionInterface $from, $msg) {
        $data = json_decode($msg, true);

        if ($data["type"] === "register") {
            $this->users[$from->resourceId] = $data["user_id"];
            echo "User Registered: {$data["user_id"]} (Connection ID: {$from->resourceId})\n";
        } 
        elseif ($data["type"] === "send_to_user") {
            $targetUserId = $data["user_id"];
            $message = $data["message"];
            $sent = false;

            foreach ($this->clients as $client) {
                $clientId = $client->resourceId;
                if (isset($this->users[$clientId]) && $this->users[$clientId] === $targetUserId) {
                    $client->send(json_encode([
                        "event" => "private_message",
                        "message" => $message,
                        "from" => $this->users[$from->resourceId]
                    ]));
                    $sent = true;
                    break;
                }
            }
            if (!$sent) {
                $from->send(json_encode([
                    "event" => "error",
                    "message" => "User $targetUserId tidak ditemukan atau belum terhubung."
                ]));
            }
        } 
        elseif ($data["type"] === "broadcast") {
            $message = $data["message"];
            foreach ($this->clients as $client) {
                $client->send(json_encode([
                    "event" => "global_message",
                    "message" => $message,
                    "from" => $this->users[$from->resourceId] ?? "Unknown"
                ]));
            }
            echo "Broadcast Message: $message\n";
        }
    }

    public function onClose(ConnectionInterface $conn) {
        if (isset($this->users[$conn->resourceId])) {
            echo "User {$this->users[$conn->resourceId]} (Connection {$conn->resourceId}) has disconnected\n";
            unset($this->users[$conn->resourceId]);
        }
        $this->clients->detach($conn);
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "Error: " . $e->getMessage() . "\n";
        $conn->close();
    }
}

$server = IoServer::factory(
    new HttpServer(
        new WsServer(
            new WebSocketServer()
        )
    ),
    8080
);

echo "WebSocket server running on ws://0.0.0.0:8080\n";
$server->run();
