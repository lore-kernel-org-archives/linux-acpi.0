From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 0/5] ACPI / scan: Make it possible to use the container
 hotplug with other scan handlers
Date: Wed, 19 Jun 2013 17:22:04 -0600
Message-ID: <1371684124.8433.2.camel@misato.fc.hp.com>
References: <1417592.vuSG0cUIGo@vostro.rjw.lan>
	 <3321228.vG97AE80O6@vostro.rjw.lan>
	 <CA+8MBbLS9suFc4gdjbb1RQdYmEyNUUHhEKgSjMxJpQLcPPYN2g@mail.gmail.com>
	 <11631311.zzmyWFE0GU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:4888 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934170Ab3FSXWY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2013 19:22:24 -0400
In-Reply-To: <11631311.zzmyWFE0GU@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tony Luck <tony.luck@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Lu, Aaron" <aaron.lu@intel.com>

On Thu, 2013-06-20 at 00:24 +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 19, 2013 10:37:27 AM Tony Luck wrote:
> > > Can you please apply the appended patch on top of it and see if the system
> > > still works then?
> > 
> > Still works with this patch.
> 
> Cool, thanks! :-)
> 
> If you don't mind, I'll queue up https://patchwork.kernel.org/patch/2712741/ and
> this for 3.11.

For both patches:

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi


> 
> Thanks,
> Rafael
> 
> 
> > > ---
> > >  drivers/acpi/scan.c  |    3 +++
> > >  drivers/acpi/video.c |    3 ---
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > Index: linux-pm/drivers/acpi/scan.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/acpi/scan.c
> > > +++ linux-pm/drivers/acpi/scan.c
> > > @@ -939,6 +939,9 @@ static int acpi_device_probe(struct devi
> > >         struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
> > >         int ret;
> > >
> > > +       if (acpi_dev->handler)
> > > +               return -EINVAL;
> > > +
> > >         if (!acpi_drv->ops.add)
> > >                 return -ENOSYS;
> > >
> > > Index: linux-pm/drivers/acpi/video.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/acpi/video.c
> > > +++ linux-pm/drivers/acpi/video.c
> > > @@ -1722,9 +1722,6 @@ static int acpi_video_bus_add(struct acp
> > >         int error;
> > >         acpi_status status;
> > >
> > > -       if (device->handler)
> > > -               return -EINVAL;
> > > -
> > >         status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
> > >                                 device->parent->handle, 1,
> > >                                 acpi_video_bus_match, NULL,
> > >


