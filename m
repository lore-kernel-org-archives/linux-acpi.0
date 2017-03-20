From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] gpio: acpi: Call enable_irq_wake for _IAE GpioInts with
 Wake set
Date: Mon, 20 Mar 2017 18:24:37 +0100
Message-ID: <dccdaa5d-24bf-c460-0794-27f3680ecd58@redhat.com>
References: <20170318233524.5047-1-hdegoede@redhat.com>
 <CAJZ5v0i-WbGb=4B-xdQu1=LD2sYDoAm3mEkiLqdHSw8Tw4avrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755735AbdCTRYk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Mar 2017 13:24:40 -0400
In-Reply-To: <CAJZ5v0i-WbGb=4B-xdQu1=LD2sYDoAm3mEkiLqdHSw8Tw4avrA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org

Hi,

On 19-03-17 01:25, Rafael J. Wysocki wrote:
> On Sun, Mar 19, 2017 at 12:35 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On baytrail / cherrytrail systems with a LID switch the LID switch is
>> often connect to a gpioint handled by an _IAE event handler.
>> Before this commit such systems would not wake up when opening the lid,
>> requiring the powerbutton to be pressed after opening the lid to wakeup.
>>
>> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
>> event handler which have their Wake flag set. This fixes such systems
>> not waking up when opening the lid.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Thanks for taking care of this, the changes look OK to me.
>
> Do I guess correctly that this is about wakeups from suspend-to-idle?

Yes.

> If so, it would be good to note in the changelog that this is the case
> and that the interrupts are generated anyway on those lines on lid
> switch changes, but they are treated by the IRQ subsystem as spurious
> while suspended if not marked as wakeup IRQs.

Ack will do.

Regards,

Hans


>
>> ---
>>  drivers/gpio/gpiolib-acpi.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
>> index 8cd3f66..18207b2 100644
>> --- a/drivers/gpio/gpiolib-acpi.c
>> +++ b/drivers/gpio/gpiolib-acpi.c
>> @@ -28,6 +28,7 @@ struct acpi_gpio_event {
>>         acpi_handle handle;
>>         unsigned int pin;
>>         unsigned int irq;
>> +       bool irq_wake_enabled;
>>         struct gpio_desc *desc;
>>  };
>>
>> @@ -266,6 +267,11 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
>>                 goto fail_free_event;
>>         }
>>
>> +       if (agpio->wake_capable == ACPI_WAKE_CAPABLE) {
>> +               enable_irq_wake(irq);
>> +               event->irq_wake_enabled = true;
>> +       }
>> +
>>         list_add_tail(&event->node, &acpi_gpio->events);
>>         return AE_OK;
>>
>> @@ -339,6 +345,9 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
>>         list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
>>                 struct gpio_desc *desc;
>>
>> +               if (event->irq_wake_enabled)
>> +                       disable_irq_wake(event->irq);
>> +
>>                 free_irq(event->irq, event);
>>                 desc = event->desc;
>>                 if (WARN_ON(IS_ERR(desc)))
>> --
>> 2.9.3
>
> Thanks,
> Rafael
>
