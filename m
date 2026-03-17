Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D53C6A2F;
	Tue, 17 Mar 2026 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752270; cv=none; b=jTZ0kbY93VWRHCWGiQoMkTdBNEfCu8kdynZEDfrWqUMpW+mvZfQIgmObB8H1mBmOwtJ+ENeiP0lC1utll0L9+9icXOPeNyo/RpkNfwG8/kX35ihsunR5OAA9SPEmgqionXS0XFfSAqqxPyS/z6ZoXmJ/OG0Hj+hFC/x3veNutbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752270; c=relaxed/simple;
	bh=FbJ7c4iwcopllWjOlvtxH8DQBKoPbxCrLpk6rel/K4k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MmKtI8whtnIx59kJ4M2z3lDdTTNs1ZwJdLb6VI59JpvaO3zxZCJds8rg6CS6DdabRDjtnC4phkQw/BlO9ezU56YKkHSUldqnlPV4vb2B6vnghGp7B/uBCZXcWsoyMNTJz/T3LF8o3rpmf8DB9NL/TxW7aQVGi/SQPIPZArTWFDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FguSzk5X; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FguSzk5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773752268; x=1805288268;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FbJ7c4iwcopllWjOlvtxH8DQBKoPbxCrLpk6rel/K4k=;
  b=FguSzk5XZcYUpehchEvCN6O6PYQn/VIBLsw5SwLk1RwIo9co5LXn/rql
   e2TYURT9AAMwRXLf/0kfiArORZzs2bHTkGR7fION6MbNnJKS7+3QdnUjF
   gKOqhZ13XBFsePYdIPgSwGss7ryiiOY6wwyxh+2PhWYjzcpkxEMxHQzYz
   bBZT6FITZhxkDFMZZg4wbtZ4cmu+No8yWm691ze9SiYuaF26zJf4cF5ZP
   8YT/GiRo+Fi8wUdpCvaWPq3LTL9I8QjB0gMYbys4LWjPorKaYI8Ips1VN
   plRhx7d05l4OsyigqmCN22OJxsksS0CHHXvQx2omW03Yc5neJ2K0mkO+U
   g==;
X-CSE-ConnectionGUID: Lya9X7CHT4yLHcREtiIT3A==
X-CSE-MsgGUID: VMqpHHOJQfK6IIcXiaP4Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92352958"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92352958"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:57:48 -0700
X-CSE-ConnectionGUID: 5tGxZQPrRtqcdaRHVPdnyw==
X-CSE-MsgGUID: zUIy6ZbTRVajxcLsLswL8g==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 05:57:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 14:57:41 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Mattia Dongili <malattia@linux.it>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1] sonypi: Convert ACPI driver to a platform one
In-Reply-To: <CAJZ5v0j5bhEHau2siLmeBxX-X9yxxT9x6oH8AsCXF+G0B+srtA@mail.gmail.com>
Message-ID: <d861dd72-b2cb-8e48-9ce6-439de54c2528@linux.intel.com>
References: <2277493.Mh6RI2rZIc@rafael.j.wysocki> <CAJZ5v0j5bhEHau2siLmeBxX-X9yxxT9x6oH8AsCXF+G0B+srtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1451419179-1773752261=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1451419179-1773752261=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 13 Mar 2026, Rafael J. Wysocki wrote:

> On Mon, Feb 23, 2026 at 4:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
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
> > ACPI companions, so convert the sonypi ACPI driver to a platform one.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
> >
> > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ =
[1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/char/sonypi.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
> > index 677bb5ac950a..ccda997a9098 100644
> > --- a/drivers/char/sonypi.c
> > +++ b/drivers/char/sonypi.c
> > @@ -1115,15 +1115,17 @@ static int sonypi_disable(void)
> >  }
> >
> >  #ifdef CONFIG_ACPI
> > -static int sonypi_acpi_add(struct acpi_device *device)
> > +static int sonypi_acpi_probe(struct platform_device *pdev)
> >  {
> > +       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> > +
> >         sonypi_acpi_device =3D device;
> >         strcpy(acpi_device_name(device), "Sony laptop hotkeys");
> >         strcpy(acpi_device_class(device), "sony/hotkey");
> >         return 0;
> >  }
> >
> > -static void sonypi_acpi_remove(struct acpi_device *device)
> > +static void sonypi_acpi_remove(struct platform_device *pdev)
> >  {
> >         sonypi_acpi_device =3D NULL;
> >  }
> > @@ -1133,13 +1135,12 @@ static const struct acpi_device_id sonypi_devic=
e_ids[] =3D {
> >         {"", 0},
> >  };
> >
> > -static struct acpi_driver sonypi_acpi_driver =3D {
> > -       .name           =3D "sonypi",
> > -       .class          =3D "hkey",
> > -       .ids            =3D sonypi_device_ids,
> > -       .ops            =3D {
> > -                          .add =3D sonypi_acpi_add,
> > -                          .remove =3D sonypi_acpi_remove,
> > +static struct platform_driver sonypi_acpi_driver =3D {
> > +       .probe =3D sonypi_acpi_probe,
> > +       .remove =3D sonypi_acpi_remove,
> > +       .driver =3D {
> > +               .name =3D "sonypi_acpi",
> > +               .acpi_match_table =3D sonypi_device_ids,
> >         },
> >  };
> >  #endif
> > @@ -1518,8 +1519,8 @@ static int __init sonypi_init(void)
> >                 goto err_free_device;
> >
> >  #ifdef CONFIG_ACPI
> > -       if (acpi_bus_register_driver(&sonypi_acpi_driver) >=3D 0)
> > -               acpi_driver_registered =3D 1;
> > +       error =3D platform_driver_register(&sonypi_acpi_driver);
> > +       acpi_driver_registered =3D !error;
> >  #endif
> >
> >         return 0;
> > @@ -1535,7 +1536,7 @@ static void __exit sonypi_exit(void)
> >  {
> >  #ifdef CONFIG_ACPI
> >         if (acpi_driver_registered)
> > -               acpi_bus_unregister_driver(&sonypi_acpi_driver);
> > +               platform_driver_unregister(&sonypi_acpi_driver);
> >  #endif
> >         platform_device_unregister(sonypi_platform_device);
> >         platform_driver_unregister(&sonypi_driver);
> > --
>=20
>=20
> If anyone has any objections or  concerns regarding this change,
> please let me know.
>=20
> In the absence of any, I'll queue it up for 7.1.

I did check it earlier, it seemed fine to me.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1451419179-1773752261=:968--
