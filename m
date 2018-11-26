From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] gpiolib-acpi: Only defer request_irq for GpioInt ACPI
 event handlers
Date: Mon, 26 Nov 2018 14:44:35 +0100
Message-ID: <613f36c6-e990-b4b3-0b04-0b0ca6bfb256@redhat.com>
References: <20181126104231.18322-1-hdegoede@redhat.com>
 <20181126123935.GG2296@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181126123935.GG2296@lahna.fi.intel.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 26-11-18 13:39, Mika Westerberg wrote:
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
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 78d3a92edbfb ("gpiolib-acpi: Register GpioInt ACPI event ...")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/gpio/gpiolib-acpi.c | 136 +++++++++++++++++++-----------------
>>   1 file changed, 73 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
>> index 55b72fbe1631..bda19373835a 100644
>> --- a/drivers/gpio/gpiolib-acpi.c
>> +++ b/drivers/gpio/gpiolib-acpi.c
>> @@ -22,8 +22,12 @@
>>   struct acpi_gpio_event {
>>   	struct list_head node;
>>   	acpi_handle handle;
>> +	irq_handler_t handler;
>>   	unsigned int pin;
>>   	unsigned int irq;
>> +	unsigned long irqflags;
>> +	bool irq_is_wake;
>> +	bool irq_requested;
> 
> It might be a good idea to add kernel-doc now for the struct since it
> seems to be growing and it is not immediately clear what each field mean
> anymore ;-)

Ok, will do for v2.

>>   	struct gpio_desc *desc;
>>   };
>>   
>> @@ -49,10 +53,10 @@ struct acpi_gpio_chip {
>>   
>>   /*
>>    * For gpiochips which call acpi_gpiochip_request_interrupts() before late_init
>> - * (so builtin drivers) we register the ACPI GpioInt event handlers from a
>> + * (so builtin drivers) we register the ACPI GpioInt irq-handlers from a
>>    * late_initcall_sync handler, so that other builtin drivers can register their
>>    * OpRegions before the event handlers can run.  This list contains gpiochips
>> - * for which the acpi_gpiochip_request_interrupts() has been deferred.
>> + * for which the acpi_gpiochip_request_irqs() call has been deferred.
>>    */
>>   static DEFINE_MUTEX(acpi_gpio_deferred_req_irqs_lock);
>>   static LIST_HEAD(acpi_gpio_deferred_req_irqs_list);
>> @@ -133,8 +137,43 @@ bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_gpio_get_irq_resource);
>>   
>> -static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
>> -						   void *context)
>> +static void acpi_gpiochip_request_irq(struct acpi_gpio_chip *acpi_gpio,
>> +				      struct acpi_gpio_event *event)
>> +{
>> +	int ret, value;
>> +
>> +	ret = request_threaded_irq(event->irq, NULL, event->handler,
>> +				   event->irqflags, "ACPI:Event", event);
>> +	if (ret) {
>> +		dev_err(acpi_gpio->chip->parent,
>> +			"Failed to setup interrupt handler for %d\n",
>> +			event->irq);
>> +		return;
>> +	}
>> +
>> +	if (event->irq_is_wake)
>> +		enable_irq_wake(event->irq);
>> +
>> +	event->irq_requested = true;
>> +
>> +	/* Make sure we trigger the initial state of edge-triggered IRQs */
>> +	value = gpiod_get_raw_value_cansleep(event->desc);
>> +	if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
>> +	    ((event->irqflags & IRQF_TRIGGER_FALLING) && value == 0))
>> +		event->handler(event->irq, event);
>> +}
>> +
>> +static void acpi_gpiochip_request_irqs(struct acpi_gpio_chip *acpi_gpio)
>> +{
>> +	struct acpi_gpio_event *event;
>> +
>> +	list_for_each_entry(event, &acpi_gpio->events, node)
>> +		acpi_gpiochip_request_irq(acpi_gpio, event);
>> +}
>> +
>> +static acpi_status
>> +acpi_gpiochip_request_interrupt_desc(struct acpi_resource *ares,
>> +				     void *context)
> 
> I wonder if there could be better name for this now that it does not
> request anything? Maybe acpi_gpiochip_event_alloc() or similar?

Sure I will rename this to acpi_gpiochip_alloc_event (verb then subject
to follow the style of the rest of the file) for v2.

I will prepare a v2 of this patch this evening or tomorrow.

Regards,

Hans
