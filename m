From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpiolib-acpi: Only defer request_irq for GpioInt
 ACPI event handlers
Date: Fri, 7 Dec 2018 11:02:27 +0100
Message-ID: <CACRpkdZL5A5MyLr+pBEq+QFARMXbW4FO3H2_t_VTq8XxszPqKA@mail.gmail.com>
References: <20181128165756.20908-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181128165756.20908-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 28, 2018 at 5:58 PM Hans de Goede <hdegoede@redhat.com> wrote:

> Commit 78d3a92edbfb ("gpiolib-acpi: Register GpioInt ACPI event handlers
> from a late_initcall") deferred the entire acpi_gpiochip_request_interrupt
> call for each event resource.
>
> This means it also delays the gpiochip_request_own_desc(..., "ACPI:Event")
> call. This is a problem if some AML code reads the GPIO pin before we
> run the deferred acpi_gpiochip_request_interrupt, because in that case
> acpi_gpio_adr_space_handler() will already have called
> gpiochip_request_own_desc(..., "ACPI:OpRegion") causing the call from
> acpi_gpiochip_request_interrupt to fail with -EBUSY and we will fail to
> register an event handler.
>
> acpi_gpio_adr_space_handler is prepared for acpi_gpiochip_request_interrupt
> already having claimed the pin, but the other way around does not work.
>
> One example of a problem this causes, is the event handler for the OTG
> ID pin on a Prowise PT301 tablet not registering, keeping the port stuck
> in whatever mode it was in during boot and e.g. only allowing charging
> after a reboot.
>
> This commit fixes this by only deferring the request_irq call and the
> initial run of edge-triggered IRQs instead of deferring all of
> acpi_gpiochip_request_interrupt.
>
> Cc: stable@vger.kernel.org
> Fixes: 78d3a92edbfb ("gpiolib-acpi: Register GpioInt ACPI event ...")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:

Patch applied for fixes with Andy's and Mika's tags.

Yours,
Linus Walleij
