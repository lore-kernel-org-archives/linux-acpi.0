From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH v2 07/16] gpio: Add support for unified device properties interface
Date: Wed, 24 Sep 2014 09:55:12 +0200
Message-ID: <4515093.TGIQh7cBOD@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <2809308.3y5s7TV5Ip@wuerfel> <1579761.oeYleOAY1N@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1579761.oeYleOAY1N-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 23 September 2014 22:47:36 Rafael J. Wysocki wrote:
> Quite frankly, I'm not sure what you're asking for.
> 
> It seems to mean "I kind of don't like the current implementation", but
> then the last part is quite unclear to me.  Are you suggesting to add more
> "if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) etc" type of checks to
> device drivers?  That I'd like to avoid to be honest.

No, that is not what I want. Device drivers should ideally call interfaces
that just take a 'struct device' or 'struct platform_device' pointer,
and those should be implemented in an appropriate way.

> Instead of the current proposal we can introduce something like
> 
> int device_get_child_property(struct device *dev, void *child_node,
>                               const char *propname, void **valptr);
> 
> (and analogously for device_read_property*) and use that in the drivers that
> need to iterate over child nodes of a device.  Quite along the lines of what
> Dmitry is suggesting.
> 
> Then, fn() in acpi_for_each_child_node() (and the of_ counterpart of it)
> would become
> 
> int (*fn)(struct device *dev, void *child_node, void *data)
> 
> and so on.
> 
> Would you prefer that?

I must still be missing part of what you are trying to achieve above.
We definitely need an interface to get properties from the device itself,
like

int device_get_property(struct device *dev, const char *propname, void **valptr);

(whatever valptr ends up being, that would be a separate discussion).

As soon as it comes to devices that have child nodes, I don't see a
necessity to have a generic abstraction for them, as this is typically
only done for some of the more obscure bindings, or for child nodes that
are defined in a subsystem-wide binding rather than a device private
binding.

For the former case, I think they are indeed better left in drivers that
actively know the difference between DT and ACPI, and that don't necessarily
use the same binding for both. In the latter case, I'd leave the
implementation up to subsystem code, which again would know what
interface it is using.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
