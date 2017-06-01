From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Thu, 1 Jun 2017 17:11:02 +0200
Message-ID: <CACRpkdan9Ayd6qGioQc2N+x9S2WxfXs2WGg4imAApLRxOwrfmQ@mail.gmail.com>
References: <20170524104216.23643-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35122 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdFAPLE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2017 11:11:04 -0400
Received: by mail-it0-f45.google.com with SMTP id f72so40993551ite.0
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jun 2017 08:11:04 -0700 (PDT)
In-Reply-To: <20170524104216.23643-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Wed, May 24, 2017 at 12:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> Some peripherals on Bay Trail and Cherry Trail platforms signal PME to the
> PMC to wakeup the system. When this happens software needs to clear the
> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.

Spell out these acronyms so I have at least a faint chance of understanding
what is going on here.

> This is modeled in ACPI through the INT0002 ACPI Virtual GPIO device.

So are you saying that some firmware dork has modeled something that
*is* *actually* a port to a PMC (I guess power management controller) to
send a PME (I guess power managment enable signal?) by shoehorning that
into something purporting to be a GPIO (general purpose input/output)
controller?

Well I've been approached before by people all over that just wanna stick
something quick and dirty into the GPIO subsystem because it's so
convenient. ("Come on, just take it", etc.)

I usually just say no. General purpose I/O is not special-purpose I/O.
I bet a million to one these are just a few bits in a register, right?
And someone chose to model that as a "GPIO"?

This takes the price.

Now we have not just lazy kernel programmers but lazy ACPI firmware
authors having to have their sloppy stuff cleaned up by Hans in kernelspace.

And I bet the resource resolution for this thing is completely dependent on
dirvers/gpio/gpiolib-acpi.c so it must be a using GPIO for that reason?

I guess that just force me to not NACK this because I don't want to screw
up all the worlds Intel cherryviews etc.

:(

> +static const struct acpi_device_id int0002_acpi_ids[] = {
> +       { "INT0002", 0 },
> +       { },

So again, the reason this - which is not a GPIO controller at all -
should anyways
be in drivers/gpio/ is that some firmware person think it's convenient?

Shouldn't this rather be in drivers/platform/x86?

You can still use the gpio driver abstraction.

I have some small comments on the code as well, will send in a separate
mail, otherwise good work as always Hans.

Yours,
Linus Walleij
