From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to
 platform_get_irq()
Date: Mon, 11 Feb 2019 12:30:24 +0200
Message-ID: <20190211103024.GY7875@lahna.fi.intel.com>
References: <20190207185917.167829-1-egranata@google.com>
 <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
 <CAPR809vnpuh8nOjU3QMCh6YJUKmtX92+bnHSUKGiAXAp6NwCHQ@mail.gmail.com>
 <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
 <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Enrico Granata <egranata@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Enrico Granata <egranata@chromium.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Thu, Feb 07, 2019 at 12:29:17PM -0800, Dmitry Torokhov wrote:
> >
> > > Do you have a suggestion as to how to write ACPI tables to avoid the issue?
> >
> > 1. Allocate new ID and use it (perhaps not the best path).
> > 2. Use GPE(s).
> >
> 
> Or just solve the issue of intermixing Interrupt() with GpioInt(). We
> have similar issue with i2c and spi, but we sidestep that there as we
> only parse the first interrupt and do not give option of fetching 2nd,
> 3rd, etc. Maybe we should only GpioInt parsing for the first interrupt
> in platform_get_irq() as well for the first iteration and then see if
> we need to improve it if we see devices with multiple interrupts.

I think it should be fine to intermix them or do what you suggest and
start supporting index 0 for now and then maybe extend it in the future
to cover more.
