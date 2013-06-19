From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/5] ACPI / scan: Make it possible to use the container hotplug with other scan handlers
Date: Thu, 20 Jun 2013 00:24:11 +0200
Message-ID: <11631311.zzmyWFE0GU@vostro.rjw.lan>
References: <1417592.vuSG0cUIGo@vostro.rjw.lan> <3321228.vG97AE80O6@vostro.rjw.lan> <CA+8MBbLS9suFc4gdjbb1RQdYmEyNUUHhEKgSjMxJpQLcPPYN2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+8MBbLS9suFc4gdjbb1RQdYmEyNUUHhEKgSjMxJpQLcPPYN2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Toshi Kani <toshi.kani@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Lu, Aaron" <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 19, 2013 10:37:27 AM Tony Luck wrote:
> > Can you please apply the appended patch on top of it and see if the system
> > still works then?
> 
> Still works with this patch.

Cool, thanks! :-)

If you don't mind, I'll queue up https://patchwork.kernel.org/patch/2712741/ and
this for 3.11.

Thanks,
Rafael


> > ---
> >  drivers/acpi/scan.c  |    3 +++
> >  drivers/acpi/video.c |    3 ---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -939,6 +939,9 @@ static int acpi_device_probe(struct devi
> >         struct acpi_driver *acpi_drv = to_acpi_driver(dev->driver);
> >         int ret;
> >
> > +       if (acpi_dev->handler)
> > +               return -EINVAL;
> > +
> >         if (!acpi_drv->ops.add)
> >                 return -ENOSYS;
> >
> > Index: linux-pm/drivers/acpi/video.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/video.c
> > +++ linux-pm/drivers/acpi/video.c
> > @@ -1722,9 +1722,6 @@ static int acpi_video_bus_add(struct acp
> >         int error;
> >         acpi_status status;
> >
> > -       if (device->handler)
> > -               return -EINVAL;
> > -
> >         status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
> >                                 device->parent->handle, 1,
> >                                 acpi_video_bus_match, NULL,
> >
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
