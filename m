Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C53D5223;
	Tue, 31 Mar 2026 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944896; cv=none; b=ZYj/8tI/qjisoCZQX0S9VH5S0cQ7mtbsvRbAipJd+xmuK2elPkvuCYnH9Au/Shj2D9oT+9f2pOyUkfUeHWKx4II7ukz735EbaD8mVPj6PgBCPuyWZq+T2mUq8CvQdxJVzmLDRH4SUlTV+v66ZpC0QBc19GWrdMRJEuBZbMjAY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944896; c=relaxed/simple;
	bh=EUOfMn3i8PYdmxrl9U41WAyHnfeASPxAcwWCQdzCdO8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LQpnrm4/r7hwmdmZQsXKD7izUvU0jVCy11u+09bytjugDbbl0FACd/VsAZW6UJV4IsjIP8TsSsCaNvGQjFSk1umceo2SFlO/4helHlPObb2W5QMNwq9dmEj2R20QLMEpiwWwIR3ykORz0LQIw8Gil04GyxD3bz651d33RnetCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ua6ErTQ/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ua6ErTQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774944895; x=1806480895;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EUOfMn3i8PYdmxrl9U41WAyHnfeASPxAcwWCQdzCdO8=;
  b=Ua6ErTQ/6/c/4wuTi5PF0mNAkJ7F1FVM7d8v3Q1GBJgnw1Onc+mZWvOt
   S8DTVKrPETYqWdW4c11D8QSuzdNc/N5wdMYg9Y5QElOSAd9KzSp4i15b3
   Zs+HqVM0lZduGg+JhHo6AOeCzfxau4w8vXDsnbPAnL1MTBI59FTEAQ9HT
   KtCFIcVpcR6HZ3vNKfC8wivkxBmhPHxIy5nfzLk5ZOg75tUOGOzurky2U
   5mS++Bljr9VIIzplIr+jgUBNR3nQxufxjC+3jtQldyVtgaJy90th3MYdw
   hbegwOlYwu72xpHw6ipwj4A6/0n/rfIYIsGSTysAuLPE15Amh4+737f8/
   A==;
X-CSE-ConnectionGUID: PmzIRh+MQpWTfLssaIMhyw==
X-CSE-MsgGUID: rRlApA6pQZa/syQEddS4IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="78542760"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="78542760"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:14:54 -0700
X-CSE-ConnectionGUID: bhg0tPm2Q7qhRNRKLtcsKw==
X-CSE-MsgGUID: ZxoxtCoxSMyrqrx5TOG+Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="227904238"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:14:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 31 Mar 2026 11:14:47 +0300 (EEST)
To: Denis Benato <denis.benato@linux.dev>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, 
    =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: [PATCH v1 2/4] platform/x86: asus-laptop: Convert ACPI driver
 to a platform one
In-Reply-To: <c9697592-c70b-4ef8-864f-213b5ea4782d@linux.dev>
Message-ID: <d42eed14-b6b1-b8f4-b73a-6033162e79e7@linux.intel.com>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki> <2402539.ElGaqSPkdT@rafael.j.wysocki> <c9697592-c70b-4ef8-864f-213b5ea4782d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1298281981-1774944887=:989"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1298281981-1774944887=:989
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 28 Feb 2026, Denis Benato wrote:
> On 2/28/26 16:11, Rafael J. Wysocki wrote:
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
> > ACPI companions, so convert the Asus laptop ACPI driver to a platform
> > one.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
>
> Alright I will take a look if asus-linux software is affected and act acc=
ordingly.
> How much time do I have?
>=20
> Thanks.=C2=A0

Hi Denis,

Has there been some progress with this check?

--
 i.

> > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ =
[1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Denis Benato <denis.benato@linux.dev>
> > ---
> >  drivers/platform/x86/asus-laptop.c | 35 +++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/=
asus-laptop.c
> > index c927665dfa96..dbbb6292cd11 100644
> > --- a/drivers/platform/x86/asus-laptop.c
> > +++ b/drivers/platform/x86/asus-laptop.c
> > @@ -1824,8 +1824,9 @@ static void asus_dmi_check(void)
> > =20
> >  static bool asus_device_present;
> > =20
> > -static int asus_acpi_add(struct acpi_device *device)
> > +static int asus_acpi_probe(struct platform_device *pdev)
> >  {
> > +=09struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> >  =09struct asus_laptop *asus;
> >  =09int result;
> > =20
> > @@ -1837,7 +1838,6 @@ static int asus_acpi_add(struct acpi_device *devi=
ce)
> >  =09asus->handle =3D device->handle;
> >  =09strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
> >  =09strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
> > -=09device->driver_data =3D asus;
> >  =09asus->device =3D device;
> > =20
> >  =09asus_dmi_check();
> > @@ -1846,6 +1846,8 @@ static int asus_acpi_add(struct acpi_device *devi=
ce)
> >  =09if (result)
> >  =09=09goto fail_platform;
> > =20
> > +=09platform_set_drvdata(pdev, asus);
> > +
> >  =09/*
> >  =09 * Need platform type detection first, then the platform
> >  =09 * device.  It is used as a parent for the sub-devices below.
> > @@ -1907,11 +1909,12 @@ static int asus_acpi_add(struct acpi_device *de=
vice)
> >  =09return result;
> >  }
> > =20
> > -static void asus_acpi_remove(struct acpi_device *device)
> > +static void asus_acpi_remove(struct platform_device *pdev)
> >  {
> > -=09struct asus_laptop *asus =3D acpi_driver_data(device);
> > +=09struct asus_laptop *asus =3D platform_get_drvdata(pdev);
> > =20
> > -=09acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, asus_acp=
i_notify);
> > +=09acpi_dev_remove_notify_handler(asus->device, ACPI_DEVICE_NOTIFY,
> > +=09=09=09=09       asus_acpi_notify);
> >  =09asus_backlight_exit(asus);
> >  =09asus_rfkill_exit(asus);
> >  =09asus_led_exit(asus);
> > @@ -1930,15 +1933,13 @@ static const struct acpi_device_id asus_device_=
ids[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(acpi, asus_device_ids);
> > =20
> > -static struct acpi_driver asus_acpi_driver =3D {
> > -=09.name =3D ASUS_LAPTOP_NAME,
> > -=09.class =3D ASUS_LAPTOP_CLASS,
> > -=09.ids =3D asus_device_ids,
> > -=09.flags =3D ACPI_DRIVER_ALL_NOTIFY_EVENTS,
> > -=09.ops =3D {
> > -=09=09.add =3D asus_acpi_add,
> > -=09=09.remove =3D asus_acpi_remove,
> > -=09=09},
> > +static struct platform_driver asus_acpi_driver =3D {
> > +=09.probe =3D asus_acpi_probe,
> > +=09.remove =3D asus_acpi_remove,
> > +=09.driver =3D {
> > +=09=09.name =3D ASUS_LAPTOP_NAME,
> > +=09=09.acpi_match_table =3D asus_device_ids,
> > +=09},
> >  };
> > =20
> >  static int __init asus_laptop_init(void)
> > @@ -1949,7 +1950,7 @@ static int __init asus_laptop_init(void)
> >  =09if (result < 0)
> >  =09=09return result;
> > =20
> > -=09result =3D acpi_bus_register_driver(&asus_acpi_driver);
> > +=09result =3D platform_driver_register(&asus_acpi_driver);
> >  =09if (result < 0)
> >  =09=09goto fail_acpi_driver;
> >  =09if (!asus_device_present) {
> > @@ -1959,7 +1960,7 @@ static int __init asus_laptop_init(void)
> >  =09return 0;
> > =20
> >  fail_no_device:
> > -=09acpi_bus_unregister_driver(&asus_acpi_driver);
> > +=09platform_driver_unregister(&asus_acpi_driver);
> >  fail_acpi_driver:
> >  =09platform_driver_unregister(&platform_driver);
> >  =09return result;
> > @@ -1967,7 +1968,7 @@ static int __init asus_laptop_init(void)
> > =20
> >  static void __exit asus_laptop_exit(void)
> >  {
> > -=09acpi_bus_unregister_driver(&asus_acpi_driver);
> > +=09platform_driver_unregister(&asus_acpi_driver);
> >  =09platform_driver_unregister(&platform_driver);
> >  }
> > =20
>=20
--8323328-1298281981-1774944887=:989--
