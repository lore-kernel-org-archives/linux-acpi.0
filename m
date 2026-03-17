Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A22C234A
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774285; cv=none; b=PpXVix6OJr+IRJlOGnFc9Rr6TTocYCmAA6DcaARfRY+pLorgF5xc9tpdMM8XZoMIvh/QREl9WeGceccLkrRUPf62mtN2lTjcjM8lYuMJgNgd5H2XNwC1+rRxjv03/WwvtX2JBI2kLqtIW+isX78lHeZQ/mgp7o0yrhjG0pfMI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774285; c=relaxed/simple;
	bh=OW+S3HWLRnSCCq1bjodpLHutJNbipAf8Fx+wUhqNyNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhCH+ERYoV5Gas3BODPvsDszoOqzPEsHXrlMD6MSTZUzoDjpG01ndbO/8LA6ZWiaoOjczlsezgFdD49r+V9cRPcJsuFuoHoxypj8BEPSrjrSZ6exQ4ohG0MW+w2psyBB20SzYp98J8EffP/XtoN2R8+qdluoz54LWjtVrvm7Pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuL0gAnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuL0gAnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DA0C2BC9E
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773774285;
	bh=OW+S3HWLRnSCCq1bjodpLHutJNbipAf8Fx+wUhqNyNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HuL0gAnxk/gnRGrPxUOAq40tA3t36gLYMo3XDdGExia24NWZRv/+rS/uYuq8LvP8Z
	 eFv/pPKlaiyex4KsvSqcodxE1hJLnMkAwYHSsyOUJ/BuNCtw2wQT6uxOw0oe6d4ykT
	 ZPm6jBuOBOFxEyUKYHTLzP45Ld4/FdIDaRgv2CwKJdWlFcF0nUC4t/WMD2zu7RgsMI
	 prif/cvO1qmJhdGqP3Qbt+137tw8XIY325Ed+LMRYTLCyclprdKrwGtN/C/RAyfLhm
	 z+4TVScRTknlRLdQbrI0XyBsPf4kSPJFLjdouyYBi6A3RA7oISu+TKuSpKvZhXcWl7
	 CMtzY84s3G/LA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7422b4ff1so2665332a34.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 12:04:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwk/oXekzdKg503woTYkED70fd2rMsaW6rLh+oR9R70NbPzg6Ew3Yvd67KZNkgoxN9vWEZyCFfXIYu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr19Z9rvQ6AqPdR8kavzE125jYPmNkPI9QEubVdZHovRXE2ugJ
	kF0S0s9H2sWqgASyr0+U04ISHL9yLqT9jD7p/eRXixsmMsBkkF5YQsFs+4CrQ5OIojtbL6O+Rf/
	epwtCrBztgoEXTZqNS9niQLDqWQnWJ7k=
X-Received: by 2002:a05:6820:1ca9:b0:67b:a645:94c9 with SMTP id
 006d021491bc7-67c0dace061mr311490eaf.32.1773774284297; Tue, 17 Mar 2026
 12:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2841136.mvXUDI8C0e@rafael.j.wysocki> <1968431.tdWV9SEqCh@rafael.j.wysocki>
 <e8b58f60-2741-c259-9882-78a9d3c8f50b@linux.intel.com>
In-Reply-To: <e8b58f60-2741-c259-9882-78a9d3c8f50b@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Mar 2026 20:04:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4w1=1LGHR6J5=yu7MjV_z27e3GXOBq8yjH2uNSBxmBQ@mail.gmail.com>
X-Gm-Features: AaiRm53ozabEmJVT5IG1gJmd9Wk-iC7HO7aJaI3x7nhcDS4por8PeVcOziotlbU
Message-ID: <CAJZ5v0h4w1=1LGHR6J5=yu7MjV_z27e3GXOBq8yjH2uNSBxmBQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] platform/x86: system76: Convert ACPI driver to a
 platform one
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org, Jeremy Soller <jeremy@system76.com>, 
	System76 Product Development <productdev@system76.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 6:48=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 12 Mar 2026, Rafael J. Wysocki wrote:
>
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > In all cases in which a struct acpi_driver is used for binding a driver
> > to an ACPI device object, a corresponding platform device is created by
> > the ACPI core and that device is regarded as a proper representation of
> > underlying hardware.  Accordingly, a struct platform_driver should be
> > used by driver code to bind to that device.  There are multiple reasons
> > why drivers should not bind directly to ACPI device objects [1].
> >
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the System76 ACPI driver to a platform one.
> >
> > After this change, the subordinate hwmon, input and LED class devices
> > will be registered under the platform device used for driver binding
> > instead of its ACPI companion.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
> >
> > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ =
[1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/platform/x86/system76_acpi.c | 52 +++++++++++++++-------------
> >  1 file changed, 27 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x8=
6/system76_acpi.c
> > index 35e294a55fa3..b3a4254156ae 100644
> > --- a/drivers/platform/x86/system76_acpi.c
> > +++ b/drivers/platform/x86/system76_acpi.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/leds.h>
> >  #include <linux/module.h>
> >  #include <linux/pci_ids.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/types.h>
> > @@ -670,16 +671,19 @@ static void system76_notify(acpi_handle handle, u=
32 event, void *context)
> >       }
> >  }
> >
> > -// Add a System76 ACPI device
> > -static int system76_add(struct acpi_device *acpi_dev)
> > +// Probe a System76 platform device
> > +static int system76_probe(struct platform_device *pdev)
> >  {
> > +     struct acpi_device *acpi_dev =3D ACPI_COMPANION(&pdev->dev);
> >       struct system76_data *data;
> >       int err;
> >
> > -     data =3D devm_kzalloc(&acpi_dev->dev, sizeof(*data), GFP_KERNEL);
> > +     data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >       if (!data)
> >               return -ENOMEM;
> > -     acpi_dev->driver_data =3D data;
> > +
> > +     platform_set_drvdata(pdev, data);
> > +
> >       data->acpi_dev =3D acpi_dev;
> >
> >       // Some models do not run open EC firmware. Check for an ACPI met=
hod
> > @@ -695,7 +699,7 @@ static int system76_add(struct acpi_device *acpi_de=
v)
> >       data->ap_led.brightness_set_blocking =3D ap_led_set;
> >       data->ap_led.max_brightness =3D 1;
> >       data->ap_led.default_trigger =3D "rfkill-none";
> > -     err =3D devm_led_classdev_register(&acpi_dev->dev, &data->ap_led)=
;
> > +     err =3D devm_led_classdev_register(&pdev->dev, &data->ap_led);
> >       if (err)
> >               return err;
> >
> > @@ -739,19 +743,19 @@ static int system76_add(struct acpi_device *acpi_=
dev)
> >       }
> >
> >       if (data->kbled_type !=3D KBLED_NONE) {
> > -             err =3D devm_led_classdev_register(&acpi_dev->dev, &data-=
>kb_led);
> > +             err =3D devm_led_classdev_register(&pdev->dev, &data->kb_=
led);
> >               if (err)
> >                       return err;
> >       }
> >
> > -     data->input =3D devm_input_allocate_device(&acpi_dev->dev);
> > +     data->input =3D devm_input_allocate_device(&pdev->dev);
> >       if (!data->input)
> >               return -ENOMEM;
> >
> >       data->input->name =3D "System76 ACPI Hotkeys";
> >       data->input->phys =3D "system76_acpi/input0";
> >       data->input->id.bustype =3D BUS_HOST;
> > -     data->input->dev.parent =3D &acpi_dev->dev;
> > +     data->input->dev.parent =3D &pdev->dev;
> >       input_set_capability(data->input, EV_KEY, KEY_SCREENLOCK);
> >
> >       err =3D input_register_device(data->input);
> > @@ -767,7 +771,7 @@ static int system76_add(struct acpi_device *acpi_de=
v)
> >               if (err)
> >                       goto error;
> >
> > -             data->therm =3D devm_hwmon_device_register_with_info(&acp=
i_dev->dev,
> > +             data->therm =3D devm_hwmon_device_register_with_info(&pde=
v->dev,
> >                       "system76_acpi", data, &thermal_chip_info, NULL);
> >               err =3D PTR_ERR_OR_ZERO(data->therm);
> >               if (err)
> > @@ -795,14 +799,13 @@ static int system76_add(struct acpi_device *acpi_=
dev)
> >       return err;
> >  }
> >
> > -// Remove a System76 ACPI device
> > -static void system76_remove(struct acpi_device *acpi_dev)
> > +// Remove a System76 platform device
> > +static void system76_remove(struct platform_device *pdev)
> >  {
> > -     struct system76_data *data;
> > -
> > -     acpi_dev_remove_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY, syst=
em76_notify);
> > +     struct system76_data *data =3D platform_get_drvdata(pdev);
> >
> > -     data =3D acpi_driver_data(acpi_dev);
> > +     acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
> > +                                    ACPI_DEVICE_NOTIFY, system76_notif=
y);
> >
> >       if (data->has_open_ec) {
> >               system76_battery_exit();
> > @@ -810,22 +813,21 @@ static void system76_remove(struct acpi_device *a=
cpi_dev)
> >               kfree(data->ntmp);
> >       }
> >
> > -     devm_led_classdev_unregister(&acpi_dev->dev, &data->ap_led);
> > -     devm_led_classdev_unregister(&acpi_dev->dev, &data->kb_led);
> > +     devm_led_classdev_unregister(&pdev->dev, &data->ap_led);
> > +     devm_led_classdev_unregister(&pdev->dev, &data->kb_led);
>
> With devm_* being used, why are these needed?

I just preserved the existing pattern.  I can remove it, but that
would be a separate patch, wouldn't it?

> >       system76_get(data, "FINI");
> >  }
> >
> > -static struct acpi_driver system76_driver =3D {
> > -     .name =3D "System76 ACPI Driver",
> > -     .class =3D "hotkey",
> > -     .ids =3D device_ids,
> > -     .ops =3D {
> > -             .add =3D system76_add,
> > -             .remove =3D system76_remove,
> > +static struct platform_driver system76_driver =3D {
> > +     .probe =3D system76_probe,
> > +     .remove =3D system76_remove,
> > +     .driver =3D {
> > +             .name =3D "System76 ACPI Driver",
> > +             .acpi_match_table =3D device_ids,
> >       },
> >  };
> > -module_acpi_driver(system76_driver);
> > +module_platform_driver(system76_driver);
> >
> >  MODULE_DESCRIPTION("System76 ACPI Driver");
> >  MODULE_AUTHOR("Jeremy Soller <jeremy@system76.com>");
> >
>
> --
>  i.
>
