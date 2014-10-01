From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/15] leds: leds-gpio: Add ACPI probing support
Date: Wed, 01 Oct 2014 15:52:42 +0200
Message-ID: <2043842.LxdgdYRbIF@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <5364565.aEcZqpzdLW@wuerfel> <20141001115901.GD1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141001115901.GD1786@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 01 October 2014 14:59:01 Mika Westerberg wrote:
> On Wed, Oct 01, 2014 at 12:01:34PM +0200, Arnd Bergmann wrote:
> > On Wednesday 01 October 2014 12:13:09 Mika Westerberg wrote:
> > > 
> > > > Regarding the MODULE_DEVICE_TABLE, I suspect the above won't work the
> > > > way you are hoping for, because once you get to dozens or hundreds of
> > > > drivers doing this, each device will show up with the same string,
> > > > so udev will try to load all the modules that list "PRP0001". That
> > > > doesn't look right. With the code from patch 3, you can probably drop
> > > > the acpi MODULE_DEVICE_TABLE() entirely and get the correct behavior.
> > > 
> > > It actually works like this now:
> > > 
> > >  # cd /sys/bus/platform/devices/PRP0001\:00/
> > >  DRIVER=leds-gpio
> > >  MODALIAS=of:Nprp0001TacpiCgpio-leds
> > > 
> > >  # cat modalias 
> > >  of:Nprp0001TacpiCgpio-leds
> > > 
> > > In other words the modalias changes to be of:Nprp0001Tacpi, e.g
> > > name=prp0001, type=acpi and then list of compatible values.
> > > 
> > > Udev then loads only module that matches the modalias so it should not
> > > load everything listing PRP0001 in their MODULE_DEVICE_TABLE().
> > 
> > I'm not completely following yet. I can see how this works now, but
> > how is this better than just using the existing modalias for OF?
> 
> You mean using just what of_device_get_modalias() would create? In that
> case, what do we put to name and type fields?

Sorry, I think we're still both misunderstanding one another. You were
talking about the modalias created by the device scanning above, while
I meant the one in the MODULE_DEVICE_TABLE. 

With the entry you create in create_modalias(), you will only ever
match against the MODULE_DEVICE_TABLE(of, of_gpio_leds_match)
line, not against the MODULE_DEVICE_TABLE(acpi, acpi_gpio_leds_match),
so I think you can just drop the latter.

On the question what to put into the name and type fields, that is
unrelated. The type is supposed to be for the 'device_type' property
in DT, which we should never rely on in a driver that supports both
APCI and DT. In Linux we only use that for "pci", "cpu" and "memory",
all of which have their own way of getting probed in ACPI.
The "name" is normally ignored in DT as well, except for backwards
compatibility with old bindings, but I would argue that you should not
just put "prp0001" in there. Either leave it empty like type, or use
the name of the device as it appears in the ACPI tables, such as "DEV0"
or "PWM".

	Arnd
