From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
Date: Thu, 7 Feb 2019 21:45:46 +0200
Message-ID: <CAHp75Ve7+S0rUTLQWn_K2p7yajA3q=BZS0R4nOPdZeMczvNb4A@mail.gmail.com>
References: <20190207185917.167829-1-egranata@google.com> <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: egranata@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Dmitry Torokhov <dtor@chromium.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Enrico Granata <egranata@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 7, 2019 at 9:39 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Feb 7, 2019 at 9:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

> > > This commit adds that functionality.
>
> How that can override the configuration / BIOS flavour when driver
> needs to register an interrupt out of GpioIo() resource?

One more missed example,

Two variants of the IRQ resources in the table for the _same_ device
but on different platforms.

--Variant1--
Device(XYZ)
_CRS1() {
 Interrupt()
 GpioInt()
 Interrupt()
}

--Variant2--
Device(XYZ)
_CRS2() {
 GpioInt()
 Interrupt()
 Interrupt()
}

How to always get second resource?

-- 
With Best Regards,
Andy Shevchenko
