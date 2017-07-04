From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 1/2] acpi: thermal: initialize tz_enabled to 1
Date: Tue, 04 Jul 2017 09:43:15 +0800
Message-ID: <1499132595.2654.7.camel@intel.com>
References: <20170703080040.13750-1-enric.balletbo@collabora.com>
         <CAJZ5v0joeKd+0TC4ik23zOLKxw0F42aYeZ7XugK=1LpDae3OtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27252 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbdGDBmn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Jul 2017 21:42:43 -0400
In-Reply-To: <CAJZ5v0joeKd+0TC4ik23zOLKxw0F42aYeZ7XugK=1LpDae3OtQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>

On Mon, 2017-07-03 at 23:08 +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 3, 2017 at 10:00 AM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> > 
> > From: Sameer Nanda <snanda@chromium.org>
> > 
> > In the acpi_thermal_add path, acpi_thermal_get_info gets called
> > before
> > acpi_thermal_register_thermal_zone.  Since tz_enabled was getting
> > set to
> > 1 only in acpi_thermal_register_thermal_zone, acpi_thermal_get_info
> > ended up disabling thermal polling.
> > 
> > Moved setting of tz_enabled to 1 into acpi_thermal_add itself.
> > 
> > Signed-off-by: Sameer Nanda <snanda@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com
> > >
> > ---
> > Changes since v2:
> >  - Zhang Rui:
> >    - Make sure tz->tz_enabled is set properly before registering
> > the zone.
> > 
> > Changes since v1:
> >  - This patch is new from v1 [1]
> > 
> >  [1] https://patchwork.kernel.org/patch/9804229/
> > 
> >  drivers/acpi/thermal.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 1d0417b..cd0fe92 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -930,8 +930,6 @@ static int
> > acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
> >         if (ACPI_FAILURE(status))
> >                 return -ENODEV;
> > 
> > -       tz->tz_enabled = 1;
> > -
> >         dev_info(&tz->device->dev, "registered as
> > thermal_zone%d\n",
> >                  tz->thermal_zone->id);
> >         return 0;
> > @@ -1088,6 +1086,7 @@ static int acpi_thermal_add(struct
> > acpi_device *device)
> >                 return -ENOMEM;
> > 
> >         tz->device = device;
> > +       tz->tz_enabled = 1;
> >         strcpy(tz->name, device->pnp.bus_id);
> >         strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> >         strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> > --
> Rui,
> 
> Can I just apply this, or do I need to work for a thermal core
> update?
>  In the latter case, can you take care of this one too, please?
> 
Yes, I will take both of the patches.

thanks,
rui

> Thanks,
> Rafael
