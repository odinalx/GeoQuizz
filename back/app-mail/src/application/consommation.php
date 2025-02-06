<?php

namespace appMail\application;


require __DIR__ . '/../../vendor/autoload.php';

use PhpAmqpLib\Connection\AMQPStreamConnection;
use PhpAmqpLib\Message\AMQPMessage;
use Symfony\Component\Mailer\Transport;
use Symfony\Component\Mailer\Mailer;
use appMail\application\MailService;

// Configuration codée en dur pour RabbitMQ (identique au service jeux)
$connection = new AMQPStreamConnection(
    'rabbitmq', 
    5672,       
    'admin',    
    'admin'     
);

$channel = $connection->channel();

$channel->exchange_declare('jeux', 'direct', false, true, false);
$channel->queue_declare('jeux_notifications', false, true, false, false);
$channel->queue_bind('jeux_notifications', 'jeux', 'jeux.cree'); 

$transport = Transport::fromDsn('smtp://mailcatcher:1025');
$mailer = new Mailer($transport);
$mailService = new MailService($mailer);

echo " [*] En attente de messages sur jeux_notifications. Pour quitter: CTRL+C\n";

$callback = function (AMQPMessage $msg) use ($mailService) {
    try {
        $data = json_decode($msg->body, true);
        
        if (!$data || !isset($data['email'])) {
            throw new \Exception('Message JSON invalide ou email manquant');
        }

        echo " [x] Notification jeux reçue\n";
        
        // Envoi du mail
        $mailService->sendEmail(
            $data['email'],
            subject: 'Nouveau jeu GeoGuessr',
            sprintf("Votre jeu du %s avec le Dr %s est confirmé.", 
                $data['creneau'] ?? 'date inconnue',
                $data['praticien'] ?? 'praticien inconnu'
            )
        );
        
        echo " [x] Mail envoyé à {$data['email']}\n";
        
    } catch (\Exception $e) {
        echo " [x] ERREUR: " . $e->getMessage() . "\n";
    } finally {
        $msg->ack();
    }
};

$channel->basic_consume(
    'jeux_notifications', 
    '', 
    false, 
    false, 
    false, 
    false, 
    $callback
);

while ($channel->is_consuming()) {
    $channel->wait();
}

$channel->close();
$connection->close();