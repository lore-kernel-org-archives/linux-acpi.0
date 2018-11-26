From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] gpiolib-acpi: Only defer request_irq for GpioInt ACPI
 event handlers
Date: Mon, 26 Nov 2018 14:46:29 +0100
Message-ID: <7c97b88a-4999-217a-d961-c481582af684@redhat.com>
References: <20181126104231.18322-1-hdegoede@redhat.com>
 <20181126125355.GE10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181126125355.GE10650@smile.fi.intel.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 26-11-18 13:53, Andy Shevchenko wrote:
> On Mon, Nov 26, 2018 at 11:42:31AM +0100, Hans de Goede wrote:
>> Commit 78d3a92edbfb ("gpiolib-acpi: Register GpioInt ACPI event handlers
>> from a late_initcall") deferred the entire acpi_gpiochip_request_interrupt
>> call for each event resource.
>>
>> This means it also delays the gpiochip_request_own_desc(..., "ACPI:Event")
>> call. This is a problem if some AML code reads the GPIO pin before we
>> run the deferred acpi_gpiochip_request_interrupt, because in that case
>> acpi_gpio_adr_space_handler() will already have called
>> gpiochip_request_own_desc(..., "ACPI:OpRegion") causing the call from
>> acpi_gpiochip_request_interrupt to fail with -EBUSY and we will fail to
>> register an event handler.
>>
>> acpi_gpio_adr_space_handler is prepared for acpi_gpiochip_request_interrupt
>> already having claimed the pin, but the other way around does not work.
>>
>> One example of a problem this causes, is the event handler for the OTG
>> ID pin on a Prowise PT301 tablet not registering, keeping the port stuck
>> in whatever mode it was in during boot and e.g. only allowing charging
>> after a reboot.
>>
>> This commit fixes this by only deferring the request_irq call and the
>> initial run of edge-triggered IRQs instead of deferring all of
>> acpi_gpiochip_request_interrupt.
> 
> Thanks for a patch with such nice description.
> I have couple of nitpicks and one question below.
> 
> 
>>    * For gpiochips which call acpi_gpiochip_request_interrupts() before late_init
>> - * (so builtin drivers) we register the ACPI GpioInt event handlers from a
>> + * (so builtin drivers) we register the ACPI GpioInt irq-handlers from a
> 
> I would rather spell "IRQ handlers"

Ok.

>>    * late_initcall_sync handler, so that other builtin drivers can register their
>>    * OpRegions before the event handlers can run.  This list contains gpiochips
>> - * for which the acpi_gpiochip_request_interrupts() has been deferred.
>> + * for which the acpi_gpiochip_request_irqs() call has been deferred.
> 
>>   	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
>>   
>> -	if (defer)
>> -		return;
>> -
>> -	acpi_walk_resources(handle, "_AEI",
>> -			    acpi_gpiochip_request_interrupt, acpi_gpio);
>> +	if (!defer)
>> +		acpi_gpiochip_request_irqs(acpi_gpio);
> 
> Can we leave above condition and put here just

Ok.

> 	acpi_gpiochip_request_irqs(acpi_gpio);
> 
> ?
> 
>>   	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
>>   		struct gpio_desc *desc;
>>   
>> +		if (event->irq_requested) {
>> +			if (event->irq_is_wake)
>> +				disable_irq_wake(event->irq);
>> +
>> +			free_irq(event->irq, event);
>> +		}
>>   
> 
> 
>>   		desc = event->desc;
>>   		if (WARN_ON(IS_ERR(desc)))
> 
> I don't remember if I asked already about possible memory leak here.
> Am I reading code right?
> 
>>   			continue;
> 
> Reading more code, I'm even not sure if this condition could ever happen.

You're right an event with an IS_ERR(desc) is never added to the list
of events, so this condition can never happen. I will add a follow up
patch to v2 removing this unnecessary check.

I will prepare a v2 of this patch this evening or tomorrow.

Regards,

Hans
