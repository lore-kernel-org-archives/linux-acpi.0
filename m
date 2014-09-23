From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC PATCH v2 07/16] gpio: Add support for unified device properties interface
Date: Tue, 23 Sep 2014 22:31:27 +0200
Message-ID: <2531965.8yTKWbxWX4@vostro.rjw.lan>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <20140923155202.GT1786@lahna.fi.intel.com> <20140923161724.GA40700@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140923161724.GA40700-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, September 23, 2014 09:17:24 AM Dmitry Torokhov wrote:
> On Tue, Sep 23, 2014 at 06:52:02PM +0300, Mika Westerberg wrote:
> > On Tue, Sep 23, 2014 at 05:45:57PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 23 September 2014 17:25:50 Linus Walleij wrote:
> > > > On Tue, Sep 16, 2014 at 1:52 PM, Mika Westerberg
> > > > <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > > > 
> > > > > Some drivers need to deal with only firmware representation of its
> > > > > GPIOs. An example would be a GPIO button array driver where each button
> > > > > is described as a separate firmware node in device tree. Typically these
> > > > > child nodes do not have physical representation in the Linux device
> > > > > model.
> > > > >
> > > > > In order to help device drivers to handle such firmware child nodes we
> > > > > add dev[m]_node_get_named_gpiod() that takes a firmware node pointer as
> > > > > parameter, finds the GPIO using whatever is the underlying firmware
> > > > > method, and requests the GPIO properly.
> > > > >
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > > 
> > > > I have a hard time figuring out if this is what we want for common
> > > > accessors between DT and ACPI.
> > > > 
> > > > Can I get some input from Grant, Arnd, Mark, Darren...?
> > > 
> > > I just took a brief look at this. My first impression is that the
> > > fw_dev_node structure is weird when all callers just do (in patch 2)
> > > 
> > > +	struct fw_dev_node fdn = {
> > > +		.of_node = dev->of_node,
> > > +		.acpi_node = ACPI_COMPANION(dev),
> > > +	};
> > > 
> > > I'd much rather see an interface that passes the 'struct device'
> > > pointer down to dev_get_named_gpiod() and all other exported
> > > functions, and then internally does the conversion at the point
> > > where the access is done.
> > 
> > Problem is that if you don't have the dev pointer in the first place.
> > Please look how leds-gpio.c or gpio_keys_polled.c are using this.
> > 
> > Of course you have the first level device but when you need to iterate
> > "leds" or "buttons" below where there is no Linux device available we
> > need something like this.
> 
> Maybe we should be passing the parent/owner device to the iterator
> functions?

Yes, we can do that.  That's one alternative for what we have in the current
set.

Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
