<?php
require __DIR__ . '/../vendor/autoload.php';

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;

try {
    //$connection = new AMQPStreamConnection('rabbitmq', 5672, 'admin', 'admin');
    try {
        $connection = new AMQPStreamConnection('rabbitmq', 5672, 'admin', 'admin');
        echo "Connected.\n";
    } catch (\Exception $e) {
        echo "Error: " . $e->getMessage() . "\n";
    }

    $channel = $connection->channel();
    $queue = 'game_events';

    $channel->queue_declare($queue, false, true, false, false);
    $messageData = json_encode(['eventType' => 'game_started', 'gameData' => ['gameId' => 123]]);
    $msg = new AMQPMessage($messageData, ['delivery_mode' => AMQPMessage::DELIVERY_MODE_PERSISTENT]);

    $channel->basic_publish($msg, '', $queue);
    echo "Event sent successfully!\n";

    $channel->close();
    $connection->close();
} catch (Exception $e) {
    echo "Error connecting to RabbitMQ: " . $e->getMessage() . "\n";
}
