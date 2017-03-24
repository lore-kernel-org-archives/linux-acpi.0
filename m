From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] gpio: acpi: Call enable_irq_wake for _IAE GpioInts
 with Wake set
Date: Fri, 24 Mar 2017 10:51:53 +0100
Message-ID: <2506dfe4-a01e-f73a-0e11-fc2d99d6b91a@redhat.com>
References: <20170320173221.3397-1-hdegoede@redhat.com>
 <2997741.ylvZKAC5a8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbdCXJwH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Mar 2017 05:52:07 -0400
In-Reply-To: <2997741.ylvZKAC5a8@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org

Hi,

On 20-03-17 22:59, Rafael J. Wysocki wrote:
> On Monday, March 20, 2017 06:32:21 PM Hans de Goede wrote:
>> On Bay Trail / Cherry Trail systems with a LID switch, the LID switch is
>> often connect to a gpioint handled by an _IAE event handler.
>> Before this commit such systems would not wake up when opening the lid,
>> requiring the powerbutton to be pressed after opening the lid to wakeup.
>>
>> Note that Bay Trail / Cherry Trail systems use suspend-to-idle, so
>> the interrupts are generated anyway on those lines on lid switch changes,
>> but they are treated by the IRQ subsystem as spurious while suspended if
>> not marked as wakeup IRQs.
>>
>> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
>> event handler which have their Wake flag set. This fixes such systems
>> not waking up when opening the lid.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> ---
>> Changes in v2:
>> -Improve commit msg
>> -Add Mika's Acked-by
>> ---
>>  drivers/gpio/gpiolib-acpi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
>> index 8cd3f66..18207b2 100644
>> --- a/drivers/gpio/gpiolib-acpi.c
>> +++ b/drivers/gpio/gpiolib-acpi.c
>> @@ -28,6 +28,7 @@ struct acpi_gpio_event {
>>  	acpi_handle handle;
>>  	unsigned int pin;
>>  	unsigned int irq;
>> +	bool irq_wake_enabled;
>>  	struct gpio_desc *desc;
>>  };
>>
>> @@ -266,6 +267,11 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
>>  		goto fail_free_event;
>>  	}
>>
>> +	if (agpio->wake_capable == ACPI_WAKE_CAPABLE) {
>> +		enable_irq_wake(irq);
>> +		event->irq_wake_enabled = true;
>> +	}
>> +
>>  	list_add_tail(&event->node, &acpi_gpio->events);
>>  	return AE_OK;
>>
>> @@ -339,6 +345,9 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
>>  	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
>>  		struct gpio_desc *desc;
>>
>> +		if (event->irq_wake_enabled)
>
> It has just occurred to me that if the event is in the list, the IRQ will be
> enabled to wake up as long as agpio->wake_capable == ACPI_WAKE_CAPABLE, so it
> looks like it should be sufficient to check
>
> 	if (agpio->wake_capable == ACPI_WAKE_CAPABLE)
>
> here and the new flag is not necessary.  Or is it?

We don't have (readily available) access to the acpi_resource_gpio struct
in acpi_gpiochip_free_interrupts, so I'm going to go with Andy's suggestion
instead and change the if to:

                 if (irqd_is_wakeup_set(irq_get_irq_data(event->irq)))
                         disable_irq_wake(event->irq);

Still need to run some quick tests and then I will send v3 with this
change.

Regards,

Hans
