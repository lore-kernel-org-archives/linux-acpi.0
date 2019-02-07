From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
Date: Thu, 7 Feb 2019 12:29:17 -0800
Message-ID: <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
References: <20190207185917.167829-1-egranata@google.com> <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
 <CAPR809vnpuh8nOjU3QMCh6YJUKmtX92+bnHSUKGiAXAp6NwCHQ@mail.gmail.com> <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Enrico Granata <egranata@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Enrico Granata <egranata@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 7, 2019 at 12:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 9:45 PM Enrico Granata <egranata@google.com> wrote=
:
> > On Thu, Feb 7, 2019 at 11:39 AM Andy Shevchenko <andy.shevchenko@gmail.=
com> wrote:
> >> On Thu, Feb 7, 2019 at 9:04 PM Rafael J. Wysocki <rafael@kernel.org> w=
rote:
>
> >> > > This is not currently done for the platform drivers, as platform_g=
et_irq()
> >> > > does not try to parse GpioInt() resources.
> >>
> >> And why is this a problem?
>
> > In ChromeOS, we have a driver (cros_ec_lpc) which can run either on sys=
tems that directly expose the interrupt,
> > or systems where the interrupt goes through a GPIO controller. On the f=
ormer, firmware provides an Interrupt resource
> > and platform_get_irq() finds it. On the latter, firmware provides a Gpi=
oInt resource and platform_get_irq does not
> > find it. We could work around this in the driver by probing both paths,=
 but since other subsystems seem to directly
> > look for GpioInt resources, it seemed to us to make more sense to exten=
d platform_get_irq() instead.
>
> Looking briefly into the driver I found third scenario =E2=80=94 no resou=
rce at all.
> So, you already have a quirk for that. Now it's the question either
> you go for global quirk (trying to find an IRQ via iterating over
> GpioInt() resources like in this patch, but in the driver), or use DMI
> table for more stricter rules.

No, no DMI rules please, they are more pain than anything.

>
> Either way you choose, I don't see a necessity to put this to the
> driver core for now since it would be the only (let's assume properly
> written ACPI tables) driver needs such.

This is simply kicking the can down the road.

>
> > Do you have a suggestion as to how to write ACPI tables to avoid the is=
sue?
>
> 1. Allocate new ID and use it (perhaps not the best path).
> 2. Use GPE(s).
>

Or just solve the issue of intermixing Interrupt() with GpioInt(). We
have similar issue with i2c and spi, but we sidestep that there as we
only parse the first interrupt and do not give option of fetching 2nd,
3rd, etc. Maybe we should only GpioInt parsing for the first interrupt
in platform_get_irq() as well for the first iteration and then see if
we need to improve it if we see devices with multiple interrupts.

Thanks,
Dmitry
