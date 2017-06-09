From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6] platform/x86: Add driver for ACPI INT0002 Virtual GPIO device
Date: Fri, 9 Jun 2017 11:02:37 +0200
Message-ID: <CACRpkdYmu34BLvSGR840+psUVwgqe1v+mBzPyKQj25R7HTQnpw@mail.gmail.com>
References: <20170602151507.22391-1-hdegoede@redhat.com> <20170602151507.22391-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34030 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdFIJCj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2017 05:02:39 -0400
Received: by mail-io0-f175.google.com with SMTP id i7so30519071ioe.1
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jun 2017 02:02:39 -0700 (PDT)
In-Reply-To: <20170602151507.22391-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Fri, Jun 2, 2017 at 5:15 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> Some peripherals on Bay Trail and Cherry Trail platforms signal a
> Power Management Event (PME) to the Power Management Controller (PMC)
> to wakeup the system. When this happens software needs to explicitly
> clear the PME bus 0 status bit in the GPE0a_STS register to avoid an
> IRQ storm on IRQ 9.
>
> This is modelled in ACPI through the INT0002 ACPI device, which is
> called a "Virtual GPIO controller" in ACPI because it defines the
> event handler to call when the PME triggers through _AEI and _L02
> methods as would be done for a real GPIO interrupt in ACPI.
>
> This commit adds a driver which registers the Virtual GPIOs expected
> by the DSDT on these devices, letting gpiolib-acpi claim the
> virtual GPIO and install a GPIO-interrupt handler which call the _L02
> handler as it would for a real GPIO controller.
>
> Cc: joeyli <jlee@suse.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> Changes in v2:
> -Remove dev_err after malloc failure
> -Remove unused empty runtime pm callbacks
> -s/GPE0A_PME_/GPE0A_PME_B0_/
> -Fixed some checkpatch warnings (I forgot to run checkpatch on v1)
> Changes in v3:
> -Rewrite as gpiochip driver letting gpiolib-acpi deal with claiming the pin
>  0x0002 and calling the _L02 event handler when the virtual gpio-irq triggers
> -Rebase on 4.12-rc1
> Changes in v4:
> -Drop device_init_wakeup() from _probe(), use pm_system_wakeup() instead
>  of pm_wakeup_hard_event(chip->parent)
> -Improve commit message
> Changes in v5:
> -Use BIT() macro for FOO_BIT defines
> -Drop unneeded ACPI_PTR macro usage
> Changes in v6:
> -Move back to drivers/platform/x86
> -Expand certain acronyms (PME, PMC)
> -Use linux/gpio/driver.h include instead of linux/gpio.h
> -Document why the get / set / direction_output functions are dummys
> -No functional changes

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

With Andy's changes.

Please feel free to push this upstream through the platform tree
or similar.

Yours,
Linus Walleij
