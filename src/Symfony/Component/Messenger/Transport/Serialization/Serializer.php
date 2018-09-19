<?php

/*
 * This file is part of the Symfony package.
 *
 * (c) Fabien Potencier <fabien@symfony.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Symfony\Component\Messenger\Transport\Serialization;

use Symfony\Component\Messenger\Envelope;
use Symfony\Component\Messenger\Exception\InvalidArgumentException;
use Symfony\Component\Messenger\Exception\RuntimeException;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Encoder\XmlEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer as SymfonySerializer;
use Symfony\Component\Serializer\SerializerInterface as SymfonySerializerInterface;

/**
 * @author Samuel Roze <samuel.roze@gmail.com>
 */
class Serializer implements SerializerInterface
{
    private $serializer;
    private $format;
    private $context;

    public function __construct(SymfonySerializerInterface $serializer, string $format = 'json', array $context = array())
    {
        $this->serializer = $serializer;
        $this->format = $format;
        $this->context = $context;
    }

    public static function create(): self
    {
        if (!class_exists(SymfonySerializer::class)) {
            throw new RuntimeException(sprintf('The default Messenger Serializer requires Symfony\'s Serializer component. Try running "composer require symfony/serializer".'));
        }

        $encoders = array(new XmlEncoder(), new JsonEncoder());
        $normalizers = array(new ObjectNormalizer());
        $serializer = new SymfonySerializer($normalizers, $encoders);

        return new self($serializer);
    }

    /**
     * {@inheritdoc}
     */
    public function decode(array $encodedEnvelope): Envelope
    {
        if (empty($encodedEnvelope['body']) || empty($encodedEnvelope['headers'])) {
            throw new InvalidArgumentException('Encoded envelope should have at least a "body" and some "headers".');
        }

        if (empty($encodedEnvelope['headers']['type'])) {
            throw new InvalidArgumentException('Encoded envelope does not have a "type" header.');
        }

        $envelopeItems = $this->decodeEnvelopeItems($encodedEnvelope);

        $context = $this->context;
        /** @var SerializerConfiguration|null $serializerConfig */
        if ($serializerConfig = $envelopeItems[SerializerConfiguration::class] ?? null) {
            $context = $serializerConfig->getContext() + $context;
        }

        $message = $this->serializer->deserialize($encodedEnvelope['body'], $encodedEnvelope['headers']['type'], $this->format, $context);

        return new Envelope($message, $envelopeItems);
    }

    /**
     * {@inheritdoc}
     */
    public function encode(Envelope $envelope): array
    {
        $context = $this->context;
        /** @var SerializerConfiguration|null $serializerConfig */
        if ($serializerConfig = $envelope->get(SerializerConfiguration::class)) {
            $context = $serializerConfig->getContext() + $context;
        }

        $headers = array('type' => \get_class($envelope->getMessage())) + $this->encodeEnvelopeItems($envelope);

        return array(
            'body' => $this->serializer->serialize($envelope->getMessage(), $this->format, $context),
            'headers' => $headers,
        );
    }

    private function decodeEnvelopeItems($encodedEnvelope)
    {
        $items = array();
        foreach ($encodedEnvelope['headers'] as $name => $value) {
            if (0 !== strpos($name, $prefix = 'X-Message-Envelope-')) {
                continue;
            }

            $items[] = $this->serializer->deserialize($value, substr($name, \strlen($prefix)), $this->format, $this->context);
        }

        return $items;
    }

    private function encodeEnvelopeItems(Envelope $envelope)
    {
        if (!$configurations = $envelope->all()) {
            return array();
        }

        $headers = array();
        foreach ($configurations as $configuration) {
            $headers['X-Message-Envelope-'.\get_class($configuration)] = $this->serializer->serialize($configuration, $this->format, $this->context);
        }

        return $headers;
    }
}
