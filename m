From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: GPIO bindings guidelines (Was: Re: [PATCH v5 10/12] gpio: Support for unified device properties interface)
Date: Thu, 23 Oct 2014 14:08:50 +0200
Message-ID: <2608520.83ytdyNNIq@wuerfel>
References: <CAAVeFuLW6fucvDxQvY5DDfnhPrgYM+1pi7WoHfBQa_BgYnc_Cw@mail.gmail.com> <1971792.8pKYWlGxB9@vostro.rjw.lan> <CAAVeFuJBu-2_z-wCyHF=oVqZUkbNscHk_YGuRLyMkKhhccaPUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAVeFuJBu-2_z-wCyHF=oVqZUkbNscHk_YGuRLyMkKhhccaPUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday 23 October 2014 15:10:55 Alexandre Courbot wrote:
> >
> > Then, the driver needs to do something like:
> >
> >         if (!device_property_present(dev, "known_property_that_should_be_present")
> >             && ACPI_COMPANION(dev))
> >                 acpi_probe_gpios(dev);
> >
> > and in the acpi_probe_gpios() routine there may be checks like:
> >
> >         if (device_has_id(dev, "MARY0001")) {
> >                 The first pin in the first GpioIo resource in _CRS is "fred" and
> >                 it is active-low.
> >                 The third pin in the second GpioIo resource in _CRS is "steve"
> >                 and it is not active-low.
> >         } else if (device_has_id(dev, "JANE0002")) {
> >                 The first pin in the second GpioIo resource in _CRS is "fred" and
> >                 it is not active-low.
> >                 The second pin in the first GpioIo resource in _CRS is "steve"
> >                 and it is active-low.
> >         }
> >
> > and so on.  Of course, there may be drivers knowing that the meaning of the
> > GpioIo resources in _CRS is the same for all devices handled by them, in which
> > case they will not need to check device IDs, but the core has now way of
> > knowing that.  Only the drivers have that information and the core has now
> > way to figure out what to do for a given specific device.
> >
> > So here's a radical idea: Why don't we introduce something like
> >
> >         acpi_enumerate_gpio(dev, name, GpioIo_index, pin_index, active_low)
> >
> > such that after calling, say, acpi_enumerate_gpio(dev, "fred", 0, 0, true) the
> > driver can do something like:
> >
> >         desc = get_gpiod_by_name(dev, "fred");
> >
> > and it'll all work.  Then, the only part of the driver that really needs to be
> > ACPI-specific will be the acpi_probe_gpios() function calling acpi_enumerate_gpio()
> > in accordance with what the device ID is.
> 
> I like this idea. It doesn't complicate the GPIO interface (i.e. no
> "if you are on ACPI and no _DSD is present then gpiod_get() will
> behave that way...") and does the plumbing behind the scenes.
> 
> I will also allow us to finally push the use of names instead of
> indexes in the GPIO API. I'm all for it.

Yes, sounds good.

	Arnd
