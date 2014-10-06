From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH v2 01/16] ACPI: Add support for device specific
 properties
Date: Mon, 6 Oct 2014 17:32:48 +0300
Message-ID: <20141006143248.GE1583@lahna.fi.intel.com>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
 <1410868367-11056-2-git-send-email-mika.westerberg@linux.intel.com>
 <20141006135021.0EB04C43FBE@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141006135021.0EB04C43FBE-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 06, 2014 at 02:50:21PM +0100, Grant Likely wrote:
> On Tue, 16 Sep 2014 14:52:32 +0300
> , Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>  wrote:
> > Device Tree is used in many embedded systems to describe the system
> > configuration to the OS. It supports attaching properties or name-value
> > pairs to the devices it describe. With these properties one can pass
> > additional information to the drivers that would not be available
> > otherwise.
> > 
> > ACPI is another configuration mechanism (among other things) typically
> > seen, but not limited to, x86 machines. ACPI allows passing arbitrary
> > data from methods but there has not been mechanism equivalent to Device
> > Tree until the introduction of _DSD in the recent publication of the
> > ACPI 5.1 specification.
> > 
> > In order to facilitate ACPI usage in systems where Device Tree is
> > typically used, it would be beneficial to standardize a way to retrieve
> > Device Tree style properties from ACPI devices, which is what we do in
> > this patch.
> > 
> > If a given device described in ACPI namespace wants to export properties it
> > must implement _DSD method (Device Specific Data, introduced with ACPI 5.1)
> > that returns the properties in a package of packages. For example:
> > 
> > 	Name (_DSD, Package () {
> > 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > 		Package () {
> > 			Package () {"name1", <VALUE1>},
> > 			Package () {"name2", <VALUE2>},
> > 			...
> > 		}
> > 	})
> > 
> > The UUID reserved for properties is daffd814-6eba-4d8c-8a91-bc9bbf4aa301
> > and is documented in the ACPI 5.1 companion document called "_DSD
> > Implementation Guide" [1], [2].
> > 
> > We add several helper functions that can be used to extract these
> > properties and convert them to different Linux data types.
> > 
> > The ultimate goal is that we only have one device property API that
> > retrieves the requested properties from Device Tree or from ACPI
> > transparent to the caller.
> > 
> > [1] http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm
> > [2] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> > 
> > Reviewed-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Reviewed-by: Josh Triplett <josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org>
> > Signed-off-by: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/acpi/Makefile   |   1 +
> >  drivers/acpi/internal.h |   6 +
> >  drivers/acpi/property.c | 364 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/acpi/scan.c     |   2 +
> >  include/acpi/acpi_bus.h |   7 +
> >  include/linux/acpi.h    |  40 ++++++
> >  6 files changed, 420 insertions(+)
> >  create mode 100644 drivers/acpi/property.c
> > 
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index 505d4d79fe3e..ba2cafe18fe4 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -46,6 +46,7 @@ acpi-y				+= acpi_pnp.o
> >  acpi-y				+= power.o
> >  acpi-y				+= event.o
> >  acpi-y				+= sysfs.o
> > +acpi-y				+= property.o
> >  acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
> >  acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
> >  acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index 4c5cf77e7576..e34290c7af9f 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -181,4 +181,10 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev);
> >  bool acpi_osi_is_win8(void);
> >  #endif
> >  
> > +/*--------------------------------------------------------------------------
> > +				Device properties
> > +  -------------------------------------------------------------------------- */
> > +void acpi_init_properties(struct acpi_device *adev);
> > +void acpi_free_properties(struct acpi_device *adev);
> > +
> >  #endif /* _ACPI_INTERNAL_H_ */
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > new file mode 100644
> > index 000000000000..c4a3e800e82c
> > --- /dev/null
> > +++ b/drivers/acpi/property.c
> > @@ -0,0 +1,364 @@
> > +/*
> > + * ACPI device specific properties support.
> > + *
> > + * Copyright (C) 2014, Intel Corporation
> > + * All rights reserved.
> > + *
> > + * Authors: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > + *          Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > + *          Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/device.h>
> > +#include <linux/export.h>
> > +
> > +#include "internal.h"
> > +
> > +/* ACPI _DSD device properties UUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
> > +static const u8 prp_uuid[16] = {
> > +	0x14, 0xd8, 0xff, 0xda, 0xba, 0x6e, 0x8c, 0x4d,
> > +	0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01
> > +};
> 
> ?
> 
> What is the encoding used here? I see the first 4 bytes for "daffd814"
> encoded in little endian (0x14 first), and then the remaining values
> encoded in big-endian for each number. Is this typical for UUID values?

The buffer format is explained in ACPI 5.1 spec, page 823.

I generated the above so that I compiled a _DSD with correct UUID using
iASL and then disassambled it with the same tool.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
