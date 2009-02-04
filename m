From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] RFC: ACPI: Interface for ACPI drivers to place quirk code which gets executed early
Date: Wed, 4 Feb 2009 14:37:35 +0100
Message-ID: <200902041437.40095.trenn@suse.de>
References: <20090125210520.GA12963@dreamland.darkstar.lan> <200902021822.11906.trenn@suse.de> <20090202202246.GA9023@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758469AbZBDNh5@vger.kernel.org>
In-Reply-To: <20090202202246.GA9023@dreamland.darkstar.lan>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Monday 02 February 2009 21:22:46 Luca Tettamanti wrote:
> Il Mon, Feb 02, 2009 at 06:22:10PM +0100, Thomas Renninger ha scritto:
> > These two patches are tested on a ASUS machine and worked as expected,
> > but probably may still need some cleanup.
>
> I'd keep the DMI+HID approach since it's more flexible:
> - (AFAICS) Thinkpads have different methods for hwmon depending on the
>   model and no fixed HID
> - With DMI it would be possible to include ASUS motherboards (ATK w/
>   hwmon) but exclude ASUS laptops (ATK w/o hwmon).
>
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index c54d7b6..1c25747 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/kthread.h>
> >
> >  #include <acpi/acpi_drivers.h>
> > +#include "acpi.h"
> >
> >  #define _COMPONENT		ACPI_BUS_COMPONENT
> >  ACPI_MODULE_NAME("scan");
> > @@ -1562,6 +1563,8 @@ static int __init acpi_scan_init(void)
> >
> >  	if (result)
> >  		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
> > +	else
> > +		acpi_device_quirks();
>
> Hum, it's not immediatly clear why you put that call in the else
> branch. Maybe put:
>
> if (!result)
>         acpi_device_quirks();
>
> before the cleanup?

Looking at this again (and trying to convert the video_detect things into
that) I am not sure whether this is the right place.
While I'd prefer to not touch the video_detect stuff right now because:
  - it could easily be extended to provide amount of brightness levels
    (I sent test code a while ago) to take them into account into the
    native vs ACPI driver decision.
  - Therefore it's better to let the drivers call it and not implement
    it as a standalone quirk
  - It needs the PCI subsystem initialized

Still I like my approach for the ATK (and upcoming similar?) issue(s).
I wonder whether it should be called later still.
Should this be called early, after adding the devices like above or
after PCI acpi and PNP acpi initialization?
Then it needs to be triggered by a separate fs_initcall?

     Thomas
