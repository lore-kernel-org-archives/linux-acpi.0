Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5439A7E5;
	Tue,  7 Apr 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555365; cv=none; b=SzJsCF5zROPL+zI5pdYSMPHCPGrKJFOp8FT1R2lxCxiKbR2ffVZJ0kx4dZijPycziZWnK8viGrT5PDrzVo43Y2jonePAOUOWBzfk4i2VHY2iZI61/nJDAx1uAjtnMs7oNYDLw6Dq8lJgYHIUOIduIiG/Bb6VW39laPaOgD/y6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555365; c=relaxed/simple;
	bh=RDUqleSpjpgYZePf8Bz8VO9+1LyDG8E6th7dDGstbCo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cldCERMEmGp1StqBcTtf1rCHbb0UuYs+qrRreRSn0IzpAS3/SlqzOg2S5V1SNCPsyJRawRLR/emtTtob9/1tsb7Op9pI0YLGDUAs6VZN8w1NnRPn0+P0WpTA4v3xfvYyuKPIpKIARRga72ptDi/fREf5dRRrkJQsTDC4sDO5coI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUPFJSM9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUPFJSM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775555363; x=1807091363;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RDUqleSpjpgYZePf8Bz8VO9+1LyDG8E6th7dDGstbCo=;
  b=CUPFJSM9tj3DrIH0ei/pO3hI8m2WIC5l+B5PXmGvqmJa/7n6WGbtZgTV
   Wi/H8fNtaoZR6uy0XEeV8JvRlJ5UF7Ixoi65X6sQYQUvy8ew4Brpj+ZVb
   qQINUeAv7Q48PIboBXxvHVY6Q1PLWwNb3UeH3l7T6ojHiTSGH/voAnGiI
   xMIPZZb96XgtIhxBGNwYHOAHxFv3hAAXwZ+XVcm8IqZm4jz6lYu9P/j5s
   kJTf7UASs6MZx6ZBUGMd7PS6Vay5ZOo1EMgXJ5ddBZOjOIE2OFsAohn4j
   E7brYGX7QCr/qHq2++0mERQe/gJbqlAC0r2VDRrkL+IcthseWKISvbXSy
   g==;
X-CSE-ConnectionGUID: TkyHX+G4Te2QIx+wreNUJw==
X-CSE-MsgGUID: JZC0bhSbRO2TsR/YsdreXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="101968732"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="101968732"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 02:49:23 -0700
X-CSE-ConnectionGUID: 2FJbUA4/RQqMsNvCMWCGTQ==
X-CSE-MsgGUID: yrE75+9kS5eSwf0onIxgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="221552409"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 02:49:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Apr 2026 12:49:16 +0300 (EEST)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Denis Benato <benato.denis96@gmail.com>, 
    =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: [PATCH v1 4/4] platform/x86: asus-wireless: Convert ACPI driver
 to a platform one
In-Reply-To: <13959361.uLZWGnKmhe@rafael.j.wysocki>
Message-ID: <daa3e217-4099-7cdc-93b3-fde37864cd28@linux.intel.com>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki> <13959361.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-516245395-1775555356=:983"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-516245395-1775555356=:983
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 28 Feb 2026, Rafael J. Wysocki wrote:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
>=20
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the Asus wireless ACPI driver to a platform
> one.
>=20
> After this change, the subordinate input and LED devices will be
> registered under the platform device used for driver binding instead of
> its ACPI companion.
>=20
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>=20
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1=
]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/x86/asus-wireless.c | 39 +++++++++++++++-------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/=
asus-wireless.c
> index 45d41875c515..2b494bf3cba8 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -12,6 +12,7 @@
>  #include <linux/acpi.h>
>  #include <linux/input.h>
>  #include <linux/pci_ids.h>
> +#include <linux/platform_device.h>
>  #include <linux/leds.h>
> =20
>  struct hswc_params {
> @@ -124,19 +125,22 @@ static void asus_wireless_notify(acpi_handle handle=
, u32 event, void *context)
>  =09input_sync(data->idev);
>  }
> =20
> -static int asus_wireless_add(struct acpi_device *adev)
> +static int asus_wireless_probe(struct platform_device *pdev)
>  {
> +=09struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
>  =09struct asus_wireless_data *data;
>  =09const struct acpi_device_id *id;
>  =09int err;
> =20
> -=09data =3D devm_kzalloc(&adev->dev, sizeof(*data), GFP_KERNEL);
> +=09data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  =09if (!data)
>  =09=09return -ENOMEM;
> -=09adev->driver_data =3D data;
> +
> +=09platform_set_drvdata(pdev, data);
> +
>  =09data->adev =3D adev;
> =20
> -=09data->idev =3D devm_input_allocate_device(&adev->dev);
> +=09data->idev =3D devm_input_allocate_device(&pdev->dev);
>  =09if (!data->idev)
>  =09=09return -ENOMEM;
>  =09data->idev->name =3D "Asus Wireless Radio Control";
> @@ -165,14 +169,14 @@ static int asus_wireless_add(struct acpi_device *ad=
ev)
>  =09data->led.flags =3D LED_CORE_SUSPENDRESUME;
>  =09data->led.max_brightness =3D 1;
>  =09data->led.default_trigger =3D "rfkill-none";
> -=09err =3D devm_led_classdev_register(&adev->dev, &data->led);
> +=09err =3D devm_led_classdev_register(&pdev->dev, &data->led);
>  =09if (err)
>  =09=09goto err;
> =20
>  =09err =3D acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
>  =09=09=09=09=09      asus_wireless_notify, data);
>  =09if (err) {
> -=09=09devm_led_classdev_unregister(&adev->dev, &data->led);
> +=09=09devm_led_classdev_unregister(&pdev->dev, &data->led);

I've taken this series now into the review-ilpo-next branch.

However, here are manual devm_*() rollbacks which could probably be=20
eliminated as well but you can do them on top of this.

--
 i.

>  =09=09goto err;
>  =09}
>  =09return 0;
> @@ -182,28 +186,27 @@ static int asus_wireless_add(struct acpi_device *ad=
ev)
>  =09return err;
>  }
> =20
> -static void asus_wireless_remove(struct acpi_device *adev)
> +static void asus_wireless_remove(struct platform_device *pdev)
>  {
> -=09struct asus_wireless_data *data =3D acpi_driver_data(adev);
> +=09struct asus_wireless_data *data =3D platform_get_drvdata(pdev);
> =20
> -=09acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> +=09acpi_dev_remove_notify_handler(data->adev, ACPI_DEVICE_NOTIFY,
>  =09=09=09=09       asus_wireless_notify);
>  =09if (data->wq) {
> -=09=09devm_led_classdev_unregister(&adev->dev, &data->led);
> +=09=09devm_led_classdev_unregister(&pdev->dev, &data->led);
>  =09=09destroy_workqueue(data->wq);
>  =09}
>  }
> =20
> -static struct acpi_driver asus_wireless_driver =3D {
> -=09.name =3D "Asus Wireless Radio Control Driver",
> -=09.class =3D "hotkey",
> -=09.ids =3D device_ids,
> -=09.ops =3D {
> -=09=09.add =3D asus_wireless_add,
> -=09=09.remove =3D asus_wireless_remove,
> +static struct platform_driver asus_wireless_driver =3D {
> +=09.probe =3D asus_wireless_probe,
> +=09.remove =3D asus_wireless_remove,
> +=09.driver =3D {
> +=09=09.name =3D "Asus Wireless Radio Control Driver",
> +=09=09.acpi_match_table =3D device_ids,
>  =09},
>  };
> -module_acpi_driver(asus_wireless_driver);
> +module_platform_driver(asus_wireless_driver);
> =20
>  MODULE_DESCRIPTION("Asus Wireless Radio Control Driver");
>  MODULE_AUTHOR("Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com>");
>=20
--8323328-516245395-1775555356=:983--
