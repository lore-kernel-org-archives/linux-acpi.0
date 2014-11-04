From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v6 02/12] Driver core: Unified device properties interface for platform firmware
Date: Tue, 04 Nov 2014 17:20:06 +0100
Message-ID: <1582415.u6tVhgLb2d@vostro.rjw.lan>
References: <13750506.S2yVlRRDa2@vostro.rjw.lan> <2127128.VT1Iq03xz1@vostro.rjw.lan> <20141104155112.6FC67C423D0@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141104155112.6FC67C423D0-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Darren Hart <darren.hart-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, November 04, 2014 03:51:12 PM Grant Likely wrote:
> On Tue, 21 Oct 2014 23:15:50 +0200
> , "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>  wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > Add a uniform interface by which device drivers can request device
> > properties from the platform firmware by providing a property name
> > and the corresponding data type.  The purpose of it is to help to
> > write portable code that won't depend on any particular platform
> > firmware interface.
> > 
> > The following general helper functions are added:
> > 
> > device_property_present()
> > device_property_read_u8()
> > device_property_read_u16()
> > device_property_read_u32()
> > device_property_read_u64()
> > device_property_read_string()
> > device_property_read_u8_array()
> > device_property_read_u16_array()
> > device_property_read_u32_array()
> > device_property_read_u64_array()
> > device_property_read_string_array()
> > 
> > The first one allows the caller to check if the given property is
> > present.  The next 5 of them allow single-valued properties of
> > various types to be retrieved in a uniform way.  The remaining 5 are
> > for reading properties with multiple values (arrays of either numbers
> > or strings).
> > 
> > The interface covers both ACPI and Device Trees.
> > 
> > This change set includes material from Mika Westerberg and Aaron Lu.
> > 
> > Signed-off-by: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> > 
> > Changes from v5:
> > - acpi_dev_prop_read() can now handle both list (package) and single-value
> >   properties (the latter are tried first for the last argument equal to 1).
> > - There is a new macro to generate the bodies of device_property_read_u*_array().
> > - device_property_read_u*() are implemented using device_property_read_u*_array().
> > - device_property_read_bool() is a new static inline wrapper around
> >   device_property_present().
> > 
> > ---
> >  drivers/acpi/property.c  |  178 +++++++++++++++++++++++++++++++++++
> >  drivers/base/Makefile    |    2 
> >  drivers/base/property.c  |  233 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/of/base.c        |  106 ++++++++++++++++++---
> >  include/linux/acpi.h     |   32 ++++++
> >  include/linux/of.h       |   22 ++++
> >  include/linux/property.h |   53 ++++++++++
> >  7 files changed, 609 insertions(+), 17 deletions(-)
> >  create mode 100644 drivers/base/property.c
> >  create mode 100644 include/linux/property.h
> > 
> > Index: linux-pm/include/linux/property.h
> > ===================================================================
> > --- /dev/null
> > +++ linux-pm/include/linux/property.h
> > @@ -0,0 +1,53 @@
> > +/*
> > + * property.h - Unified device property interface.
> > + *
> > + * Copyright (C) 2014, Intel Corporation
> > + * Authors: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > + *          Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef _LINUX_PROPERTY_H_
> > +#define _LINUX_PROPERTY_H_
> > +
> > +#include <linux/types.h>
> > +
> > +struct device;
> > +
> > +enum dev_prop_type {
> > +	DEV_PROP_U8,
> > +	DEV_PROP_U16,
> > +	DEV_PROP_U32,
> > +	DEV_PROP_U64,
> > +	DEV_PROP_STRING,
> > +	DEV_PROP_MAX,
> > +};
> > +
> > +bool device_property_present(struct device *dev, const char *propname);
> > +int device_property_read_u8_array(struct device *dev, const char *propname,
> > +				  u8 *val, size_t nval);
> > +int device_property_read_u16_array(struct device *dev, const char *propname,
> > +				   u16 *val, size_t nval);
> > +int device_property_read_u32_array(struct device *dev, const char *propname,
> > +				   u32 *val, size_t nval);
> > +int device_property_read_u64_array(struct device *dev, const char *propname,
> > +				   u64 *val, size_t nval);
> > +int device_property_read_string_array(struct device *dev, const char *propname,
> > +				      char **val, size_t nval);
> 
> I'm not sure if I asked this elsewhere. Can 'val' be made a const char **?

You did. :-)

I have a new version of the patch with that change.  I'll send it in a while.

Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
