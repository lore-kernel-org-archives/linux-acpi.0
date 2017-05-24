From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Thu, 25 May 2017 01:12:37 +0200
Message-ID: <CAJZ5v0jogwciZcKG0HaK_40AjJF+kf7BEfZbV_U4N1ci327kaw@mail.gmail.com>
References: <20170524104216.23643-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33290 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164538AbdEXXMi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2017 19:12:38 -0400
In-Reply-To: <20170524104216.23643-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Wed, May 24, 2017 at 12:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Some peripherals on Bay Trail and Cherry Trail platforms signal PME to the
> PMC to wakeup the system. When this happens software needs to clear the
> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
>
> This is modeled in ACPI through the INT0002 ACPI Virtual GPIO device.
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

LGTM

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
