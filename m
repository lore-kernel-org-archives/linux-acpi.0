Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819335C182;
	Wed, 18 Mar 2026 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834670; cv=none; b=VughkQQ0Ovn/SuRMTNwXn9bU21fdffDUdnGHaA7RizwUEYklsIdll46X2Ev2APUNNvx0IhRKqIGH7t6wASC3lMlKB/d5fi0Lwl8Dfh6uPaky9O1S9ttAa+NqYUq92GT5BJ9nk+A+sbEPUuqcFruHkTWagcptHrYnu29r9oX9OHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834670; c=relaxed/simple;
	bh=f26xWHULYockFe1onB3qmZedGxfuxlxoDt7B2ycCQD4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q0MfDdwtKEDJLhMG4jJgK1nRQbiTOm6QYFJ3JPOVYb3MKnfCX7jJBkYpF5EXTLfggVHJCqxaNJOvrJ+H2qjTMuyXtbqzVGe3VuU5c97pGLXuXPNeUtw/ucG4ghD+ASN7GUhUKdb13kaiaDmAm2Aak81PDEl8CLqEhU78MzyVMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tiz/EUmV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tiz/EUmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773834669; x=1805370669;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=f26xWHULYockFe1onB3qmZedGxfuxlxoDt7B2ycCQD4=;
  b=Tiz/EUmVu3FM+ForuNbmSABqp17n5A8PyAdXcY5pbv5ar25hosacw/Cf
   NiqOkm92qvv+WbPBC8xcQE+O+nLXTNcsNMjLOmsPTUQrYmhsQyXBIzB9R
   NXydcKFNvsxByKVQeecTD/A9bOXa8qnysMePTBDlA+HcHadvtoV//wJKL
   WnolfcomU9l7HMEDjhMkKRlE4Gg7R2fYiHohlBcUP0gEm0rADPc63jZxh
   +zAMYuRfI2vrqkpYTvrUqx8ySbrBQnHrroWyNJb7gjTQyJimVLLD1Bi8c
   DA4OmLlv0+jkCJiaBghzjPIsViKOrACtQ5EymJM1alaHJAn8Amgr6hMgY
   w==;
X-CSE-ConnectionGUID: VpALccExTgSa5ay2nnDI5g==
X-CSE-MsgGUID: L0DlFrkESlmLKcIRdddu1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74772042"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74772042"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 04:51:08 -0700
X-CSE-ConnectionGUID: Q4DjpcS/TGq+xiklhpK5VA==
X-CSE-MsgGUID: 653yr+vfTDGPhrVNtXoSVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227543876"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 04:51:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Mar 2026 13:51:02 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Jeremy Soller <jeremy@system76.com>, 
    System76 Product Development <productdev@system76.com>
Subject: Re: [PATCH v1 2/2] platform/x86: system76: Convert ACPI driver to
 a platform one
In-Reply-To: <CAJZ5v0h4w1=1LGHR6J5=yu7MjV_z27e3GXOBq8yjH2uNSBxmBQ@mail.gmail.com>
Message-ID: <c674edfd-d4ef-c135-2497-0d13b2a29a8c@linux.intel.com>
References: <2841136.mvXUDI8C0e@rafael.j.wysocki> <1968431.tdWV9SEqCh@rafael.j.wysocki> <e8b58f60-2741-c259-9882-78a9d3c8f50b@linux.intel.com> <CAJZ5v0h4w1=1LGHR6J5=yu7MjV_z27e3GXOBq8yjH2uNSBxmBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1799912248-1773833762=:971"
Content-ID: <c1c88d36-b58b-0aa5-4c3f-c9e44cdd96ef@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1799912248-1773833762=:971
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7723c94b-5bff-5b5d-7c1e-ec2b8952f24a@linux.intel.com>

On Tue, 17 Mar 2026, Rafael J. Wysocki wrote:

> On Tue, Mar 17, 2026 at 6:48=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Thu, 12 Mar 2026, Rafael J. Wysocki wrote:
> >
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > In all cases in which a struct acpi_driver is used for binding a driv=
er
> > > to an ACPI device object, a corresponding platform device is created =
by
> > > the ACPI core and that device is regarded as a proper representation =
of
> > > underlying hardware.  Accordingly, a struct platform_driver should be
> > > used by driver code to bind to that device.  There are multiple reaso=
ns
> > > why drivers should not bind directly to ACPI device objects [1].
> > >
> > > Overall, it is better to bind drivers to platform devices than to the=
ir
> > > ACPI companions, so convert the System76 ACPI driver to a platform on=
e.
> > >
> > > After this change, the subordinate hwmon, input and LED class devices
> > > will be registered under the platform device used for driver binding
> > > instead of its ACPI companion.
> > >
> > > While this is not expected to alter functionality, it changes sysfs
> > > layout and so it will be visible to user space.
> > >
> > > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki=
/ [1]
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/platform/x86/system76_acpi.c | 52 +++++++++++++++-----------=
--
> > >  1 file changed, 27 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/=
x86/system76_acpi.c
> > > index 35e294a55fa3..b3a4254156ae 100644
> > > --- a/drivers/platform/x86/system76_acpi.c
> > > +++ b/drivers/platform/x86/system76_acpi.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/leds.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pci_ids.h>
> > > +#include <linux/platform_device.h>
> > >  #include <linux/power_supply.h>
> > >  #include <linux/sysfs.h>
> > >  #include <linux/types.h>
> > > @@ -670,16 +671,19 @@ static void system76_notify(acpi_handle handle,=
 u32 event, void *context)
> > >       }
> > >  }
> > >
> > > -// Add a System76 ACPI device
> > > -static int system76_add(struct acpi_device *acpi_dev)
> > > +// Probe a System76 platform device
> > > +static int system76_probe(struct platform_device *pdev)
> > >  {
> > > +     struct acpi_device *acpi_dev =3D ACPI_COMPANION(&pdev->dev);
> > >       struct system76_data *data;
> > >       int err;
> > >
> > > -     data =3D devm_kzalloc(&acpi_dev->dev, sizeof(*data), GFP_KERNEL=
);
> > > +     data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > >       if (!data)
> > >               return -ENOMEM;
> > > -     acpi_dev->driver_data =3D data;
> > > +
> > > +     platform_set_drvdata(pdev, data);
> > > +
> > >       data->acpi_dev =3D acpi_dev;
> > >
> > >       // Some models do not run open EC firmware. Check for an ACPI m=
ethod
> > > @@ -695,7 +699,7 @@ static int system76_add(struct acpi_device *acpi_=
dev)
> > >       data->ap_led.brightness_set_blocking =3D ap_led_set;
> > >       data->ap_led.max_brightness =3D 1;
> > >       data->ap_led.default_trigger =3D "rfkill-none";
> > > -     err =3D devm_led_classdev_register(&acpi_dev->dev, &data->ap_le=
d);
> > > +     err =3D devm_led_classdev_register(&pdev->dev, &data->ap_led);
> > >       if (err)
> > >               return err;
> > >
> > > @@ -739,19 +743,19 @@ static int system76_add(struct acpi_device *acp=
i_dev)
> > >       }
> > >
> > >       if (data->kbled_type !=3D KBLED_NONE) {
> > > -             err =3D devm_led_classdev_register(&acpi_dev->dev, &dat=
a->kb_led);
> > > +             err =3D devm_led_classdev_register(&pdev->dev, &data->k=
b_led);
> > >               if (err)
> > >                       return err;
> > >       }
> > >
> > > -     data->input =3D devm_input_allocate_device(&acpi_dev->dev);
> > > +     data->input =3D devm_input_allocate_device(&pdev->dev);
> > >       if (!data->input)
> > >               return -ENOMEM;
> > >
> > >       data->input->name =3D "System76 ACPI Hotkeys";
> > >       data->input->phys =3D "system76_acpi/input0";
> > >       data->input->id.bustype =3D BUS_HOST;
> > > -     data->input->dev.parent =3D &acpi_dev->dev;
> > > +     data->input->dev.parent =3D &pdev->dev;
> > >       input_set_capability(data->input, EV_KEY, KEY_SCREENLOCK);
> > >
> > >       err =3D input_register_device(data->input);
> > > @@ -767,7 +771,7 @@ static int system76_add(struct acpi_device *acpi_=
dev)
> > >               if (err)
> > >                       goto error;
> > >
> > > -             data->therm =3D devm_hwmon_device_register_with_info(&a=
cpi_dev->dev,
> > > +             data->therm =3D devm_hwmon_device_register_with_info(&p=
dev->dev,
> > >                       "system76_acpi", data, &thermal_chip_info, NULL=
);
> > >               err =3D PTR_ERR_OR_ZERO(data->therm);
> > >               if (err)
> > > @@ -795,14 +799,13 @@ static int system76_add(struct acpi_device *acp=
i_dev)
> > >       return err;
> > >  }
> > >
> > > -// Remove a System76 ACPI device
> > > -static void system76_remove(struct acpi_device *acpi_dev)
> > > +// Remove a System76 platform device
> > > +static void system76_remove(struct platform_device *pdev)
> > >  {
> > > -     struct system76_data *data;
> > > -
> > > -     acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY, sy=
stem76_notify);
> > > +     struct system76_data *data =3D platform_get_drvdata(pdev);
> > >
> > > -     data =3D acpi_driver_data(acpi_dev);
> > > +     acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
> > > +                                    ACPI_DEVICE_NOTIFY, system76_not=
ify);
> > >
> > >       if (data->has_open_ec) {
> > >               system76_battery_exit();
> > > @@ -810,22 +813,21 @@ static void system76_remove(struct acpi_device =
*acpi_dev)
> > >               kfree(data->ntmp);
> > >       }
> > >
> > > -     devm_led_classdev_unregister(&acpi_dev->dev, &data->ap_led);
> > > -     devm_led_classdev_unregister(&acpi_dev->dev, &data->kb_led);
> > > +     devm_led_classdev_unregister(&pdev->dev, &data->ap_led);
> > > +     devm_led_classdev_unregister(&pdev->dev, &data->kb_led);
> >
> > With devm_* being used, why are these needed?
>=20
> I just preserved the existing pattern.  I can remove it, but that
> would be a separate patch, wouldn't it?

Yes, to own patch.

--=20
 i.
--8323328-1799912248-1773833762=:971--
