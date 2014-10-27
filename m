From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / GPIO: Driver GPIO mappings for ACPI GPIOs
Date: Mon, 27 Oct 2014 23:34:35 +0100
Message-ID: <3242497.urQmuvpeyA@vostro.rjw.lan>
References: <CAAVeFuLW6fucvDxQvY5DDfnhPrgYM+1pi7WoHfBQa_BgYnc_Cw@mail.gmail.com> <2758495.RYBbleVHkC@vostro.rjw.lan> <CAAVeFuK2sBC2n5TdMwEbhi3gq7DqQm-3h-esQpoQd3U1jDJxpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAVeFuK2sBC2n5TdMwEbhi3gq7DqQm-3h-esQpoQd3U1jDJxpg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, October 27, 2014 02:21:23 PM Alexandre Courbot wrote:
> On Sat, Oct 25, 2014 at 7:05 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Provide a way for device drivers using GPIOs described by ACPI
> > GpioIo resources in _CRS to tell the GPIO subsystem what names
> > (connection IDs) to associate with specific GPIO pins defined
> > in there.
> >
> > To do that, a driver needs to define a mapping table as a
> > NULL-terminated array of struct acpi_gpio_mapping objects
> > that each contain a name, a pointer to an array of pin data
> > (struct acpi_gpio_params) objects and the size of that array.
> >
> > Each struct acpi_gpio_params object consists of three fields,
> > crs_entry_index, pin_index, active_low, representing the index of
> > the target GpioIo()/GpioInt() resource in _CRS starting from zero,
> > the index of the target pin in that resource starting from zero,
> > and the active-low flag for that pin, respectively.
> >
> > Next, the mapping table needs to be passed as the second argument to
> > acpi_dev_add_driver_gpios() that will register it with the ACPI device
> > object pointed to by its first argument.  That object must represent
> > the ACPI namespace node containing the _CRS object referred to by the
> > GPIO mapping.  That should be done in the driver's .probe() routine.
> >
> > On removal, the driver should unregister its GPIO mapping table
> > by calling acpi_dev_remove_driver_gpios() on the ACPI device
> > object where that table was previously registered.
> >
> > Included are fixes from Mika Westerberg.
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> As we discussed already, this is a great idea. The only thing that is
> missing is a paragraph in Documentation/gpio/consumer.txt with an
> explanation of the global mechanism and a simple example to illustrate
> how and when this should be used.

Yes, I'm going to provide documentation.

One question, though.  We're already adding gpio-properties.txt under
Documentation/acpi/ containing analogous information for _DSD-based
mappings.  I thought I'd add a section to that file and a short paragraph
pointing to it into consumer.txt, would that work?

Rafael
