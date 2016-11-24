From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] gpiolib: Forbid irqchip default trigger for ACPI
 enumerated devices
Date: Thu, 24 Nov 2016 14:45:55 +0100
Message-ID: <CAJZ5v0hV2ce-CJYoVhrKEK13m7_Duy3KsKGeUErznAHFZ2KgMA@mail.gmail.com>
References: <20160912112951.76598-1-mika.westerberg@linux.intel.com>
 <3728863.ohrj1SkIMB@vostro.rjw.lan> <20161124075925.GD1476@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34596 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964844AbcKXNp5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2016 08:45:57 -0500
In-Reply-To: <20161124075925.GD1476@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-gpio@vger.kernel.org

On Thu, Nov 24, 2016 at 8:59 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Nov 24, 2016 at 02:33:55AM +0100, Rafael J. Wysocki wrote:
>> On Monday, September 12, 2016 02:29:51 PM Mika Westerberg wrote:
>> > Follow DT and forbid default trigger if the GPIO irqchip device is
>> > enumerated from ACPI. Triggering for these devices will be configured
>> > automatically from ACPI interrupt resources provided by the BIOS.
>> >
>> > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
>> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > ---
>> > This is on top of Marc's patch here:
>> >
>> >   https://lkml.org/lkml/2016/9/7/121
>> >
>> >  drivers/gpio/gpiolib.c | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> > index 5707b5d12b28..0efb67f387ea 100644
>> > --- a/drivers/gpio/gpiolib.c
>> > +++ b/drivers/gpio/gpiolib.c
>> > @@ -1618,13 +1618,18 @@ int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
>> >             of_node = gpiochip->of_node;
>> >  #endif
>> >     /*
>> > -    * Specifying a default trigger is a terrible idea if DT is
>> > +    * Specifying a default trigger is a terrible idea if DT or ACPI is
>> >      * used to configure the interrupts, as you may end-up with
>> >      * conflicting triggers. Tell the user, and reset to NONE.
>> >      */
>> >     if (WARN(of_node && type != IRQ_TYPE_NONE,
>> >              "%s: Ignoring %d default trigger\n", of_node->full_name, type))
>> >             type = IRQ_TYPE_NONE;
>> > +   if (has_acpi_companion(gpiochip->parent) && type != IRQ_TYPE_NONE) {
>> > +           acpi_handle_warn(ACPI_HANDLE(gpiochip->parent),
>> > +                            "Ignoring %d default trigger\n", type);
>> > +           type = IRQ_TYPE_NONE;
>> > +   }
>> >
>> >     gpiochip->irqchip = irqchip;
>> >     gpiochip->irq_handler = handler;
>> >
>>
>> Has this gone anywhere already?
>
> Yes, it should be in the mainline kernel with commit id
> 0a1e005374910180c30247386992565b05109eac.

OK, thanks!
