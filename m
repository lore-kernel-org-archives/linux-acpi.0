From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
Date: Thu, 7 Feb 2019 21:39:25 +0200
Message-ID: <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
References: <20190207185917.167829-1-egranata@google.com> <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: egranata@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Dmitry Torokhov <dtor@chromium.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Enrico Granata <egranata@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 7, 2019 at 9:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> +Mika Westerberg
> +Andy Shevchenko
> +Hans de Goede

Thanks, Rafael.
My comments below.

> On Thu, Feb 7, 2019 at 7:59 PM <egranata@google.com> wrote:
> >
> > From: Enrico Granata <egranata@chromium.org>
> >
> > ACPI 5 added support for GpioInt resources as a way to provide
> > information about interrupts mediated via a GPIO controller.
> >
> > Several device buses (e.g. SPI, I2C) have support for retrieving
> > an IRQ specified via this type of resource, and providing it
> > directly to the driver as an IRQ number.

> > This is not currently done for the platform drivers, as platform_get_irq()
> > does not try to parse GpioInt() resources.

And why is this a problem?

> > This commit adds that functionality.

How that can override the configuration / BIOS flavour when driver
needs to register an interrupt out of GpioIo() resource?

P.S. Have you looked at drivers/platform/x86/i2c-multi-instantiate.c
and intel_cht_int33fe.c?
They are the only drivers which needs something like this for now and
I would rather say it's a bad BIOS decision to write a table like
that.

-- 
With Best Regards,
Andy Shevchenko
