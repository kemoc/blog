<?php

/*
 * This file is part of the Symfony package.
 *
 * (c) Fabien Potencier <fabien@symfony.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Symfony\Component\Messenger\Handler\Locator;

use Psr\Container\ContainerInterface;

/**
 * @author Miha Vrhovnik <miha.vrhovnik@gmail.com>
 * @author Samuel Roze <samuel.roze@gmail.com>
 */
class ContainerHandlerLocator extends AbstractHandlerLocator
{
    private $container;

    public function __construct(ContainerInterface $container)
    {
        $this->container = $container;
    }

    protected function getHandler(string $class)
    {
        $handlerKey = 'handler.'.$class;

        return $this->container->has($handlerKey) ? $this->container->get($handlerKey) : null;
    }
}
