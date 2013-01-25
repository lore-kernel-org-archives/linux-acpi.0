From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH] gpiolib-acpi: Add ACPI5 event model support to gpio.
Date: Fri, 25 Jan 2013 16:05:54 +0200
Message-ID: <51029142.9050901@linux.intel.com>
References: <1359114505-4473-1-git-send-email-mathias.nyman@linux.intel.com> <CACRpkdZvoacYP0rwnrcyHfKWrN67HvN5jCVom4Lx6Qd9RC0fjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39588 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754935Ab3AYOBW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 09:01:22 -0500
In-Reply-To: <CACRpkdZvoacYP0rwnrcyHfKWrN67HvN5jCVom4Lx6Qd9RC0fjg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, grant.likely@secretlab.ca, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, tianyu.lan@intel.com, linux-kernel@vger.kernel.org

On 01/25/2013 02:54 PM, Linus Walleij wrote:
> On Fri, Jan 25, 2013 at 12:48 PM, Mathias Nyman
> <mathias.nyman@linux.intel.com>  wrote:
>
>> Add ability to handle ACPI events signalled by GPIO interrupts.
>>
>> ACPI5 platforms can use GPIO signaled ACPI events. These GPIO interrupts are
>> handled by ACPI event methods which need to be called from the GPIO
>> controller's interrupt handler. acpi_gpio_request_interrupt() finds out which
>> gpio pins have acpi event methods and assigns interrupt handlers that calls
>> the acpi event methods for those pins.
>>
>> Partially based on work by Rui Zhang<rui.zhang@intel.com>
>>
>> Signed-off-by: Mathias Nyman<mathias.nyman@linux.intel.com>
> (...)
>> +/**
>> + * acpi_gpio_request_interrupt() - Register isr for gpio controller ACPI events
>> + * @chip:      gpio chip representation of the gpio controller
>
>
> Hm chip, controller, controller, chip chip, controller controller...
> Are we using two different names for the same thing?

They get mixed up a bit here yes.
I'll change them all to chip.

>
>> + *
>> + * ACPI5 platforms can use GPIO signaled ACPI events. These GPIO interrupts are
>> + * handled by ACPI event methods which need to be called from the GPIO
>> + * controller's interrupt handler. acpi_gpio_request_interrupt finds out which
>> + * gpio pins have acpi event methods and assigns interrupt handlers that calls
>> + * the acpi event methods for those pins.
>> + */
>> +
>> +void acpi_gpio_request_interrupt(struct gpio_chip *chip)
>
> So I was like "um, what acpi requests an interrupt for a GPIO (maybe a pin)...
>
> ... read read ...
>
> Aha the function should probably be named:
> acpi_gpiochip_request_interrupts()
>

True, will rename it.

> Because it just grabs all IRQs coming from that chip right?

Not all, only the ones that have an ACPI handler method defined. 
Basically ACPI5 supports using some of the gpio interrupts for the same 
purpose as SCI interrupts.

>
> Second: why is there no mirror function *releasing* all the IRQs again?
> One-way interface?

My thinking was that using devm_request_threaded_irq(chip->dev, ...) 
will automatically free the interrupts on driver detach, making the 
release function unnecessary.

-Mathias

